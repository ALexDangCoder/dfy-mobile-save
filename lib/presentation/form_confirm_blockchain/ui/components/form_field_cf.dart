import 'dart:math';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/form_confirm_blockchain/bloc/form_field_blockchain_cubit.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum FORM_GAS_FEE {
  LIMIT,
  PRICE,
}

class FormFieldBlockChain extends StatelessWidget {
  const FormFieldBlockChain({
    Key? key,
    required this.txtController,
    required this.formGasFee,
    required this.cubit,
    required this.numHandle,
    required this.balanceFetchFirst,
  }) : super(key: key);
  final TextEditingController txtController;
  final FORM_GAS_FEE formGasFee;
  final FormFieldBlockchainCubit cubit;

  //numHandle depend on type form is gas limit or gas price
  final String numHandle;
  final double balanceFetchFirst;

  @override
  Widget build(BuildContext context) {
    print(numHandle);
    return SizedBox(
      height: 64.h,
      // padding: EdgeInsets.only(left: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (formGasFee == FORM_GAS_FEE.LIMIT)
            Text(
              S.current.gas_limit,
              style: textNormalCustom(
                AppTheme.getInstance().textThemeColor(),
                16.sp,
                FontWeight.w400,
              ),
            )
          else
            Text(
              S.current.gas_price,
              style: textNormalCustom(
                AppTheme.getInstance().textThemeColor(),
                16.sp,
                FontWeight.w400,
              ),
            ),
          Container(
            width: 178.w,
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20.r),
              ),
              color: AppTheme.getInstance().itemBtsColors(),
            ),
            child: Center(
              child: TextFormField(
                // textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.right,
                keyboardType: TextInputType.number,
                controller: txtController,
                style: textNormalCustom(
                  AppTheme.getInstance().textThemeColor(),
                  16.sp,
                  FontWeight.w400,
                ),
                cursorColor: AppTheme.getInstance().textThemeColor(),
                decoration: InputDecoration(
                  hintStyle: textNormal(
                    AppTheme.getInstance().disableColor(),
                    16.sp,
                  ),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  if(formGasFee == FORM_GAS_FEE.LIMIT) {
                    cubit.validateGasLimit(value);
                  } else {
                    cubit.validateGasPrice(value);
                  }
                  late double result;
                  late double valueHandle;
                  if (value.isEmpty) {
                    valueHandle = 0;
                  } else {
                    valueHandle = double.parse(value);
                  }
                  result = (valueHandle * double.parse(numHandle)) / pow(10, 9);
                  // cubit.isEstimatingGasFee(Validator.toExact(result));
                  Decimal convertedNum = Decimal.parse(result.toString());
                  cubit.isEstimatingGasFee(convertedNum.toString());
                  cubit.isSufficientGasFee(
                    gasFee: result,
                    balance: balanceFetchFirst,
                  );
                  if(formGasFee == FORM_GAS_FEE.LIMIT) {
                    cubit.validateGasLimit(value);
                  } else {
                    cubit.validateGasPrice(value);
                  }
                },
              ),
            ),

          ),
        ],
      ),
    );
  }
}
