import 'package:Dfy/config/resources/images.dart';
import 'package:Dfy/config/resources/strings.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/presentation/import_token_nft/bloc/import_token_nft_bloc.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/form/form_input.dart';
import 'package:Dfy/widgets/form/form_input2.dart';
import 'package:Dfy/widgets/form/form_input_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../main.dart';

class EnterAddress extends StatelessWidget {
  final ImportTokenNftBloc bloc;

  const EnterAddress({Key? key, required this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  spaceH24,
                  FormInput(
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
