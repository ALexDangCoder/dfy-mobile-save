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

  const FormInputNumber({
    Key? key,
    required this.urlIcon1,
    required this.bloc,
    required this.hint,
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
                maxLength: 100,
                onChanged: (value) async {
                  if (value.isNotEmpty) {
                    final res = await Web3Utils().importNFT(
                      contract: bloc.contractSubject.valueOrNull ?? '',
                      address: bloc.addressWallet.value,
                      id: int.parse(value),
                    );
                    if (res.isSuccess) {
                      bloc.warningSink.add('');
                    } else {
                      bloc.warningSink.add(res.message);
                    }
                    bloc.btnSubject.sink.add(res.isSuccess);
                  }
                },
                onFieldSubmitted: (value) async {
                  final res = await Web3Utils().importNFT(
                    contract: bloc.contractSubject.valueOrNull ?? '',
                    address: bloc.addressWallet.value,
                    id: int.parse(value),
                  );
                  if (res.isSuccess) {
                    bloc.warningSink.add('');
                  } else {
                    bloc.warningSink.add(res.message);
                  }
                  bloc.btnSubject.sink.add(res.isSuccess);
                },
                cursorColor: AppTheme.getInstance().whiteColor(),
                style: textNormal(
                  AppTheme.getInstance().whiteColor(),
                  16.sp,
                ),
                keyboardType: TextInputType.number,
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
        ],
      ),
    );
  }
}
