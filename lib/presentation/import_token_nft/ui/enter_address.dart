import 'package:Dfy/config/resources/images.dart';
import 'package:Dfy/config/resources/strings.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/import_token_nft/bloc/import_token_nft_bloc.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/form/form_input.dart';

import 'package:Dfy/widgets/form/form_input2.dart';
import 'package:Dfy/widgets/form/form_input_number.dart';
import 'package:Dfy/widgets/form/form_text.dart';
import 'package:Dfy/widgets/form/form_text2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../main.dart';
import 'import_nft_succesfully.dart';
import 'import_token_succesfully.dart';

class EnterAddress extends StatefulWidget {
  const EnterAddress({Key? key, required this.bloc}) : super(key: key);
  final ImportTokenNftBloc bloc;

  @override
  _EnterAddressState createState() => _EnterAddressState();
}

class _EnterAddressState extends State<EnterAddress> {
  late final TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    controller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

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
                    controller: controller,
                    urlIcon1: url_ic_address,
                    hint: 'Token address',
                    urlIcon2: url_ic_qr,
                    bloc: widget.bloc,
                  ),
                  spaceH16,
                  FromText2(
                    title:'Token symbol',
                    urlPrefixIcon:  url_ic_symbol,
                    urlSuffixIcon: '',
                  ),
                  spaceH16,
                  FromText2(
                    title:'Token decimal',
                    urlPrefixIcon:  url_ic_decimal,
                    urlSuffixIcon: '',
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
                if (widget.bloc.isImportToken()) {
                  widget.bloc.importToken(
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
                    widget.bloc.nativeMethodCallBackTrustWallet,
                  );
                } else {
                  _showToast();
                  showTokenSuccessfully(context);
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
