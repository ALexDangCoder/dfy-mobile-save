import 'dart:async';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/widgets/scan_qr/scan_qr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormInputAddressNFT extends StatelessWidget {
  final String urlIcon1;
  final String urlIcon2;
  final WalletCubit bloc;
  final String hint;
  final String idNft;
  final TextEditingController controller;

  const FormInputAddressNFT({
    Key? key,
    required this.urlIcon1,
    required this.urlIcon2,
    required this.bloc,
    required this.idNft,
    required this.hint,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 64.h,
      padding: EdgeInsets.only(right: 15.w, left: 15.w),
      decoration: BoxDecoration(
        color: const Color(0xff32324c),
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
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
                maxLength: 100,
                onChanged: (value) {
                  bloc.currentAddressNft = value;
                  bloc.checkValidateAddress(value: value);
                  bloc.checkValidateIdNft(value: idNft);
                },
                controller: controller,
                cursorColor: AppTheme.getInstance().whiteColor(),
                style: textNormal(
                  AppTheme.getInstance().whiteColor(),
                  16.sp,
                ),
                decoration: InputDecoration(
                  counterText: '',
                  hintText: hint,
                  hintStyle: textNormal(
                    Colors.white.withOpacity(0.5),
                    16.sp,
                  ),
                  border: InputBorder.none,
                ),
                // onFieldSubmitted: ,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return QRViewExample(
                      bloc: bloc,
                      controller: controller,
                    );
                  },
                ),
              ).then(
                (_) {
                  bloc.currentAddressNft = controller.text;
                  bloc.checkValidateAddress(value: controller.text);
                  bloc.checkValidateIdNft(value: idNft);
                }
              );
            },
            child: SizedBox(
              width: 24.w,
              height: 24.h,
              child: Image.asset(
                urlIcon2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
