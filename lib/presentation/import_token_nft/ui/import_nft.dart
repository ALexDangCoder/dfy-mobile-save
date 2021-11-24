import 'dart:ui';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/import_token_nft/ui/import_nft_succesfully.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/form/form_input3.dart';
import 'package:Dfy/widgets/form/form_input_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../main.dart';

void showImportNft(BuildContext context, WalletCubit bloc) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Body(bloc: bloc);
    },
  );
}

class Body extends StatefulWidget {
  final WalletCubit bloc;

  const Body({Key? key, required this.bloc}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      title: S.current.import_nft,
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                final FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    spaceH24,
                    FormInput3(
                      controller: controller,
                      urlIcon1: ImageAssets.ic_address,
                      hint: S.current.token_address,
                      urlIcon2: ImageAssets.ic_qr_code,
                      bloc: widget.bloc,
                    ),
                    StreamBuilder(
                      stream: widget.bloc.isNFT,
                      builder: (context, snapshot) {
                        return SizedBox(
                          width: 343.w,
                          child: widget.bloc.isNFT.value
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
                    FormInputNumber(
                      urlIcon1: ImageAssets.ic_face_id,
                      bloc: widget.bloc,
                      hint: S.current.enter_id,
                    ),
                    SizedBox(
                      height: 429.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: StreamBuilder(
              stream: widget.bloc.isNFT,
              builder: (context, snapshot) {
                return InkWell(
                  onTap: () {
                    widget.bloc.importNft(
                      walletAddress: 'walletAddress',
                      nftAddress: 'tokenAddress',
                      nftID: 1,
                    );
                    trustWalletChannel.setMethodCallHandler(
                      widget.bloc.nativeMethodCallBackTrustWallet,
                    );
                    widget.bloc.checkAddressNull2();
                    if (widget.bloc.isNFT.value) {
                      showNFTSuccessfully(context);
                    }
                    widget.bloc.setShowedNft(
                      isShow: true,
                      walletAddress: 'walletAddress',
                      nftID: 1,
                      password: '',
                    );
                  },
                  child: ButtonGold(
                    title: S.current.import,
                    isEnable: widget.bloc.isNFT.value,
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
