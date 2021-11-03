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
        statusBarIconBrightness: Brightness.light),
  );
  configureDependencies();
  trustWalletChannel.setMethodCallHandler(nativeMethodCallHandler);
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
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
    );
  }

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case "createWalletCallBack":
        print('createWalletCallBack' + DateTime.now().toString());
        print(methodCall.arguments.toString());
        break;
      case "importWalletCallBack":
        print('importWalletCallBack' + DateTime.now().toString());
        print(methodCall.arguments.toString());
        break;
      default:
        break;
    }
  }

  Future<void> checkPassWallet() async {
    try {
      print('createWallet' + DateTime.now().toString());
      trustWalletChannel.invokeMethod('createWallet');
    } on PlatformException {}
  }

  Future<void> getPassWallet() async {
    try {
      var data = {
        "seedPhrase":
            "robust balance table arch slide easy bulb welcome pact express unhappy early",
      };
      print('importWallet' + DateTime.now().toString());
      trustWalletChannel.invokeMethod('importWallet', data);
    } on PlatformException {}
  }
}
