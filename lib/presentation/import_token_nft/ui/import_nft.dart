import 'dart:ui';
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/import_token_nft/ui/import_nft_succesfully.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
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
    return Container(
      height: 764.h,
      width: 375.w,
      decoration: const BoxDecoration(
        color: Color(0xff3e3d5c),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 323.w,
            height: 28.h,
            margin: EdgeInsets.only(
              left: 26.w,
              top: 16.h,
              right: 26.w,
              bottom: 20.h,
            ),
            child: Row(
              children: [
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(right: 10.w, left: 10.w),
                    child: Image.asset(
                      ImageAssets.ic_back,
                      width: 20.w,
                      height: 20.h,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  margin: EdgeInsets.only(right: 88.w, left: 90.w),
                  child: Text(
                    S.current.import_nft,
                    style: textNormalCustom(null, 20, FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          line,
          spaceH24,
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
                          width: 323.w,
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
                    const SizedBox(
                      height: 429,
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
