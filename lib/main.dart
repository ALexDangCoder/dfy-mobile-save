import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/strings.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/di/module.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';

MethodChannel trustWalletChannel = const MethodChannel('flutter/trust_wallet');

Future<void> mainApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await PrefsService.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final token = PrefsService.getToken();

  @override
  void initState() {
    trustWalletChannel.setMethodCallHandler(nativeMethodCallHandler);
    super.initState();
    callAllApi();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: Strings.app_name,
        theme: ThemeData(
          primaryColor: AppTheme.getInstance().primaryColor(),
          cardColor: Colors.white,
          textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
          appBarTheme: const AppBarTheme(
            color: Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          dividerColor: dividerColor,
          scaffoldBackgroundColor: Colors.white,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: AppTheme.getInstance().primaryColor(),
            selectionColor: AppTheme.getInstance().primaryColor(),
            selectionHandleColor: AppTheme.getInstance().primaryColor(),
          ),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: AppTheme.getInstance().accentColor()),
        ),
        supportedLocales: S.delegate.supportedLocales,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: Locale.fromSubtags(languageCode: PrefsService.getLanguage()),
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: AppRouter.main,
      ),
    );
  }

  Future<dynamic> nativeMethodCallHandler(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'checkPasswordCallback':
        print('1: ' + methodCall.arguments.toString());
        break;
      case 'getConfigCallback':
        print('2: ' + methodCall.arguments.toString());
        break;
      case 'importWalletCallback':
        print('3: ' + methodCall.arguments.toString());
        break;
      case 'getListWalletsCallback':
        print('4: ' + methodCall.arguments.toString());
        break;
      case 'generateWalletCallback':
        print('5: ' + methodCall.arguments.toString());
        break;
      case 'storeWalletCallback':
        print('6: ' + methodCall.arguments.toString());
        break;
      case 'setConfigCallback':
        print('7: ' + methodCall.arguments.toString());
        break;
      case 'getListShowedTokenCallback':
        print('8: ' + methodCall.arguments.toString());
        break;
      case 'getListShowedNftCallback':
        print('9: ' + methodCall.arguments.toString());
        break;
      case 'importTokenCallback':
        print('10: ' + methodCall.arguments.toString());
        break;
      case 'getListSupportedTokenCallback':
        print('11: ' + methodCall.arguments.toString());
        break;
      default:
        break;
    }
  }

  void callAllApi() {
    importWallet();
  }

  Future<void> createWallet() async {
    try {
      final data = {
        'password': 'password',
      };
      await trustWalletChannel.invokeMethod('checkPassword', data);
    } on PlatformException {}
  }

  Future<void> getConfig() async {
    try {
      await trustWalletChannel.invokeMethod('getConfig');
    } on PlatformException {}
  }

  Future<void> importWallet() async {
    try {
      final data = {
        'type': 'PASS_PHRASE',
        'content':
            'party response give dove tooth master flip video permit game expire token',
        'password': '123456',
      };
      await trustWalletChannel.invokeMethod('importWallet', data);
    } on PlatformException {}
  }

  Future<void> getListWallets() async {
    try {
      final data = {
        'password': 'password',
      };
      await trustWalletChannel.invokeMethod('getListWallets', data);
    } on PlatformException {}
  }

  Future<void> generateWallet() async {
    try {
      final data = {
        'password': 'password',
      };
      await trustWalletChannel.invokeMethod('generateWallet', data);
    } on PlatformException {}
  }

  Future<void> storeWallet() async {
    try {
      final data = {
        'seedPhrase': 'seedPhrase',
        'walletName': 'walletName',
        'storeWallet': 'storeWallet',
      };
      await trustWalletChannel.invokeMethod('storeWallet', data);
    } on PlatformException {}
  }

  Future<void> setConfig() async {
    try {
      final data = {
        'isAppLock': true,
        'isFaceID': true,
        'password': 'password',
      };
      await trustWalletChannel.invokeMethod('setConfig', data);
    } on PlatformException {}
  }

  Future<void> getListShowedToken() async {
    try {
      final data = {
        'walletAddress': 'walletAddress',
        'password': 'password',
      };
      await trustWalletChannel.invokeMethod('getListShowedToken', data);
    } on PlatformException {}
  }

  Future<void> getListShowedNft() async {
    try {
      final data = {
        'walletAddress': 'walletAddress',
        'password': 'password',
      };
      await trustWalletChannel.invokeMethod('getListShowedNft', data);
    } on PlatformException {}
  }

  Future<void> importToken() async {
    try {
      final data = {
        'walletAddress': 'walletAddress',
        'tokenAddress': 'tokenAddress',
        'symbol': 'symbol',
        'decimal': 1,
        'password': 'password',
      };
      await trustWalletChannel.invokeMethod('importToken', data);
    } on PlatformException {}
  }

  Future<void> getListSupportedToken() async {
    try {
      final data = {
        'walletAddress': 'walletAddress',
        'password': 'password',
      };
      await trustWalletChannel.invokeMethod('getListSupportedToken', data);
    } on PlatformException {}
  }
}
