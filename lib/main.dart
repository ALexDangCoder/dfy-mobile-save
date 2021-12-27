import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/strings.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/di/module.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web3dart/crypto.dart';

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
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          if (supportedLocales.contains(
            Locale(deviceLocale?.languageCode ?? EN_CODE),
          )) {
            return deviceLocale;
          } else {
            return const Locale.fromSubtags(languageCode: EN_CODE);
          }
        },
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
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
          print('isWalletExit ${methodCall.arguments['isWalletExist']}');
        }
        break;
      case 'importNftCallback':
        print('importNftCallback ${methodCall.arguments}');
        break;
      case 'importListTokenCallback':
        print('importListTokenCallback ${methodCall.arguments}');
        break;
      case 'getTokensCallback':
        print('getTokensCallback ${methodCall.arguments}');
        break;
      case 'signTransactionTokenCallback':
        print('signTransactionTokenCallback ${methodCall.arguments}');
        break;
      case 'signTransactionNftCallback':
        print('signTransactionNftCallback ${methodCall.arguments}');
        break;
      case 'getNFTCallback':
        print('getNFTCallback ${methodCall.arguments}');
        break;
    }
  }

  void callAllApi() {
    getConfig();
  }

  void getConfig() {
    try {
      final data = {};
      trustWalletChannel.invokeMethod('getConfig', data);
    } on PlatformException {}
  }

  Future<void> importToken() async {
    try {
      final data = {
        'walletAddress': '0x6A587Aa17b562d0714650e0E7DCC7E964d3Dc148',
        'tokenAddress': '123',
        'tokenFullName': '123',
        'iconUrl': '123',
        'iconToken': '123',
        'symbol': '123',
        'decimal': 1,
        'exchangeRate': 1.0,
        'isImport': true,
      };
      await trustWalletChannel.invokeMethod('importToken', data);
    } on PlatformException {}
  }

  Future<void> signTransactionToken() async {
    try {
      final data = {
        'walletAddress': '',
        'tokenAddress': '',
        'toAddress': '',
        'nonce': '',
        'chainId': '',
        'gasPrice': '',
        'gasLimit': '',
        'amount': '',
      };
      await trustWalletChannel.invokeMethod('signTransactionToken', data);
    } on PlatformException {}
  }

  Future<void> signTransactionNft() async {
    try {
      final data = {
        'walletAddress': '0xf5e281A56650bb992ebaB15B41583303fE9804e7',
        'tokenAddress': '0xaB05Ab79C0F440ad982B1405536aBc8094C80AfB',
        'toAddress': '0xaB05Ab79C0F440ad982B1405536aBc8094C80AfB',
        'nonce': '46',
        'chainId': '97',
        'gasPrice': '1000000000000',
        'gasLimit': '100000',
        'tokenId': '3',
      };

      await trustWalletChannel.invokeMethod('signTransactionNft', data);
    } on PlatformException {}
  }

  Future<void> importListToken() async {
    try {
      final data = {
        'jsonTokens':
            '[{"tokenAddress":"0x20f1dE452e9057fe863b99d33CF82DBeE0C45B14","nameToken":"Defi For You","nameShortToken":"DFY","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/DFY.png","exchangeRate":0.04737754,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0x52D2848E79861492795a2635B76493999F1EdB1F","nameToken":"Bitcoin","nameShortToken":"BTC","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/BTC.png","exchangeRate":49076.0,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0xf827916F754297d7fF595e77c8dF8287fDE74BA4","nameToken":"Ethereum","nameShortToken":"ETH","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/ETH.png","exchangeRate":4040.13,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0xae13d989daC2f0dEbFf460aC112a837C89BAa7cd","nameToken":"","nameShortToken":"WBNB","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/WBNB.png","exchangeRate":537.45,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0x362F62b601E80221abb8013c496055fbD297b0B5","nameToken":"Tether","nameShortToken":"USDT","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/USDT.png","exchangeRate":1.0,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0x653b5410E4a15062cdEF91f9CEe930ca9B1832C4","nameToken":"XRP","nameShortToken":"XRP","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/XRP.png","exchangeRate":0.835341,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0x395998D21d4Dd230f38247F84145Bd4d9afAaCa2","nameToken":"Litecoin","nameShortToken":"LTC","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/LTC.png","exchangeRate":154.1,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0x3d6545b08693daE087E957cb1180ee38B9e3c25E","nameToken":"Ethereum Classic","nameShortToken":"ETC","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/ETC.png","exchangeRate":36.22,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0x1Ba42e5193dfA8B03D15dd1B86a3113bbBEF8Eeb","nameToken":"Zcash","nameShortToken":"ZEC","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/ZEC.png","exchangeRate":161.21,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0x5f0Da599BB2ccCfcf6Fdfd7D81743B6020864350","nameToken":"Maker","nameShortToken":"MKR","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/MKR.png","exchangeRate":2398.44,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0x101d82428437127bF1608F699CD651e6Abf9766E","nameToken":"Basic Attention Token","nameShortToken":"BAT","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/BAT.png","exchangeRate":1.17,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0x56b6fB708fC5732DEC1Afc8D8556423A2EDcCbD6","nameToken":"EOS","nameShortToken":"EOS","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/EOS.png","exchangeRate":3.36,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0x8fF795a6F4D97E7887C79beA79aba5cc76444aDf","nameToken":"Bitcoin Cash","nameShortToken":"BCH","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/BCH.png","exchangeRate":446.79,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0xF8A0BF9cF54Bb92F17374d9e9A321E6a111a51bD","nameToken":"Chainlink","nameShortToken":"LINK","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/LINK.png","exchangeRate":20.0,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0xCE89CFcca3fedD566C7574902137eD31A4C9Ea40","nameToken":"Cardano","nameShortToken":"ADA","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/ADA.png","exchangeRate":1.3,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0x16939ef78684453bfDFb47825F8a5F714f12623a","nameToken":"Tezos","nameShortToken":"XTZ","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/XTZ.png","exchangeRate":4.53,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0x0D8Ce2A99Bb6e3B7Db580eD848240e4a0F9aE153","nameToken":"Filecoin","nameShortToken":"FIL","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/FIL.png","exchangeRate":38.06,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0xa3f020a5C92e15be13CAF0Ee5C95cF79585EeCC9","nameToken":"aelf","nameShortToken":"ELF","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/ELF.png","exchangeRate":4.92111e-7,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0xCA0a9Df6a8cAD800046C1DDc5755810718b65C44","nameToken":"TokenClub","nameShortToken":"TCT","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/TCT.png","exchangeRate":0.399402,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0xFd7B3A77848f1C2D67E05E54d78d174a0C850335","nameToken":"Ontology","nameShortToken":"ONT","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/ONT.png","exchangeRate":0.706386,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0x9Ac983826058b8a9C7Aa1C9171441191232E8404","nameToken":"Synthetix","nameShortToken":"SNX","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/SNX.png","exchangeRate":5.19,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0x9678E42ceBEb63F23197D726B29b1CB20d0064E5","nameToken":"IoTeX","nameShortToken":"IOTX","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/IOTX.png","exchangeRate":0.111528,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0xb7F8Cd00C5A06c0537E2aBfF0b58033d02e5E094","nameToken":"Paxos Standard","nameShortToken":"PAX","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/PAX.png","exchangeRate":13.07,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0xF02224B084f76fFd3427c8DD3055ea0dEA7F1EC2","nameToken":"USD Coin","nameShortToken":"USDC","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/USDC.png","exchangeRate":1.0,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0x0Eb3a705fc54725037CC9e008bDede697f62F335","nameToken":"Cosmos","nameShortToken":"ATOM","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/ATOM.png","exchangeRate":22.52,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0x47BEAd2563dCBf3bF2c9407fEa4dC236fAbA485A","nameToken":"Swipe","nameShortToken":"SXP","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/SXP.png","exchangeRate":1.54,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0xAD6cAEb32CD2c308980a548bD0Bc5AA4306c6c18","nameToken":"Band Protocol","nameShortToken":"BAND","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/BAND.png","exchangeRate":5.14,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0x544D0AD6BdDa001630941f6523D935E32cCAb604","nameToken":"Binance USD","nameShortToken":"BUSD","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/BUSD.png","exchangeRate":1.0,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0xaeeFfB36f4F8f0603AF63607f839D9457fc8b292","nameToken":"Dai","nameShortToken":"DAI","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/DAI.png","exchangeRate":1.0,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0x52CE071Bd9b1C4B00A0b92D298c512478CaD67e8","nameToken":"Compound","nameShortToken":"COMP","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/COMP.png","exchangeRate":196.23,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0x88f1A5ae2A3BF98AEAF342D26B30a79438c9142e","nameToken":"yearn.finance","nameShortToken":"YFI","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/YFI.png","exchangeRate":21501.0,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0x7F70642d88cf1C4a3a7abb072B53B929b653edA5","nameToken":"DFI.Money","nameShortToken":"YFII","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/YFII.png","exchangeRate":2811.92,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0x1Fa4a73a3F0133f0025378af00236f3aBDEE5D63","nameToken":"NEAR Protocol","nameShortToken":"NEAR","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/NEAR.png","exchangeRate":9.98,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0x62950ba1AdB2C867A24599a3666bf83Cf84c29Ed","nameToken":"Polkadot","nameShortToken":"DOT","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/DOT.png","exchangeRate":27.16,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0x8443f091997f06a61670B735ED92734F5628692F","nameToken":"Bella Protocol","nameShortToken":"BEL","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/BEL.png","exchangeRate":5.15,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0xBf5140A22578168FD562DCcF235E5D43A02ce9B1","nameToken":"Uniswap","nameShortToken":"UNI","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/UNI.png","exchangeRate":0.01249201,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0xa2B726B1145A4773F68593CF171187d8EBe4d495","nameToken":"Injective Protocol","nameShortToken":"INJ","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/INJ.png","exchangeRate":8.7,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false},{"tokenAddress":"0x0000000000000000000000000000000000000000","nameToken":"Binance Coin","nameShortToken":"BNB","iconToken":"https://s3.ap-southeast-1.amazonaws.com/beta-storage-dfy/upload/BNB.png","exchangeRate":440.46,"walletAddress":"0x40Dcd83e299a9b356C91A84bfFB19ec5506703E8","decimal":18,"isImport":false}]',
      };
      await trustWalletChannel.invokeMethod('importListToken', data);
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

  Future<void> importNft() async {
    try {
      final data = {
        'walletAddress': '123',
        'jsonNft':
            '{"name": "Mobile Test Collection","symbol": "DFY-NFT","contract": "0x51eE4cFa0363BAA22cE8d628ef1F75D7eE4C24a1","listNft": [{"id": 0,"contract": "0x51eE4cFa0363BAA22cE8d628ef1F75D7eE4C24a1","uri": "https://defiforyou.mypinata.cloud/ipfs/QmZbN93DKoW9owJ2QqJ8RM7hqCW5PgotRK3y8mnprU5VQW"},{"id": 1,"contract": "0x51eE4cFa0363BAA22cE8d628ef1F75D7eE4C24a1","uri": "https://defiforyou.mypinata.cloud/ipfs/QmTpRapaL9WbEVJibJrBzQ4nkggg9mSJK7DVK3mL6hpMEy"},{"id": 2,"contract": "0x51eE4cFa0363BAA22cE8d628ef1F75D7eE4C24a1","uri": "https://defiforyou.mypinata.cloud/ipfs/QmQj6bT1VbwVZesexd43vvGxbCGqLaPJycdMZQGdsf6t3c"},{"id": 3,"contract": "0x51eE4cFa0363BAA22cE8d628ef1F75D7eE4C24a1","uri": "https://defiforyou.mypinata.cloud/ipfs/QmXCQTqZYYyDCF6GcnnophSZryRQ3HJTvEjokoRFYbH5MG"}]}',
      };
      await trustWalletChannel.invokeMethod('importNft', data);
    } on PlatformException {}
  }

  Future<void> getNFT() async {
    try {
      final data = {
        'walletAddress': '0x5D3034094Eb47C3302d5BaE8D8422F34a04E79a5',
      };
      await trustWalletChannel.invokeMethod('getNFT', data);
    } on PlatformException {}
  }

  Future<void> getTokens() async {
    try {
      final data = {
        'walletAddress': '0x6A587Aa17b562d0714650e0E7DCC7E964d3Dc148',
      };
      await trustWalletChannel.invokeMethod('getTokens', data);
    } on PlatformException {}
  }
}
