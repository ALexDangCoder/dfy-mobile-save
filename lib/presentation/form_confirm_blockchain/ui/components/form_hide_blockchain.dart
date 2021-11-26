import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/form_confirm_blockchain/bloc/form_field_blockchain_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormHideCfBlockchain extends StatelessWidget {
  //todo handle when number with e
  const FormHideCfBlockchain({
    Key? key,
    required this.balance,
    required this.gasFee,
    required this.nameToken,
    required this.cubit,
  }) : super(key: key);
  final double balance;
  final double gasFee;
  final String nameToken;
  final FormFieldBlockchainCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      padding: EdgeInsets.only(
        top: 8.h,
        left: 16.w,
        right: 16.w,
        bottom: 12.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
        border: Border.all(color: const Color.fromRGBO(255, 255, 255, 0.1)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              txtEstimateGasFee(),
              StreamBuilder<bool>(
                stream: cubit.isSufficientGasFeeStream,
                builder: (context, snapshot) {
                  ///IF GAS FEE BIGGER THAN BALANCE WALLET WILL WARNING
                  ///ELSE NOT WARNING
                  return snapshot.data ?? gasFee > balance
                      ? StreamBuilder<String>(
                          initialData: gasFee.toString(),
                          stream: cubit.txtGasFeeWhenEstimatingStream,
                          builder: (context, snapshot) {
                            return txtGasFeeNotWarning(
                              snapshot: snapshot.data ?? '',
                            );
                          },
                        )
                      : StreamBuilder<String>(
                          initialData: gasFee.toString(),
                          stream: cubit.txtGasFeeWhenEstimatingStream,
                          builder: (context, snapshot) {
                            return txtGasFeeWarning(
                              snapshot: snapshot.data ?? '',
                            );
                          },
                        );
                },
              )
            ],
          ),
          spaceH3,
          GestureDetector(
            onTap: () {
              cubit.isShowCustomizeFee(isShow: true);
            },
            child: btnShowCustomize(),
          ),
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
            AppTheme.getInstance().whiteColor(),
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

  Text btnShowCustomize() {
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
