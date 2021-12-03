import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/strings.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/di/module.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/transaction_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

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
      builder: () =>
          GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: Strings.app_name,
            theme: ThemeData(
              primaryColor: AppTheme.getInstance().primaryColor(),
              cardColor: Colors.white,
              textTheme: GoogleFonts.latoTextTheme(Theme
                  .of(context)
                  .textTheme),
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
                languageCode: PrefsService.getLanguage()),
            onGenerateRoute: AppRouter.generateRoute,
            initialRoute: AppRouter.splash,
          ),
    );
  }

  Future<dynamic> nativeMethodCallHandler(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'checkPasswordCallback':
        break;
      case 'getConfigCallback':
        await PrefsService.saveAppLockConfig(
          methodCall.arguments['isAppLock'].toString(),
        );
        await PrefsService.saveFaceIDConfig(
          methodCall.arguments['isFaceID'].toString(),
        );
        break;
      case 'importWalletCallback':
        break;
      case 'earseWalletCallback':
        break;
      case 'getListWalletsCallback':
        break;
      case 'generateWalletCallback':
        break;
      case 'storeWalletCallback':
        break;
      case 'setConfigCallback':
        break;
      case 'getListShowedTokenCallback':
        break;
      case 'getListShowedNftCallback':
        break;
      case 'importTokenCallback':
        break;
      case 'getListSupportedTokenCallback':
        break;
      case 'signTransactionCallback':
        print('signTransactionCallback ${methodCall.arguments}');
        TransactionModel dataTransaction = TransactionModel.fromJson(
            methodCall.arguments);
        const String rpcUrl = 'https://data-seed-prebsc-1-s1.binance.org:8545';
        final client = Web3Client(rpcUrl, Client());
        await client.sendRawTransaction(dataTransaction.signedTransaction);
        client.dispose();
        break;
      case 'getTokensCallback':
        break;
      default:
        break;
    }
  }

  void callAllApi() {
    signTransaction();
  }

  Future<void> getConfig() async {
    try {
      final data = {};
      await trustWalletChannel.invokeMethod('getConfig', data);
    } on PlatformException {}
  }

  Future<void> createWallet() async {
    try {
      final data = {
        'password': 'password',
      };
      await trustWalletChannel.invokeMethod('checkPassword', data);
    } on PlatformException {}
  }

  Future<void> earseWallet() async {
    try {
      final data = {
        'type': 'IMPORT',
      };
      await trustWalletChannel.invokeMethod('earseWallet', data);
    } on PlatformException {}
  }

  Future<void> importWallet() async {
    try {
      final data = {
        'type': 'PASS_PHRASE',
        'content': 'party response give dove tooth master flip'
            ' video permit game expire token',
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

  Future<void> signTransaction() async {
    try {
      final data = {
        'fromAddress': '0xf5e281A56650bb992ebaB15B41583303fE9804e7',
        'toAddress': '0xFC0f99Bb0105b164Ce317384E8415B953D4Ae115',
        'chainId': '97',
        'gasPrice': 10000000000.toDouble(),
        'price': 1000000000000000.toDouble(),
        'maxGas': 21000.toDouble(),
      };
      await trustWalletChannel.invokeMethod('signTransaction', data);
    } on PlatformException {}
  }

  Future<void> getTokens() async {
    try {
      final data = {
        'walletAddress': '0xfff',
      };
      await trustWalletChannel.invokeMethod('getTokens', data);
    } on PlatformException {}
  }
}
