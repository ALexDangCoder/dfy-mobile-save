import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/domain/model/token.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/form/form_input.dart';

import 'package:Dfy/widgets/form/form_text2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../main.dart';
import 'import_token_succesfully.dart';

class EnterAddress extends StatefulWidget {
  const EnterAddress({Key? key, required this.bloc}) : super(key: key);
  final WalletCubit bloc;

  @override
  _EnterAddressState createState() => _EnterAddressState();
}

class _EnterAddressState extends State<EnterAddress> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller.addListener(() {
      widget.bloc.tokenAddressText.sink.add(controller.text);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

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
                    controller: controller,
                    urlIcon1: ImageAssets.ic_address,
                    hint: S.current.token_address,
                    urlIcon2: ImageAssets.ic_qr_code,
                    bloc: widget.bloc,
                  ),
                  StreamBuilder(
                    stream: widget.bloc.isTokenAddressText,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: 323.w,
                        child: widget.bloc.isTokenAddressText.value
                            ? null
                            : Text(
                                S.current.invalid_address,
                                style: textNormal(
                                  Colors.red,
                                  14.sp,
                                ),
                                textAlign: TextAlign.start,
                              ),
                      );
                    },
                  ),
                  spaceH16,
                  FromText2(
                    title: S.current.token_symbol,
                    urlPrefixIcon: ImageAssets.ic_token,
                    urlSuffixIcon: '',
                  ),
                  spaceH16,
                  FromText2(
                    title: S.current.token_decimal,
                    urlPrefixIcon: ImageAssets.ic_group,
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
            child: StreamBuilder(
              stream: widget.bloc.isTokenEnterAddress,
              builder: (context, snapshot) {
                return InkWell(
                  onTap: () {
                    widget.bloc.importToken(
                      walletAddress: 'walletAddress',
                      tokenAddress: 'tokenAddress',
                      symbol: 'symbol',
                      decimal: 1,
                    );
                    trustWalletChannel.setMethodCallHandler(
                      widget.bloc.nativeMethodCallBackTrustWallet,
                    );
                    widget.bloc.checkAddressNull();
                    if (widget.bloc.isTokenAddressText.value) {
                     widget.bloc.addToken(TokenModel(
                       price: 34213423,
                       tokenId: 21,
                       iconToken: 'assets/images/Ellipse 39.png',
                       isShow: true,
                       nameToken: 'DoanhCoin',
                       nameTokenSymbol: 'DC',
                       amountToken: 0,
                     ),);
                      showTokenSuccessfully(context);
                    }
                  },
                  child: ButtonGold(
                    title: S.current.import,
                    isEnable: widget.bloc.isTokenEnterAddress.value,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
