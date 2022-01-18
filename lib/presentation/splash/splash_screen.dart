import 'dart:async';

import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/presentation/main_screen/ui/main_screen.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late int index;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAppLock();
    _navigateToMain();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void checkAppLock() {
    if (PrefsService.getFirstAppConfig() == 'true') {
      index = 3;
    } else if (PrefsService.getAppLockConfig() == 'true') {
      index = 2;
    } else {
      index = 1;
    }
  }

  _navigateToMain() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {});
    _pageRouter();
  }

  _pageRouter() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(
          index: index,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageAssets.background_splash),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: FadeTransition(
          opacity: _animation,
          child: const Image(
            image: AssetImage(ImageAssets.image_splash),
          ),
        ),
      ),
    );
  }
}
