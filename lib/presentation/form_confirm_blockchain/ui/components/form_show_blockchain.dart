import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/form_confirm_blockchain/bloc/form_field_blockchain_cubit.dart';
import 'package:Dfy/presentation/form_confirm_blockchain/ui/components/form_field_cf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormShowCfBlockchain extends StatelessWidget {
  const FormShowCfBlockchain({
    Key? key,
    required this.nameToken,
    required this.gasLimitFirstFetch,
    required this.gasPriceFirstFetch,
    required this.balanceWallet,
    required this.gasFeeFirstFetch,
    required this.txtGasLimit,
    required this.txtGasPrice,
    required this.cubitFormCF,
  }) : super(key: key);
  final TextEditingController txtGasLimit;
  final TextEditingController txtGasPrice;
  final double gasPriceFirstFetch;
  final double gasLimitFirstFetch;
  final double gasFeeFirstFetch;
  final double balanceWallet;
  final String nameToken;
  final FormFieldBlockchainCubit cubitFormCF;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 343.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16.r)),
            border: Border.all(color: const Color.fromRGBO(255, 255, 255, 0.1)),
          ),
          padding: EdgeInsets.only(
            top: 8.h,
            left: 16.w,
            // right: 16.w,
            bottom: 24.h,
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  right: 16.w,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //todo handle when insufficient gas fee
                        txtEstimateGasFee(),
                        StreamBuilder<bool>(
                          stream: cubitFormCF.isSufficientGasFeeStream,
                          builder: (context, snapshot) {
                            return snapshot.data ??
                                    gasFeeFirstFetch > balanceWallet
                                ? StreamBuilder<String>(
                                    initialData: gasFeeFirstFetch.toString(),
                                    stream: cubitFormCF
                                        .txtGasFeeWhenEstimatingStream,
                                    builder: (context, snapshot) {
                                      // return txtGasFeeNotWarning(
                                      //   snapshot: snapshot.data ??
                                      //       gasFeeFirstFetch.toString(),
                                      // );
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                          return txtGasFeeNotWarning(
                                              snapshot: '${snapshot.data}');
                                        case ConnectionState.waiting:
                                          return txtGasFeeNotWarning(
                                              snapshot: '${snapshot.data}');
                                        case ConnectionState.active:
                                          return txtGasFeeNotWarning(
                                              snapshot: '${snapshot.data}');
                                        case ConnectionState.done:
                                          return txtGasFeeNotWarning(
                                              snapshot: '${snapshot.data}');
                                      }
                                    },
                                  )
                                : StreamBuilder<String>(
                                    initialData: gasFeeFirstFetch.toString(),
                                    stream: cubitFormCF
                                        .txtGasFeeWhenEstimatingStream,
                                    builder: (context, snapshot) {
                                      // return txtGasFeeWarning(
                                      //   snapshot: snapshot.data ??
                                      //       gasFeeFirstFetch.toString(),
                                      // );
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                          return txtGasFeeWarning(
                                              snapshot: '${snapshot.data}');
                                        case ConnectionState.waiting:
                                          return txtGasFeeWarning(
                                              snapshot: '${snapshot.data}');
                                        case ConnectionState.active:
                                          return txtGasFeeWarning(
                                              snapshot: '${snapshot.data}');
                                        case ConnectionState.done:
                                          return txtGasFeeWarning(
                                              snapshot: '${snapshot.data}');
                                      }
                                    },
                                  );
                          },
                        )
                      ],
                    ),
                    spaceH3,
                    GestureDetector(
                      onTap: () {
                        cubitFormCF.isShowCustomizeFee(isShow: false);
                      },
                      child: btnHideCustomize(),
                    ),
                  ],
                ),
              ),
              spaceH16,
              Container(
                padding: EdgeInsets.only(
                  right: 16.w,
                ),
                child: Divider(
                  thickness: 1,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
              spaceH16,
              FormFieldBlockChain(
                txtController: txtGasPrice,
                formGasFee: FORM_GAS_FEE.LIMIT,
                cubit: cubitFormCF,
                balanceFetchFirst: balanceWallet,
                numHandle: txtGasLimit.text,
              ),
              spaceH16,
              FormFieldBlockChain(
                txtController: txtGasLimit,
                formGasFee: FORM_GAS_FEE.PRICE,
                cubit: cubitFormCF,
                balanceFetchFirst: balanceWallet,
                numHandle: txtGasPrice.text,
              ),
              spaceH24,
              GestureDetector(
                onTap: () {
                  txtGasPrice.text = gasPriceFirstFetch.toString();
                  txtGasLimit.text = gasLimitFirstFetch.toString();
                  cubitFormCF.isSufficientGasFeeSink
                      .add(gasFeeFirstFetch > balanceWallet);
                  cubitFormCF.txtGasFeeWhenEstimatingSink
                      .add(gasFeeFirstFetch.toString());
                },
                child: btnReset(),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 40.h,
        ),
      ],
    );
  }

  Column txtGasFeeWarning({required String snapshot}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$snapshot $nameToken',
          style: textNormalCustom(
            Colors.red,
            16,
            FontWeight.w600,
          ),
        ),
        spaceH2,
        Text(
          S.current.insufficient_balance,
          style: textNormalCustom(
            Colors.red,
            12,
            FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Column txtGasFeeNotWarning({required String snapshot}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$snapshot $nameToken',
          style: textNormalCustom(
            Colors.white,
            16,
            FontWeight.w600,
          ),
        ),
        spaceH16,
      ],
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
        14,
        FontWeight.w400,
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
