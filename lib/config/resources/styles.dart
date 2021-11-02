import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textNormal(Color? color, double? fontSize) {
  return GoogleFonts.sen(
    color: color ?? Colors.white,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: fontSize ?? 14,
  );
}
