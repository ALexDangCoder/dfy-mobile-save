import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/form_confirm_blockchain/bloc/form_field_blockchain_cubit.dart';
import 'package:Dfy/presentation/form_confirm_blockchain/ui/components/form_field_cf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormShowFtHideCfBlockchain extends StatelessWidget {
  const FormShowFtHideCfBlockchain({
    Key? key,
    required this.nameToken,
    required this.cubit,
    required this.txtGasLimit,
    required this.txtGasPrice,
    required this.gasPriceFirstFetch,
    required this.gasLimitFirstFetch,
    required this.gasFeeFirstFetch,
    required this.balanceWallet,
    // required this.isShowCustomizeFee,
  }) : super(key: key);

  final String nameToken;
  final FormFieldBlockchainCubit cubit;
  final TextEditingController txtGasLimit;
  final TextEditingController txtGasPrice;
  final double gasPriceFirstFetch;
  final double gasLimitFirstFetch;
  final double gasFeeFirstFetch;
  final double balanceWallet;

  // final bool isShowCustomizeFee;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ///this stream handle form show/hide
              StreamBuilder<bool>(
                // initialData: false,
                stream: cubit.isCustomizeGasFeeStream,
                builder: (context, snapshot) {
                  return snapshot.data ?? false
                      ? Container(
                    height: 331.h,
                    width: 343.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16.r)),
                      border: Border.all(
                          color: const Color.fromRGBO(255, 255, 255, 0.1)),
                    ),
                    padding: EdgeInsets.only(
                      top: 8.h,
                      left: 16.w,
                      // right: 16.w,
                      bottom: 24.h,
                    ),
                  )
                      : Container(
                    padding: EdgeInsets.only(
                      top: 8.h,
                      left: 16.w,
                      right: 16.w,
                      bottom: 12.h,
                    ),
                    height: 78.h,
                    width: 343.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16.r)),
                      border: Border.all(
                          color: const Color.fromRGBO(255, 255, 255, 0.1)),
                    ),
                  );
                },
              ),

              ///this stream handle btn show/hide
              StreamBuilder<bool>(
                stream: cubit.isCustomizeGasFeeStream,
                builder: (context, snapshot) {
                  return snapshot.data ?? false
                      ? Positioned(
                    top: 48.h,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            cubit.isShowCustomizeFee(isShow: false);
                          },
                          child: btnHideCustomize(),
                        ),
                        spaceH16,
                        // Text('HUY', style: TextStyle(color: Colors.white),)
                        Container(
                          width: 343.w,
                          height: 1.h,
                          color: Colors.white.withOpacity(0.1),
                        )
                      ],
                    ),
                  )
                      : Positioned(
                    top: 48.h,
                    child: GestureDetector(
                      onTap: () {
                        cubit.isShowCustomizeFee(isShow: true);
                      },
                      child: btnShowCustomize(),
                    ),
                  );
                },
              ),
              Positioned(
                top: 8.h,
                left: 16.w,
                child: txtEstimateGasFee(),
              ),
              Positioned(
                top: 8.h,
                right: 16.w,
                child: StreamBuilder<bool>(
                  initialData: gasFeeFirstFetch > balanceWallet,
                  stream: cubit.isSufficientGasFeeStream,
                  builder: (context, snapshot) {
                    return snapshot.data ?? gasFeeFirstFetch > balanceWallet
                        ? StreamBuilder<String>(
                      initialData: gasFeeFirstFetch.toString(),
                      stream: cubit.txtGasFeeWhenEstimatingStream,
                      builder: (context, snapshot) {
                        return txtGasFeeNotWarning(
                          snapshot:
                          snapshot.data ?? gasFeeFirstFetch.toString(),
                        );
                      },
                    )
                        : StreamBuilder<String>(
                      initialData: gasFeeFirstFetch.toString(),
                      stream: cubit.txtGasFeeWhenEstimatingStream,
                      builder: (context, snapshot) {
                        return txtGasFeeWarning(
                          snapshot:
                          snapshot.data ?? gasFeeFirstFetch.toString(),
                        );
                      },
                    );
                  },
                ),
              ),
              StreamBuilder<bool>(
                stream: cubit.isCustomizeGasFeeStream,
                builder: (context, snapshot) {
                  return snapshot.data ?? false
                      ? Container(
                    // color: Colors.red,
                    // top: 99.h,
                    margin: EdgeInsets.only(
                      top: 50.h,
                      left: 16.w,
                      right: 1.w,
                    ),
                    child: Column(
                      children: [
                        spaceH16,
                        FormFieldBlockChain(
                          txtController: txtGasPrice,
                          formGasFee: FORM_GAS_FEE.LIMIT,
                          cubit: cubit,
                          balanceFetchFirst: balanceWallet,
                          numHandle: txtGasLimit.text,
                        ),
                        spaceH16,
                        FormFieldBlockChain(
                          txtController: txtGasLimit,
                          formGasFee: FORM_GAS_FEE.PRICE,
                          cubit: cubit,
                          balanceFetchFirst: balanceWallet,
                          numHandle: txtGasPrice.text,
                        ),
                        spaceH24,
                        GestureDetector(
                          onTap: () {
                            txtGasPrice.text = gasPriceFirstFetch.toString();
                            txtGasLimit.text = gasLimitFirstFetch.toString();
                            cubit.isSufficientGasFeeSink
                                .add(gasFeeFirstFetch > balanceWallet);
                            cubit.txtGasFeeWhenEstimatingSink
                                .add(gasFeeFirstFetch.toString());
                          },
                          child: btnReset(),
                        ),
                      ],
                    ),
                  )
                      : Container();
                },
              ),
            ],
          ),
          SizedBox(height: 24.h,),
        ],
      ),
    );
  }

  Column txtGasFeeWarning({required String snapshot}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$snapshot $nameToken',
          style: textNormalCustom(
            AppTheme.getInstance().redColor(),
            16.sp,
            FontWeight.w600,
          ),
        ),
        // spaceH2,
        Text(
          S.current.insufficient_balance,
          style: textNormalCustom(
            AppTheme.getInstance().redColor(),
            12.sp,
            FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Text txtGasFeeNotWarning({required String snapshot}) {
    return Text(
      '$snapshot $nameToken',
      style: textNormalCustom(
        AppTheme.getInstance().whiteColor(),
        16,
        FontWeight.w600,
      ),
    );
  }

  Text txtEstimateGasFee() {
    return Text(
      S.current.estimate_gas_fee,
      style: textNormalCustom(
        AppTheme.getInstance().whiteColor(),
        16,
        FontWeight.w600,
      ),
    );
  }

  Text btnHideCustomize() {
    return Text(
      S.current.hide_customize_fee,
      style: textNormalCustom(
        const Color.fromRGBO(70, 188, 255, 1),
        14.sp,
        FontWeight.w400,
      ),
    );
  }

  Container btnReset() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppTheme.getInstance().selectDialogColor(),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        S.current.reset,
        style: textNormalCustom(
          AppTheme.getInstance().textThemeColor(),
          14.sp,
          FontWeight.w400,
        ),
      ),
    );
  }

  Text btnShowCustomize() {
    return Text(
      S.current.customize_fee,
      style: textNormalCustom(
        const Color.fromRGBO(70, 188, 255, 1),
        14.sp,
        FontWeight.w400,
      ),
    );
  }
}
