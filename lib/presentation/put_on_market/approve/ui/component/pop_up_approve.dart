import 'dart:ui';

import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';

class PopUpApprove extends StatelessWidget {
  const PopUpApprove({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 4,
        sigmaY: 4,
      ),
      child: Container(
        height: 454,
        decoration: BoxDecoration(
          color: AppTheme.getInstance().bgBtsColor(),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            Container(
              height: 100,
              width: 100,
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
