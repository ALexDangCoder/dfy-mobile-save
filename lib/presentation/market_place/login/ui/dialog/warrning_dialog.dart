import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WarningDialog extends StatelessWidget {
  final String walletAdress;

  const WarningDialog({Key? key, required this.walletAdress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () {},
          child: Center(
            child: Container(
              constraints: BoxConstraints(minHeight: 177.h),
              width: 312.w,
              decoration: BoxDecoration(
                color: AppTheme.getInstance().bgBtsColor(),
                borderRadius: const BorderRadius.all(Radius.circular(36)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 19),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        sizedPngImage(
                            w: 24, h: 28, image: ImageAssets.ic_warning),
                        SizedBox(
                          width: 12.h,
                        ),
                        Text(
                          S.current.warning,
                          style: textNormal(
                            AppTheme.getInstance().whiteColor(),
                            20.sp,
                          ).copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(
                      right: 35,
                      bottom: 24,
                      left: 35,
                    ),
                    child: Text(
                      S.current.no_permission+
                      walletAdress + S.current.no_permission2,
                      style: textNormal(
                        AppTheme.getInstance().whiteColor(),
                        12.sp,
                      ),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        border: Border(
                      top: BorderSide(
                          width: 1.w,
                          color: AppTheme.getInstance()
                              .whiteBackgroundButtonColor()),
                    )),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 19,
                          top: 17,
                        ),
                        child: Text(
                          'OK',
                          style: textNormal(
                            AppTheme.getInstance().fillColor(),
                            20.sp,
                          ).copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
