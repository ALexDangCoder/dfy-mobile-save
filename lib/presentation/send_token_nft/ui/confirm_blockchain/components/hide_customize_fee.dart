import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/send_token_nft/bloc/send_token_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HideCustomizeFee extends StatelessWidget {
  const HideCustomizeFee({
    required this.nameToken,
    required this.sendTokenCubit,
    required this.balance,
    required this.gasFee,
    Key? key,
  }) : super(key: key);
  final String nameToken;
  final SendTokenCubit sendTokenCubit;
  final double balance;
  final double gasFee;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
                // minHeight: 78.h,
                ),
            child: Container(
              width: 343.w,
              height: 90.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16.r)),
                border:
                    Border.all(color: const Color.fromRGBO(255, 255, 255, 0.1)),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 8.h,
                  bottom: 13.h,
                  left: 12.w,
                  right: 12.h,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.current.estimate_gas_fee,
                          style: textNormalCustom(
                            AppTheme.getInstance().whiteColor(),
                            16,
                            FontWeight.w600,
                          ),
                        ),
                        StreamBuilder(
                          // initialData: gasFee < balance,
                          stream: sendTokenCubit.isSufficientTokenStream,
                          builder: (context, AsyncSnapshot<bool> snapshot) {
                            return snapshot.data ?? gasFee < balance
                                //if sufficient will not show warning red text
                                ? Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        //todo handle amount ??
                                        StreamBuilder<String>(
                                          initialData: gasFee.toString(),
                                          stream: sendTokenCubit
                                              .formEstimateGasFeeStream,
                                          builder: (context, snapshot) {
                                            return Padding(
                                              padding:
                                                  EdgeInsets.only(top: 8.h),
                                              child: Text(
                                                '${snapshot.data} $nameToken',
                                                style: textNormalCustom(
                                                  AppTheme.getInstance()
                                                      .whiteColor(),
                                                  16,
                                                  FontWeight.w600,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        // SizedBox(
                                        //   height: 15.h,
                                        // ),
                                      ],
                                    ),
                                  )
                                //else will show warning read text
                                : Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        StreamBuilder<String>(
                                          initialData: gasFee.toString(),
                                          stream: sendTokenCubit
                                              .formEstimateGasFeeStream,
                                          builder: (context, snapshot) {
                                            return Text(
                                              '${snapshot.data} $nameToken',
                                              style: textNormalCustom(
                                                Colors.red,
                                                16,
                                                FontWeight.w600,
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Text(
                                          S.current.insufficient_balance,
                                          style: textNormalCustom(
                                            Colors.red,
                                            12,
                                            FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: btnShow(),
                        onTap: () =>
                            sendTokenCubit.isShowCustomizeFee(isShow: true),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 275.h,
          ),
        ],
      );

  }

  Text btnShow() {
    return Text(
      S.current.customize_fee,
      style: textNormalCustom(
        const Color.fromRGBO(70, 188, 255, 1),
        14,
        FontWeight.w400,
      ),
    );
  }
}
