import 'package:Dfy/config/resources/images.dart';
import 'package:Dfy/config/resources/strings.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/import_token_nft/bloc/import_token_nft_bloc.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/form/form_input.dart';
import 'package:Dfy/widgets/form/form_input2.dart';
import 'package:Dfy/widgets/form/form_input_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../main.dart';

class EnterAddress extends StatelessWidget {
  final ImportTokenNftBloc bloc;
  final TextEditingController textTokenAddress;

  const EnterAddress(
      {Key? key, required this.bloc, required this.textTokenAddress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FToast fToast = FToast();
    fToast.init(context);
    void _showToast() {
      final Widget toast = Container(
        margin: EdgeInsets.only(bottom: 70.h),
        height: 35.h,
        width: 298.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.black.withOpacity(0.5),
        ),
        padding: EdgeInsets.only(left: 10.w, top: 10.h),
        child: Text(
          S.current.failed,
          style: TextStyle(color: Colors.red, fontSize: 14.sp),
        ),
      );
      fToast.showToast(
        child: toast,
        gravity: ToastGravity.BOTTOM,
        toastDuration: const Duration(seconds: 2),
      );
    }

    return SizedBox(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  spaceH24,
                  FormInput(
                    controller: textTokenAddress,
                    urlIcon2: url_ic_qr,
                    bloc: bloc,
                    urlIcon1: url_ic_address,
                    hint: Strings.token_address,
                  ),
                  spaceH16,
                  FormInput2(
                    urlIcon1: url_ic_symbol,
                    bloc: bloc,
                    hint: Strings.token_symbol,
                  ),
                  spaceH16,
                  FormInputNumber(
                    urlIcon1: url_ic_decimal,
                    bloc: bloc,
                    hint: Strings.token_decimal,
                  ),
                  SizedBox(
                    height: 289.h,
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: InkWell(
              onTap: () {
                if (bloc.isImportToken()) {
                  bloc.importToken(
                    walletAddress: "walletAddress",
                    tokenAddress: "tokenAddress",
                    symbol: "symbol",
                    decimal: 1,
                  );
                  //  bloc.getListSupportedToken(walletAddress: 'walletAddress');

                  // bloc.importNft(
                  //     walletAddress: "walletAddress",
                  //     nftAddress: "nftAddress",
                  //     nftID: 111);
                  // bloc.setShowedToken(
                  //     walletAddress: "walletAddress", tokenID: 111, isShow: true);
                  // bloc.setShowedNft(
                  //     walletAddress: "walletAddress", nftID: 23213, isShow: true);
                  trustWalletChannel.setMethodCallHandler(
                    bloc.nativeMethodCallBackTrustWallet,
                  );
                } else {
                  _showToast();
                }
              },
              child: const ButtonGold(
                title: Strings.import,
                isEnable: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
