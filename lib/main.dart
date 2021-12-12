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
    super.initState();
    trustWalletChannel.setMethodCallHandler(nativeMethodCallHandler);
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
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
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
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: AppTheme.getInstance().accentColor(),
          ),
        ),
        // supportedLocales: S.delegate.supportedLocales,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: Locale.fromSubtags(
          languageCode: PrefsService.getLanguage(),
        ),
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: AppRouter.splash,
      ),
    );
  }

  Future<dynamic> nativeMethodCallHandler(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'getConfigCallback':
        await PrefsService.saveAppLockConfig(
          methodCall.arguments['isAppLock'].toString(),
        );
        await PrefsService.saveFaceIDConfig(
          methodCall.arguments['isFaceID'].toString(),
        );
        if (methodCall.arguments['isWalletExist']) {
          await PrefsService.saveFirstAppConfig('false');
        }
        print('isWalletExit ${methodCall.arguments['isWalletExist']}');
    }
  }

  void callAllApi() {
    getConfig();
  }

  Future<void> getConfig() async {
    try {
      final data = {};
      await trustWalletChannel.invokeMethod('getConfig', data);
    } on PlatformException {}
  }

  Future<void> importToken() async {
    try {
      final data = {
        'walletAddress': '123',
        'tokenAddress': '123',
        'tokenFullName': '123',
        'iconToken': '123',
        'symbol': '123',
        'decimal': 1,
        'exchangeRate': 1.0,
      };
      await trustWalletChannel.invokeMethod('importToken', data);
    } on PlatformException {}
  }

  Future<void> checkToken() async {
    try {
      final data = {
        'walletAddress': '123',
        'tokenAddress': '123',
      };
      await trustWalletChannel.invokeMethod('checkToken', data);
    } on PlatformException {}
  }

  Future<void> getNFT() async {
    try {
      final data = {
        'walletAddress': '123',
      };
      await trustWalletChannel.invokeMethod('getNFT', data);
    } on PlatformException {}
  }
}
