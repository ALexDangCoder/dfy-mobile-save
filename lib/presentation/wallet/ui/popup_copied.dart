import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/presentation/wallet/ui/custom_tween.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Copied extends StatelessWidget {
  const Copied({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: '',
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin!, end: end!);
        },
        child: buildBlur(
          borderRadius: BorderRadius.circular(20),
          child: Material(
            color: Colors.white.withOpacity(0.3),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: SizedBox(
              width: 232.w,
              height: 83.h,
              child: Center(
                child: Text(
                  'Copied address !',//todo text
                  style: textNormal(
                    null,
                    20,
                  ).copyWith(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBlur({
    required Widget child,
    BorderRadius borderRadius = BorderRadius.zero,
    double sigmaX = 6,
    double sigmaY = 6,
  }) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: sigmaX,
          sigmaY: sigmaY,
        ),
        child: child,
      ),
    );
  }
}
