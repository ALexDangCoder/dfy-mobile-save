import 'package:Dfy/presentation/collection_list/ui/collection_list.dart';
import 'package:Dfy/presentation/collection_list/ui/detail_collection.dart';
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
  static const testScreen = '/testScreen';
  static const login = '/login';
  static const wallet = '/wallet';
  static const sendToken = '/sendToken';
  static const scanQR = '/scanQR';
  static const collectionList = '/collection_list';

  static const detailCollection = '/detail_collection';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case detailCollection:
        return MaterialPageRoute(builder: (ctx) => const DetailCollection());
      case collectionList:
        return MaterialPageRoute(builder: (ctx) => const CollectionList());
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
