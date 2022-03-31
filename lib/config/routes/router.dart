import 'package:Dfy/presentation/main_screen/ui/main_screen.dart';
import 'package:Dfy/presentation/splash/splash_screen.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';

typedef AppWidgetBuilder = Widget Function(BuildContext, RouteSettings);

class AppRouter {
  static const dfNamed = Navigator.defaultRouteName;

  ///Main App
  static const splash = '/splash';
  static const main = '/main';
  static const setupPassWord = '/setupPassWord';
  static const login = '/login';
  static const wallet = '/wallet';
  static const sendToken = '/sendToken';
  static const scanQR = '/scanQR';
  static const collectionList = '/collection_list';
  static const putOnSale = '/put_on_market';
  static const step2Book = '/step2_book';
  static const step2ListBook = '/step2_list_book';
  static const createHardNftStep1 = '/step1_create_hard_nft';
  static const step2Create = '/step2_create';
  static const step3ListEvaluation = '/list_evaluation';
  static const step3ListEvaluationDetail = '/detail_evalution';
  static const listNft = '/listNft';
  static const create_collection = '/create_collection';
  static const create_nft = '/create_nft';
  static const list_hard_mint = '/list_hard_mint';
  static const nft_detail = '/nft_detail';
  static const send_nft = '/send_nft';
  static const send_nft_confirm_blockchain = '/send_nft_confirm';
  static const collateral_result = '/collateral_result';
  static const collateral_detail_myacc = '/collateral_detail_myacc';
  static const collateral_list_myacc = '/collateral_list_myacc';
  static const offer_detail_myacc = '/offer_detail_myacc';
  static const contract_detail_my_acc = '/contract_detail_my_acc';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (ctx) => const SplashScreen());

      case main:
        return MaterialPageRoute(
          builder: (ctx) {
            final arg = ModalRoute.of(ctx)!.settings.arguments as int?;
            return MainScreen(
              index: arg,
            );
          },
        );
    }
  }
}

class PageTransition<T> extends PageRouteBuilder<T> {
  /// Child for your next page
  final Widget child;

  /// Transition types
  ///  fade,rightToLeft,bottomToTop,rightToLeftWithFade
  final PageTransitionType type;

  /// Duration for your transition default is 300 ms
  final Duration duration;

  /// Duration for your pop transition default is 300 ms
  final Duration reverseDuration;

  /// Context for inherit theme
  final BuildContext? ctx;

  /// Optional inherit theme
  final bool inheritTheme;

  /// Page transition constructor. We can pass the next page as a child,
  PageTransition({
    required this.child,
    this.type = PageTransitionType.RIGHT_TO_LEFT_WITH_FADE,
    this.ctx,
    this.inheritTheme = false,
    this.duration = const Duration(milliseconds: 300),
    this.reverseDuration = const Duration(milliseconds: 300),
    RouteSettings? settings,
  })  : assert(
          inheritTheme,
          "'ctx' cannot be null when 'inheritTheme' is true",
        ),
        super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return inheritTheme
                ? InheritedTheme.captureAll(
                    ctx!,
                    child,
                  )
                : child;
          },
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          settings: settings,
          maintainState: true,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            switch (type) {
              case PageTransitionType.FADE:
                return FadeTransition(opacity: animation, child: child);
                // ignore: dead_code
                break;
              case PageTransitionType.RIGHT_TO_LEFT:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
                // ignore: dead_code
                break;
              case PageTransitionType.BOTTOM_TO_TOP:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
                // ignore: dead_code
                break;
              case PageTransitionType.RIGHT_TO_LEFT_WITH_FADE:
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(1, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  ),
                );
                // ignore: dead_code
                break;
            }
          },
        );
}
