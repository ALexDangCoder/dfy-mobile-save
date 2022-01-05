import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/form_confirm_blockchain/ui/components/form_field_cf.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletInfoWithGasFee extends StatefulWidget {
  const WalletInfoWithGasFee({Key? key}) : super(key: key);

  @override
  _WalletInfoWithGasFeeState createState() => _WalletInfoWithGasFeeState();
}

class _WalletInfoWithGasFeeState extends State<WalletInfoWithGasFee> {
  bool isCustomFee = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
                            AppTheme.getInstance().currencyDetailTokenColor(),
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
              mainAxisSize: MainAxisSize.min,
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
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isCustomFee = !isCustomFee;
                    });
                  },
                  child: Text(
                    isCustomFee
                        ? S.current.hide_customize_fee
                        : S.current.customize_fee,
                    style: textNormal(
                      AppTheme.getInstance().blueColor(),
                      14.sp,
                    ),
                  ),
                ),
                if (isCustomFee)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Divider(
                        height: 1.h,
                        color:
                            AppTheme.getInstance().whiteBackgroundButtonColor(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              S.current.gas_limit,
                              style: textNormal(
                                AppTheme.getInstance().whiteColor(),
                                16.sp,
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              style: TextStyle(
                                color: AppTheme.getInstance().whiteColor(),
                              ),
                              decoration: InputDecoration(
                                hintText: 'AB',
                                hintStyle: TextStyle(
                                  color: AppTheme.getInstance().whiteColor(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              S.current.gas_limit,
                              style: textNormal(
                                AppTheme.getInstance().whiteColor(),
                                16.sp,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppTheme.getInstance().bgTextFormField(),
                              ),
                              child: TextFormField(
                                style: TextStyle(
                                  color: AppTheme.getInstance().whiteColor(),
                                ),
                                textAlign: TextAlign.end,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: 'ok babe',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: AppTheme.getInstance().whiteColor(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
              ],
            ),
          ),
        )
      ],
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
