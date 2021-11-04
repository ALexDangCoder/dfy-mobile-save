import 'dart:ui';

import 'package:flutter/widgets.dart';

class CustomRectTween extends RectTween {
  CustomRectTween({
    required Rect begin,
    required Rect end,
  }) : super(begin: begin, end: end);

  @override
  Rect lerp(double t) {
    final elasticCurveValue = Curves.easeOut.transform(t);
    return Rect.fromLTRB(
      lerpDouble(begin?.left ?? 0, end?.left ?? 0.0, elasticCurveValue) ?? 0,
      lerpDouble(begin?.top ?? 0.0, end?.top ?? 0.0, elasticCurveValue) ?? 0,
      lerpDouble(begin?.right ?? 0.0, end?.right ?? 0, elasticCurveValue) ?? 0,
      lerpDouble(begin?.bottom ?? 0.0, end?.bottom ?? 0.0, elasticCurveValue) ??
          0,
    );
  }
}
