import 'dart:math';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/send_token_nft/bloc/send_token_cubit.dart';
import 'package:Dfy/utils/extensions/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowCustomizeFee extends StatelessWidget {
  //todo show warning text
  const ShowCustomizeFee({
    required this.nameToken,
    required this.sendTokenCubit,
    required this.txtGasLimit,
    required this.txtGasPrice,
    required this.gasFee,
    required this.balanceFirstFetch,
    required this.gasLimitFirstFetch,
    required this.gasPriceFirstFetch,
    Key? key,
  }) : super(key: key);
  final String nameToken;
  final SendTokenCubit sendTokenCubit;
  final TextEditingController txtGasLimit;
  final TextEditingController txtGasPrice;
  final double gasFee;
  final double balanceFirstFetch;
  final double gasLimitFirstFetch;
  final double gasPriceFirstFetch;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 8.h),
          width: 321.w,
          height: 343.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16.r)),
            border: Border.all(color: const Color.fromRGBO(255, 255, 255, 0.1)),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 12.w,
                  right: 12.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${S.current.estimate_gas_fee} :',
                      style: textNormalCustom(
                        Colors.white,
                        16,
                        FontWeight.w600,
                      ),
                    ),
                    StreamBuilder<bool>(
                      stream: sendTokenCubit.isSufficientTokenStream,
                      builder: (context, snapshot) {
                        return snapshot.data ?? gasFee < balanceFirstFetch
                            //if sufficient will not show warning red text
                            ? Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    //todo handle amount ??
                                    StreamBuilder<String>(
                                      initialData: gasFee.toString(),
                                      stream: sendTokenCubit
                                          .formEstimateGasFeeStream,
                                      builder: (context, snapshot) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                            top: 8.h,
                                          ),
                                          child: Text(
                                            '${snapshot.data ?? balanceFirstFetch.toString()}'
                                            ' $nameToken',
                                            style: textNormalCustom(
                                              Colors.white,
                                              16,
                                              FontWeight.w600,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              )
                            //else will show warning read text
                            : Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
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
              ),
              SizedBox(
                height: 3.h,
              ),
              //button show hide customize
              GestureDetector(
                child: btnHide(),
                onTap: () => sendTokenCubit.isShowCustomizeFee(isShow: false),
              ),
              SizedBox(
                height: 16.h,
              ),
              const Divider(
                thickness: 1,
                color: Color.fromRGBO(255, 255, 255, 0.1),
              ),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 16.h,
                    ),
                    //form  gas limit
                    Padding(
                      padding: EdgeInsets.only(
                        left: 12.w,
                        right: 12.w,
                      ),
                      child: SizedBox(
                        height: 64.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.current.gas_limit,
                              style: textNormalCustom(
                                Colors.white,
                                14,
                                FontWeight.w400,
                              ),
                            ),
                            formType(
                              txtController: txtGasLimit,
                              numHandle: txtGasPrice.text,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    //form gas price
                    Padding(
                      padding: EdgeInsets.only(
                        left: 12.w,
                        right: 12.w,
                      ),
                      child: SizedBox(
                        height: 64.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${S.current.gas_price} (GWEI)',
                              style: textNormalCustom(
                                Colors.white,
                                16,
                                FontWeight.w400,
                              ),
                            ),
                            formType(
                              txtController: txtGasPrice,
                              numHandle: txtGasLimit.text,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    GestureDetector(
                      child: btnReset(),
                      onTap: () {
                        txtGasPrice.text = gasPriceFirstFetch.toString();
                        txtGasLimit.text = gasLimitFirstFetch.toString();
                        sendTokenCubit.isSufficientTokenSink
                            .add(gasFee < balanceFirstFetch);
                        sendTokenCubit.formEstimateGasFeeSink.add(
                          gasFee.toString(),
                        );
                      },
                    ),

                    SizedBox(
                      height: 24.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 96.h,
        ),
      ],
    );
  }

  Padding btnHide() {
    return Padding(
      padding: EdgeInsets.only(
        left: 12.w,
        right: 12.h,
      ),
      child: Text(
        S.current.hide_customize_fee,
        style: textNormalCustom(
          const Color.fromRGBO(70, 188, 255, 1),
          14,
          FontWeight.w400,
        ),
      ),
    );
  }

  Container
  formType({
    required TextEditingController txtController,
    required String numHandle,
  }) {
    //indexForm = 1 => result = value * numHandle / 10^9 (BNB)
    //indexForm = 2 => result = numHandle * value / 10^9 (BNB)
    return Container(
      height: 64.h,
      width: 178.w,
      padding: EdgeInsets.only(
        top: 10.h,
        // bottom: 20.h,
        left: 20.w,
        right: 20.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
        color: AppTheme.getInstance().itemBtsColors(),
      ),
      child: TextFormField(
        textAlign: TextAlign.right,
        keyboardType: TextInputType.number,
        controller: txtController,
        onChanged: (value) {
          late double result;
          late double valueHandle;
          if (value.isEmpty) {
            valueHandle = 0;
          } else {
            valueHandle = double.parse(value);
          }
          result = (valueHandle * double.parse(numHandle)) / pow(10, 9);
          sendTokenCubit.isEstimatingGasFee(Validator.toExact(result));
          sendTokenCubit.isSufficientGasFee(
            gasFee: result,
            balance: balanceFirstFetch,
          );
        },
        style: textNormal(
          Colors.white,
          16,
        ),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintStyle: textNormal(
            Colors.grey,
            16,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Container btnReset() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(88, 87, 130, 1),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        S.current.reset,
        style: textNormalCustom(
          Colors.white,
          14,
          FontWeight.w400,
        ),
      ),
    );
  }
}
