import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/form/form_input.dart';
import 'package:Dfy/widgets/form/form_text_import_token.dart';
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
    trustWalletChannel
        .setMethodCallHandler(widget.bloc.nativeMethodCallBackTrustWallet);
    controller = TextEditingController();
    controller.addListener(() {
      widget.bloc.tokenAddressText.sink.add(controller.text);
      if (controller.text == '') {
        widget.bloc.tokenSymbol.sink.add(S.current.token_symbol);
        widget.bloc.tokenDecimal.sink.add(S.current.token_decimal);
      } else {}
    });
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
        if (state is NavigatorSuccessfully) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const TokenSuccessfully();
              },
            ),
          );
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
                      textValidate(),
                      spaceH16,
                      StreamBuilder<String>(
                        initialData: S.current.token_symbol,
                        stream: widget.bloc.tokenSymbol,
                        builder: (context, snapshot) {
                          return FromTextImportToken(
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
                          return FromTextImportToken(
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
                child: StreamBuilder<bool>(
                  stream: widget.bloc.isTokenEnterAddress,
                  initialData: false,
                  builder: (context, snapshot) {
                    final bool enable = snapshot.data ?? false;
                    return InkWell(
                      onTap: () async {
                        final String icon = await widget.bloc
                            .getIcon(widget.bloc.tokenAddressText.value);
                        widget.bloc.checkAddressNull();
                        if (enable) {
                          await widget.bloc
                              .getListPrice(widget.bloc.tokenSymbol.value);
                          print(widget.bloc.addressWallet.value);
                          print(widget.bloc.tokenAddressText.value);
                          print(widget.bloc.tokenSymbol.value);
                          print(widget.bloc.tokenDecimal.value);
                          print('-----$icon');
                          print(widget.bloc.tokenFullName);
                          print(widget.bloc.price);
                          print('vao');
                          widget.bloc.importToken(
                            walletAddress: widget.bloc.addressWallet.value,
                            tokenAddress: widget.bloc.tokenAddressText.value,
                            symbol: widget.bloc.tokenSymbol.value,
                            decimal: int.parse(widget.bloc.tokenDecimal.value),
                            iconToken: icon,
                            tokenFullName: widget.bloc.tokenFullName,
                            exchangeRate: widget.bloc.price!,
                            isImport: true,
                          );
                        }
                      },
                      child: ButtonGold(
                        title: S.current.import,
                        isEnable: enable,
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

  Widget showTextValidateOldPassword() {
    return StreamBuilder(
      stream: widget.bloc.isShowValidateText,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return Visibility(
          visible: snapshot.data ?? false,
          child: Column(
            children: [
              SizedBox(
                height: 4.h,
              ),
              SizedBox(
                width: 343.w,
                // height: 30.h,
                child: StreamBuilder<String>(
                  stream: widget.bloc.warningText,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(255, 108, 108, 1),
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

  Widget textValidate() {
    return StreamBuilder<String>(
      stream: widget.bloc.messStream,
      builder: (context, snapshot) {
        final _mess = snapshot.data ?? '';
        if (_mess.isNotEmpty) {
          return Column(
            children: [
              SizedBox(
                height: 4.h,
              ),
              SizedBox(
                width: 343.w,
                // height: 30.h,
                child: Text(
                  _mess,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(255, 108, 108, 1),
                  ),
                ),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
