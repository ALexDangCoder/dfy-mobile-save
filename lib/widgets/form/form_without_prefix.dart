import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/widgets/image/circular_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Dfy/generated/l10n.dart';

enum TypeFormWithoutPrefix {
  DROP_DOWN,
  TEXT,
  IMAGE_FT_TEXT,
  DROP_DOWN_WITH_TEXT,
  IMAGE,
}

class FormWithOutPrefix extends StatelessWidget {
  const FormWithOutPrefix({
    Key? key,
    required this.hintText,
    required this.typeForm,
    required this.cubit,
    required this.txtController,
    this.imageAsset,
    this.quantityOfAll,
  }) : super(key: key);
  final String hintText;
  final TypeFormWithoutPrefix typeForm;
  final dynamic cubit;
  final TextEditingController txtController;
  final String? imageAsset;
  final int? quantityOfAll;

  @override
  Widget build(BuildContext context) {
    if (typeForm == TypeFormWithoutPrefix.IMAGE_FT_TEXT) {
      return Container(
        width: 343.w,
        height: 64.h,
        padding: EdgeInsets.only(
          left: 12.w,
          right: 12.w,
          top: 8.h,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          color: AppTheme.getInstance().itemBtsColors(),
        ),
        child: TextFormField(
          cursorColor: Colors.white,
          controller: txtController,
          style: textNormal(
            Colors.white,
            16,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: textNormal(
              Colors.grey,
              16,
            ),
            suffixIcon: SizedBox(
              height: 20.h,
              width: 78.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  circularImage(
                    imageAsset ?? '',
                    height: 16,
                    width: 16,
                  ),
                  spaceW4,
                  Text(
                    '${S.current.of_all} $quantityOfAll',
                    style: textNormalCustom(
                      Colors.white,
                      16,
                      FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    } else if (typeForm == TypeFormWithoutPrefix.TEXT) {
      return Container(
        width: 343.w,
        height: 64.h,
        padding: EdgeInsets.only(
          left: 12.w,
          right: 12.w,
          top: 8.h,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          color: AppTheme.getInstance().itemBtsColors(),
        ),
        child: TextFormField(
          cursorColor: Colors.white,
          controller: txtController,
          style: textNormal(
            Colors.white,
            16,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: textNormal(
              Colors.grey,
              16,
            ),
            suffixIcon: Container(
              padding: EdgeInsets.only(top: 10.h),
              child: Text(
                '${S.current.of_all} $quantityOfAll',
                style: textNormalCustom(
                  Colors.white,
                  16,
                  FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      );
    } else if (typeForm == TypeFormWithoutPrefix.IMAGE) {
      return Container(
        width: 343.w,
        height: 64.h,
        padding: EdgeInsets.only(
          left: 12.w,
          right: 12.w,
          top: 8.h,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          color: AppTheme.getInstance().itemBtsColors(),
        ),
        child: TextFormField(
          cursorColor: Colors.white,
          controller: txtController,
          style: textNormal(
            Colors.white,
            16,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: textNormal(
              Colors.grey,
              16,
            ),
            suffixIcon: ImageIcon(
              AssetImage(imageAsset ?? ''),
              color: Colors.white,
            ),
          ),
        ),
      );
    } else {
      // TODO handle UI WHEN SHOW DROPDOWN AND DROWDOWN WITH MONTH
      return const Text('CHUA CO CHUC NANG');
    }
  }
}
