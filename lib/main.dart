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
        print('importWalletCallback ${methodCall.arguments}');
        break;
      case 'importListTokenCallback':
        print('importListTokenCallback ${methodCall.arguments}');
        break;
      case 'importNftCallback':
        print('importNftCallback ${methodCall.arguments}');
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
        break;
      case 'getTokensCallback':
        break;
      default:
        break;
    }
  }

  void callAllApi() {
    importNft();
  }

  Future<void> importListToken() async {
    try {
      final data = {
        'jsonTokens':
            '[{"tokenAddress":"0x0000000000000000000000000000000000000000","nameToken":"","nameShortToken":"BNB","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":603.97,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":0.0},{"tokenAddress":"0xa2B726B1145A4773F68593CF171187d8EBe4d495","nameToken":"","nameShortToken":"INJ","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":11.52808131,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":0.0},{"tokenAddress":"0x62950ba1AdB2C867A24599a3666bf83Cf84c29Ed","nameToken":"DOT","nameShortToken":"DOT","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":51.45,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":18.0},{"tokenAddress":"0x395998D21d4Dd230f38247F84145Bd4d9afAaCa2","nameToken":"LTC","nameShortToken":"LTC","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":199.25,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":18.0},{"tokenAddress":"0x653b5410E4a15062cdEF91f9CEe930ca9B1832C4","nameToken":"XRP","nameShortToken":"XRP","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":1.16310878,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":18.0},{"tokenAddress":"0x101d82428437127bF1608F699CD651e6Abf9766E","nameToken":"","nameShortToken":"BAT","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":0.973122,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":0.0},{"tokenAddress":"0x3d6545b08693daE087E957cb1180ee38B9e3c25E","nameToken":"","nameShortToken":"ETC","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":53.61,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":0.0},{"tokenAddress":"0x362F62b601E80221abb8013c496055fbD297b0B5","nameToken":"USDT","nameShortToken":"USDT","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":1.001,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":18.0},{"tokenAddress":"0x5f0Da599BB2ccCfcf6Fdfd7D81743B6020864350","nameToken":"","nameShortToken":"MKR","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":2946.88,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":0.0},{"tokenAddress":"0xCE89CFcca3fedD566C7574902137eD31A4C9Ea40","nameToken":"ADA","nameShortToken":"ADA","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":1.974,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":18.0},{"tokenAddress":"0x56b6fB708fC5732DEC1Afc8D8556423A2EDcCbD6","nameToken":"","nameShortToken":"EOS","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":4.54,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":0.0},{"tokenAddress":"0x1Ba42e5193dfA8B03D15dd1B86a3113bbBEF8Eeb","nameToken":"","nameShortToken":"ZEC","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":165.36,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":0.0},{"tokenAddress":"0xF8A0BF9cF54Bb92F17374d9e9A321E6a111a51bD","nameToken":"","nameShortToken":"LINK","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":32.81067581,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":0.0},{"tokenAddress":"0x8fF795a6F4D97E7887C79beA79aba5cc76444aDf","nameToken":"Bella Protocol","nameShortToken":"BCH","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":598.01,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":18.0},{"tokenAddress":"0xFd7B3A77848f1C2D67E05E54d78d174a0C850335","nameToken":"Bella Protocol","nameShortToken":"ONT","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":1.15,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":18.0},{"tokenAddress":"0x0D8Ce2A99Bb6e3B7Db580eD848240e4a0F9aE153","nameToken":"","nameShortToken":"FIL","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":63.39359884,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":0.0},{"tokenAddress":"0x9678E42ceBEb63F23197D726B29b1CB20d0064E5","nameToken":"","nameShortToken":"IOTX","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":0.115423,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":0.0},{"tokenAddress":"0xF02224B084f76fFd3427c8DD3055ea0dEA7F1EC2","nameToken":"USDC","nameShortToken":"USDC","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":1.00006926,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":18.0},{"tokenAddress":"0x9Ac983826058b8a9C7Aa1C9171441191232E8404","nameToken":"","nameShortToken":"SNX","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":10.49,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":0.0},{"tokenAddress":"0x47BEAd2563dCBf3bF2c9407fEa4dC236fAbA485A","nameToken":"","nameShortToken":"SXP","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":2.43891813,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":0.0},{"tokenAddress":"0x544D0AD6BdDa001630941f6523D935E32cCAb604","nameToken":"BUSD","nameShortToken":"BUSD","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":1.0001992,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":18.0},{"tokenAddress":"0xf827916F754297d7fF595e77c8dF8287fDE74BA4","nameToken":"ETH","nameShortToken":"ETH","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":4471.05,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":18.0},{"tokenAddress":"0xaeeFfB36f4F8f0603AF63607f839D9457fc8b292","nameToken":"DAI","nameShortToken":"DAI","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":0.99974462,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":18.0},{"tokenAddress":"0x52D2848E79861492795a2635B76493999F1EdB1F","nameToken":"WBTC","nameShortToken":"BTC","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":60973.57,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":18.0},{"tokenAddress":"0xCA0a9Df6a8cAD800046C1DDc5755810718b65C44","nameToken":"","nameShortToken":"TCT","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":0.03453969,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":0.0},{"tokenAddress":"0x16939ef78684453bfDFb47825F8a5F714f12623a","nameToken":"","nameShortToken":"XTZ","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":6.62,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":0.0},{"tokenAddress":"0xa3f020a5C92e15be13CAF0Ee5C95cF79585EeCC9","nameToken":"","nameShortToken":"ELF","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":0.583507,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":0.0},{"tokenAddress":"0x20f1dE452e9057fe863b99d33CF82DBeE0C45B14","nameToken":"DeFi For You.","nameShortToken":"DFY","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":0.055972,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":18.0},{"tokenAddress":"0xae13d989daC2f0dEbFf460aC112a837C89BAa7cd","nameToken":"Wrapped BNB","nameShortToken":"WBNB","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":326.79,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":18.0},{"tokenAddress":"0xb7F8Cd00C5A06c0537E2aBfF0b58033d02e5E094","nameToken":"","nameShortToken":"PAX","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":1.0,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":0.0},{"tokenAddress":"0xAD6cAEb32CD2c308980a548bD0Bc5AA4306c6c18","nameToken":"Bella Protocol","nameShortToken":"BAND","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":9.83,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":18.0},{"tokenAddress":"0x88f1A5ae2A3BF98AEAF342D26B30a79438c9142e","nameToken":"","nameShortToken":"YFI","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":34197.0,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":0.0},{"tokenAddress":"0x0Eb3a705fc54725037CC9e008bDede697f62F335","nameToken":"","nameShortToken":"ATOM","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":37.34,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":0.0},{"tokenAddress":"0x52CE071Bd9b1C4B00A0b92D298c512478CaD67e8","nameToken":"","nameShortToken":"COMP","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":363.75,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":0.0},{"tokenAddress":"0xBf5140A22578168FD562DCcF235E5D43A02ce9B1","nameToken":"","nameShortToken":"UNI","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":25.9,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":0.0},{"tokenAddress":"0x1Fa4a73a3F0133f0025378af00236f3aBDEE5D63","nameToken":"","nameShortToken":"NEAR","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":10.57,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":0.0},{"tokenAddress":"0x8443f091997f06a61670B735ED92734F5628692F","nameToken":"","nameShortToken":"BEL","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":2.72,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":0.0},{"tokenAddress":"0x7F70642d88cf1C4a3a7abb072B53B929b653edA5","nameToken":"","nameShortToken":"YFII","iconToken":"","balanceToken":0.0,"isShow":false,"exchangeRate":3867.3,"walletAddress":"0xf5e281A56650bb992ebaB15B41583303fE9804e7","decimal":0.0}]',
      };
      await trustWalletChannel.invokeMethod('importListToken', data);
    } on PlatformException {}
  }

  Future<void> importNft() async {
    try {
      final data = {
        'jsonNft':
            '{"name": "Mobile Test Collection","symbol": "DFY-NFT","contract": "0x51eE4cFa0363BAA22cE8d628ef1F75D7eE4C24a1","listNft": [{"id": 2,"contract": "0x51eE4cFa0363BAA22cE8d628ef1F75D7eE4C24a1","uri": "https://defiforyou.mypinata.cloud/ipfs/QmQj6bT1VbwVZesexd43vvGxbCGqLaPJycdMZQGdsf6t3c"}]}',
      };
      await trustWalletChannel.invokeMethod('importNft', data);
    } on PlatformException {}
  }
}
