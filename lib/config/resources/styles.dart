import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

const emptyView = SizedBox(width: 0, height: 0);

/// height and width space

/// height and width space
final spaceH2 = SizedBox(height: 2.h);
final spaceH3 = SizedBox(height: 3.h);
final spaceH4 = SizedBox(height: 4.h);
final spaceH5 = SizedBox(height: 5.h);
final spaceH6 = SizedBox(height: 6.h);
final spaceH7 = SizedBox(height: 7.h);
final spaceH8 = SizedBox(height: 8.h);
final spaceH10 = SizedBox(height: 10.h);
final spaceH12 = SizedBox(height: 12.h);
final spaceH15 = SizedBox(height: 15.h);
final spaceH32 = SizedBox(
  height: 32.h,
);
final spaceH27 = SizedBox(
  height: 27.h,
);

final spaceH14 = SizedBox(height: 14.h);
final spaceH16 = SizedBox(height: 16.h);
final spaceH18 = SizedBox(height: 18.h);
final spaceH20 = SizedBox(height: 20.h);
final spaceH22 = SizedBox(height: 22.h);
final spaceH24 = SizedBox(height: 24.h);
final spaceH25 = SizedBox(height: 25.h);
final spaceH30 = SizedBox(height: 30.h);
final spaceH35 = SizedBox(height: 35.h);
final spaceH38 = SizedBox(height: 38.h);
final spaceH40 = SizedBox(height: 40.h);
final spaceH46 = SizedBox(height: 46.h);
final spaceH50 = SizedBox(height: 50.h);
final spaceH56 = SizedBox(height: 56.h);
final spaceH60 = SizedBox(height: 60.h);
final spaceH70 = SizedBox(height: 70.h);
final spaceH344 = SizedBox(height: 344.h);
final spaceH152 = SizedBox(height: 152.h);

///W
final spaceW2 = SizedBox(width: 2.w);
final spaceW3 = SizedBox(width: 3.w);
final spaceW4 = SizedBox(width: 4.w);
final spaceW5 = SizedBox(width: 5.w);
final spaceW6 = SizedBox(width: 6.w);
final spaceW8 = SizedBox(width: 8.w);
final spaceW10 = SizedBox(width: 10.w);
final spaceW12 = SizedBox(width: 12.w);
final spaceW15 = SizedBox(width: 15.w);
final spaceW16 = SizedBox(width: 16.w);
final spaceW18 = SizedBox(width: 18.w);
final spaceW20 = SizedBox(width: 20.w);
final spaceW25 = SizedBox(width: 25.w);
final spaceW28 = SizedBox(width: 28.w);
final spaceW30 = SizedBox(width: 30.w);
final spaceW60 = SizedBox(width: 60.w);
final spaceW100 = SizedBox(width: 100.w);

final divide = Divider(
  color: AppTheme.getInstance().divideColor(),
  thickness: 1,
);

TextStyle textNormal(Color? color, double? fontSize) {
  return GoogleFonts.sourceSansPro(
    color: color ?? Colors.white,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: fontSize?.sp ?? 14.sp,
  );
}

final divider = Divider(thickness: 1, color: Colors.white.withOpacity(0.1));

final dividerCreateNFT = SizedBox(
  width: 66.w,
  child: Divider(
    thickness: 1,
    color: AppTheme.getInstance().lineCreateNFT(),
  ),
);

final dividerSuccessCreateNFT = SizedBox(
  width: 66.w,
  child: Divider(
    thickness: 1,
    color: AppTheme.getInstance().successTransactionColors(),
  ),
);

TextStyle tokenDetailAmount({
  Color color = Colors.white,
  double fontSize = 24,
  FontWeight weight = FontWeight.w400,
  FontStyle fontStyle = FontStyle.normal,
  TextDecoration decoration = TextDecoration.none,
}) {
  return GoogleFonts.sourceSansPro(
    color: color,
    fontWeight: weight,
    fontStyle: FontStyle.normal,
    fontSize: fontSize.sp,
    decoration: decoration,
  );
}

TextStyle textCustom({
  Color color = Colors.white,
  double fontSize = 16,
  FontWeight weight = FontWeight.w400,
  FontStyle fontStyle = FontStyle.normal,
  TextDecoration decoration = TextDecoration.none,
}) {
  return GoogleFonts.sourceSansPro(
    color: color,
    fontWeight: weight,
    fontStyle: fontStyle,
    fontSize: fontSize.sp,
    decoration: decoration,
  );
}

TextStyle titleText({Color color = Colors.white, double fontSize = 20}) {
  return GoogleFonts.sourceSansPro(
    color: color,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontSize: fontSize.sp,
  );
}

TextStyle textNormalCustom(
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
) {
  return GoogleFonts.sourceSansPro(
    color: color ?? Colors.white,
    fontWeight: fontWeight ?? FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: fontSize?.sp ?? 14.sp,
  );
}

TextStyle textNormalCustomUnderline(
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
) {
  return GoogleFonts.sen(
    color: color ?? Colors.white,
    fontWeight: fontWeight ?? FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: fontSize?.sp ?? 14.sp,
    decoration: TextDecoration.underline,
  );
}

TextStyle textFieldNFT = GoogleFonts.sourceSansPro(
  color: AppTheme.getInstance().textThemeColor(),
  fontWeight: FontWeight.w700,
  fontSize: 16.sp,
);
TextStyle textValueNFT = GoogleFonts.sourceSansPro(
  color: AppTheme.getInstance().textThemeColor(),
  fontWeight: FontWeight.w400,
  fontSize: 16.sp,
);
TextStyle textLabelNFT = GoogleFonts.sourceSansPro(
  color: AppTheme.getInstance().textThemeColor(),
  fontWeight: FontWeight.w600,
  fontSize: 16.sp,
);
TextStyle richTextBlue = GoogleFonts.sourceSansPro(
  color: const Color(0xff46BCFF),
  fontWeight: FontWeight.w400,
  fontSize: 14.sp,
  decoration: TextDecoration.underline,
);
TextStyle richTextWhite = GoogleFonts.sen(
  color: AppTheme.getInstance().textThemeColor(),
  fontWeight: FontWeight.w400,
  fontSize: 16.sp,
  decoration: TextDecoration.underline,
);

TextStyle whiteTextWithOpacity = GoogleFonts.sen(
  color: Colors.white.withOpacity(0.7),
  fontWeight: FontWeight.w400,
  fontSize: 14,
);
TextStyle unselectLabel = GoogleFonts.sen(
  color: AppTheme.getInstance().whiteColor(),
  fontWeight: FontWeight.w600,
  fontSize: 14,
);
TextStyle uploadText = GoogleFonts.sen(
  color: AppTheme.getInstance().titleTabColor(),
  fontWeight: FontWeight.w400,
  fontSize: 14,
);

TextStyle normalText = GoogleFonts.sourceSansPro(
  color: Colors.white,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
  fontSize: 14.sp,
);
