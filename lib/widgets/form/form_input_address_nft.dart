import 'dart:async';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/widgets/scan_qr/scan_qr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormInputAddressNFT extends StatelessWidget {
  final String urlIcon1;
  final String urlIcon2;
  final WalletCubit bloc;
  final String hint;
  final TextEditingController controller;

  const FormInputAddressNFT({
    Key? key,
    required this.urlIcon1,
    required this.urlIcon2,
    required this.bloc,
    required this.hint,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final regex = RegExp(r'^0x[a-fA-F0-9]{40}$');
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
                  Timer(const Duration(milliseconds: 500), () async {
                    if (value.isNotEmpty && regex.hasMatch(value)) {
                      final res = await Web3Utils().importNFT(
                        contract: value,
                        address: bloc.addressWallet.value,
                      );
                      if (res.isSuccess) {
                        bloc.warningSink.add('');
                      } else {
                        bloc.warningSink.add(S.current.not_exist);
                      }
                      bloc.btnSubject.sink.add(res.isSuccess);
                    }
                    if (!regex.hasMatch(value)) {
                      bloc.warningSink.add(S.current.invalid_address);
                      bloc.btnSubject.sink.add(false);
                    }
                  });
                },
                onFieldSubmitted: (value) async {
                  if (value.isNotEmpty && regex.hasMatch(value)) {
                    final res = await Web3Utils().importNFT(
                      contract: value,
                      address: bloc.addressWallet.value,
                    );
                    bloc.btnSubject.sink.add(res.isSuccess);
                    if (res.isSuccess) {
                      bloc.warningSink.add('');
                    } else {
                      bloc.warningSink.add(S.current.not_exist);
                    }
                  }
                  if (!regex.hasMatch(value)) {
                    bloc.warningSink.add(S.current.invalid_address);
                    bloc.btnSubject.sink.add(false);
                  }
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
              ).whenComplete(
                () => controller.text = bloc.tokenAddressTextNft.value,
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
