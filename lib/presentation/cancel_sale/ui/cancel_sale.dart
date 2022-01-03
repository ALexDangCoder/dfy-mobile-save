import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_luxury.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CancelSale extends StatelessWidget {
  final String ntfName;
  final int quantity;

  const CancelSale({Key? key, required this.ntfName, required this.quantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseBottomSheet(
        title: S.current.cancel_sale,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.current.cancel_sale_info,
                      style: textNormal(
                        AppTheme.getInstance().whiteColor(),
                        16.sp,
                      ).copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                            'NFT:',
                            style: textNormal(
                              AppTheme.getInstance().currencyDetailTokenColor(),
                              16.sp,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(
                            ntfName,
                            style: textNormal(
                              AppTheme.getInstance().whiteColor(),
                              16.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                            S.current.quantity,
                            style: textNormal(
                              AppTheme.getInstance().currencyDetailTokenColor(),
                              16.sp,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Text(
                            '$quantity',
                            style: textNormal(
                              AppTheme.getInstance().whiteColor(),
                              16.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        sizedSvgImage(
                            w: 16.67.w,
                            h: 16.67.h,
                            image: ImageAssets.ic_warning_canel),
                        SizedBox(
                          width: 5.w,
                        ),
                        Expanded(
                          child: Text(
                            S.current.customer_cannot,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: textNormal(
                              AppTheme.getInstance().currencyDetailTokenColor(),
                              14.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 22.h,
                    ),
                    Divider(
                      height: 1.h,
                      color: AppTheme.getInstance().whiteBackgroundButtonColor(),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    containerWithBorder(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: Image.asset(
                                ImageAssets.ic_face_id,
                                height: 40.h,
                                width: 40.w,
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Vuhanam',
                                      style: textNormal(
                                        AppTheme.getInstance().whiteColor(),
                                        16.sp,
                                      ).copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Text(
                                      '0xFFs...dfd',
                                      style: textNormal(
                                        AppTheme.getInstance()
                                            .currencyDetailTokenColor(),
                                        14.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${S.current.balance}: 3232',
                                  style: textNormal(
                                    AppTheme.getInstance().whiteColor(),
                                    16.sp,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    containerWithBorder(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 8.0.h,
                          left: 16.w,
                          right: 16.w,
                          bottom: 12.h,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${S.current.estimate_gas_fee}:',
                                  style: textNormal(
                                    AppTheme.getInstance().whiteColor(),
                                    16.sp,
                                  ).copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '555 BNB',
                                  style: textNormal(
                                    AppTheme.getInstance().whiteColor(),
                                    16.sp,
                                  ).copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              S.current.customize_fee,
                              style: textNormal(
                                AppTheme.getInstance().blueColor(),
                                14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            ButtonLuxury(
              title: S.current.cancel_sale,
              isEnable: true,
            ),
          ],
        ),
      ),
    );
  }

  Container containerWithBorder({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.getInstance().whiteBackgroundButtonColor(),
          width: 1.w,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: child,
    );
  }
}
