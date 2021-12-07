import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/form/form_input.dart';

import 'package:Dfy/widgets/form/form_text2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../main.dart';
import 'import_token_succesfully.dart';

class EnterAddress extends StatefulWidget {
  const EnterAddress({
    Key? key,
    required this.bloc,
    required this.addressWallet,
  }) : super(key: key);
  final WalletCubit bloc;
  final String addressWallet;

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
    trustWalletChannel.setMethodCallHandler(
      widget.bloc.nativeMethodCallBackTrustWallet,
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: widget.bloc,
      listener: (context, state) {
        if (state is NavigatorSucces) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const TokenSuccessfully();
              },
            ),
          ).whenComplete(() => widget.bloc.getTokens(widget.addressWallet));
        }
      },
      builder: (context, _) {
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
                      spaceH4,
                      StreamBuilder(
                        stream: widget.bloc.isTokenAddressText,
                        builder: (context, snapshot) {
                          return SizedBox(
                            width: 343.w,
                            child: widget.bloc.isTokenAddressText.value
                                ? null
                                : Text(
                                    S.current.invalid_address,
                                    style: textNormal(
                                      Colors.red,
                                      14,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                          );
                        },
                      ),
                      spaceH16,
                      StreamBuilder<String>(
                        initialData: S.current.token_symbol,
                        stream: widget.bloc.tokenSymbol,
                        builder: (context, snapshot) {
                          return FromText2(
                            title: snapshot.data ?? 'null',
                            urlPrefixIcon: ImageAssets.ic_token,
                            urlSuffixIcon: '',
                          );
                        },
                      ),
                      spaceH16,
                      StreamBuilder<String>(
                        initialData: S.current.token_decimal,
                        stream: widget.bloc.tokenDecimal,
                        builder: (context, snapshot) {
                          return FromText2(
                            title: snapshot.data ?? 'null',
                            urlPrefixIcon: ImageAssets.ic_group,
                            urlSuffixIcon: '',
                          );
                        },
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
                        print('-=------------------${widget.addressWallet}');
                        print('-=------------------${widget.bloc.iconToken}');
                        print(
                            '-=------------------${widget.bloc.tokenFullName}');
                        widget.bloc.importToken(
                          walletAddress: widget.addressWallet,
                          tokenAddress: widget.bloc.tokenAddressText.value,
                          symbol: widget.bloc.tokenSymbol.value,
                          decimal: int.parse(widget.bloc.tokenDecimal.value),
                          iconToken: widget.bloc.iconToken,
                          tokenFullName: widget.bloc.tokenFullName,
                        );
                        widget.bloc.checkAddressNull();
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
      },
    );
  }
}
