import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormInputNumber extends StatelessWidget {
  final String urlIcon1;
  final WalletCubit bloc;
  final String hint;
  final String nftAddress;
  final TextEditingController controller;

  const FormInputNumber({
    Key? key,
    required this.urlIcon1,
    required this.bloc,
    required this.hint,
    required this.nftAddress,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 64.h,
      padding: EdgeInsets.only(right: 15.w, left: 15.w),
      decoration: BoxDecoration(
        color: AppTheme.getInstance().itemBtsColors(),
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24.w,
            height: 24.h,
            child: Image.asset(
              urlIcon1,
            ),
          ),
          SizedBox(
            width: 20.5.w,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 1.h, right: 5.w),
              child: TextFormField(
                controller: controller,
                maxLength: 100,
                onChanged: (value)  {
                  bloc.checkValidateIdNft(value: value);
                  bloc.checkValidateAddress(value: bloc.currentAddressNft);
                },
                cursorColor: AppTheme.getInstance().whiteColor(),
                style: textNormal(
                  AppTheme.getInstance().whiteColor(),
                  16,
                ),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  counterText: '',
                  hintText: hint,
                  hintStyle: textNormal(
                    Colors.white.withOpacity(0.5),
                    16,
                  ),
                  border: InputBorder.none,
                ),
                // onFieldSubmitted: ,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
