import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputRow extends StatelessWidget {
  final String hint;
  final String leadImg;
  final String img2;
  final Function(String) onChange;
  final Function()? onImageTap;
  final TextInputType inputType;
  final TextEditingController textController;
  final String suffixes;
  final String prefixText;


  const InputRow({
    Key? key,
    this.hint = '',
    required this.leadImg,
    required this.onChange,
    this.onImageTap,
    this.inputType = TextInputType.text,
    this.img2 = '',
    required this.textController,
    this.suffixes = '',
    this.prefixText = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 343.w,
          height: 64.h,
          margin: EdgeInsets.only(top: 16.h),
          padding: EdgeInsets.only(right: 15.w, left: 15.w),
          decoration: BoxDecoration(
            color: AppTheme.getInstance().backgroundBTSColor(),
            borderRadius: BorderRadius.all(
              Radius.circular(20.r),
            ),
          ),
          child: Row(
            children: [
              sizedSvgImage(
                w: 20,
                h: 20,
                image: leadImg,
              ),
              Expanded(
                child: TextFormField(
                  controller: textController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(
                      (hint == S.current.royalties) ? 2 : 256,
                    ),
                  ],
                  keyboardType: inputType,
                  cursorColor: AppTheme.getInstance().whiteColor(),
                  style: textNormal(
                    AppTheme.getInstance().whiteColor(),
                    16,
                  ),
                  onChanged: (value) {
                    onChange(value);
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 18.w),
                    counterText: '',
                    hintText: hint,
                    hintStyle: textNormal(
                      Colors.white.withOpacity(0.5),
                      16,
                    ),
                    suffixStyle: textCustom(),
                    suffixText: suffixes.isNotEmpty ? suffixes : null,
                    prefixText: prefixText.isNotEmpty ? prefixText : null,
                    border: InputBorder.none,
                  ),
                  // onFieldSubmitted: ,
                ),
              ),
              if (img2.isNotEmpty)
                GestureDetector(
                  onTap: onImageTap,
                  child: sizedSvgImage(
                    w: (img2 == ImageAssets.ic_expand_white_svg) ? 10 : 20,
                    h: (img2 == ImageAssets.ic_expand_white_svg) ? 10 : 20,
                    image: img2,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget errorMessage(String _mess) {
  return Row(
    children: [
      if (_mess.isEmpty)
        const SizedBox.shrink()
      else
        Container(
          margin: EdgeInsets.only(top: 4.h),
          child: Text(
            _mess,
            style: textNormal(
              Colors.red,
              14,
            ),
            textAlign: TextAlign.start,
          ),
        )
    ],
  );
}
