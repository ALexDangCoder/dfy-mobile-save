import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/widgets/scan_qr/scan_qr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormInput extends StatelessWidget {
  final String urlIcon1;
  final String urlIcon2;
  final WalletCubit bloc;
  final String hint;
  final TextEditingController controller;

  const FormInput({
    Key? key,
    required this.urlIcon1,
    required this.urlIcon2,
    required this.bloc,
    required this.hint,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 64.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
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
            width: 20.w,
            height: 20.h,
            child: Image.asset(
              urlIcon1,
              width: 20.w,
              height: 20.h,
            ),
          ),
          SizedBox(
            width: 20.5.w,
          ),
          Expanded(
            child: TextFormField(
              maxLength: 100,
              controller: controller,
              cursorColor: AppTheme.getInstance().whiteColor(),
              style: textNormal(
                AppTheme.getInstance().whiteColor(),
                16.sp,
              ),
              // onFieldSubmitted: (value) {
              //   bloc.getTokenInfoByAddress(tokenAddress: value);
              //   bloc.checkToken(
              //     walletAddress: bloc.addressWalletCore,
              //     tokenAddress: bloc.tokenAddressText.value,
              //   );
              //   bloc.validateAddressFunc();
              // },
              onChanged: (value) {
                // bloc.checkAddressNull();
                // bloc.getTokenInfoByAddress(tokenAddress: value);
                // bloc.checkToken(
                //   walletAddress: bloc.addressWalletCore,
                //   tokenAddress: bloc.tokenAddressText.value,
                // );
                // bloc.validateAddressFunc();
                // bloc.tokenAddressText.sink.add(value);

                bloc.validateAddressFunc(value);
              },
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
                () => controller.text = bloc.tokenAddressText.value,
              );
            },
            child: SizedBox(
              height: 24.h,
              width: 24.w,
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
