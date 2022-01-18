import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoPopup extends StatelessWidget {
  final String name;
  final String content;
  final String content2;

  const InfoPopup({
    Key? key,
    required this.name,
    required this.content,
    this.content2 = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: GestureDetector(
            onTap: () {
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              width: 311.h,
              decoration: BoxDecoration(
                color: AppTheme.getInstance().selectDialogColor(),
                borderRadius: BorderRadius.circular(36),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        name,
                        style: textCustom(
                          fontSize: 20,
                          weight: FontWeight.w700,
                        ),
                      ),),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: sizedSvgImage(w: 20, h: 20, image: ImageAssets.x_svg),
                      ),
                    ],
                  ),
                  spaceH24,
                  Text(
                    content,
                    style: textCustom(),
                  ),
                  if (content2.isNotEmpty)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        spaceH12,
                        Text(
                          content2,
                          style: textCustom(),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
