import 'dart:ui';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/import_token_nft/ui/import_nft_succesfully.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/form/form_input3.dart';
import 'package:Dfy/widgets/form/form_input_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImportNft extends StatelessWidget {
  const ImportNft({
    Key? key,
    required this.bloc,
    required this.addressWallet,
  }) : super(key: key);
  final WalletCubit bloc;
  final String addressWallet;

  @override
  Widget build(BuildContext context) {
    return _Body(
      bloc: bloc,
      addressWallet: addressWallet,
    );
  }
}

class _Body extends StatefulWidget {
  final WalletCubit bloc;
  final String addressWallet;

  const _Body({
    Key? key,
    required this.bloc,
    required this.addressWallet,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // trustWalletChannel
    //     .setMethodCallHandler(widget.bloc.nativeMethodCallBackTrustWallet);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WalletCubit, WalletState>(
      listener: (context, state) {
        if (state is ImportNftSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const NFTSuccessfully();
              },
            ),
          ).whenComplete(
            () async {
              await widget.bloc.getNFT('0x588B1b7C48517D1C8E1e083d4c05389D2E1A5e37');
              widget.bloc.listNFTStream.add(widget.bloc.listNftFromWalletCore);
            },
          );
        } else {
          _showDialog(alert: 'Import failed');
        }
      },
      bloc: widget.bloc,
      builder: (context, _) {
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
                        spaceH4,
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
                                        14,
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
                  stream: widget.bloc.tokenAddressTextNft,
                  builder: (context, snapshot) {
                    return InkWell(
                      onTap: () async {
                        widget.bloc.checkAddressNullNFT();
                        if (widget.bloc.nftEnterID.value.isNotEmpty &&
                            await Web3Utils().importNFT(
                              contract:
                                  '0x51eE4cFa0363BAA22cE8d628ef1F75D7eE4C24a1',
                              id: int.parse(
                                widget.bloc.nftEnterID.value,
                              ),
                            )) {
                          await widget.bloc.emitJsonNftToWalletCore(
                            contract:
                                '0x51eE4cFa0363BAA22cE8d628ef1F75D7eE4C24a1',
                            id: int.parse(
                              widget.bloc.nftEnterID.value,
                            ),
                            address:
                                '0x588B1b7C48517D1C8E1e083d4c05389D2E1A5e37',
                          );

                          // if (widget.bloc.isNFT.value) {
                          //   await widget.bloc.importNft(
                          //     walletAddress: widget.addressWallet,
                          //     nftAddress: widget.bloc.tokenAddressTextNft.value,
                          //     nftID: int.parse(widget.bloc.nftEnterID.value),
                          //     nftName: widget.bloc.nftName,
                          //     iconNFT: widget.bloc.iconNFT,
                          //     collectionAddress: '',
                          //   );
                          //
                          //   widget.bloc.isImportNft.listen(
                          //     (value) async {
                          //       if (value
                          //           &&
                          //           await Web3Utils().importNFT(
                          //             contract:
                          //                 widget.bloc.tokenAddressTextNft.value,
                          //             id: int.parse(
                          //                 widget.bloc.nftEnterID.value),
                          //           )
                          //       ) {
                          //         await widget.bloc.emitJsonNftToWalletCore(
                          //           contract:
                          //               '0x51eE4cFa0363BAA22cE8d628ef1F75D7eE4C24a1',
                          //           id: int.parse(
                          //             widget.bloc.nftEnterID.value,
                          //           ),
                          //           address:
                          //               '0x588B1b7C48517D1C8E1e083d4c05389D2E1A5e37',
                          //         );
                          //       }
                          //     },
                          //   );
                          //   widget.bloc.isImportNftFail.listen(
                          //     (value) {
                          //       if (!value) {
                          //         _showDialog(
                          //           text: S.current.please_try_again,
                          //           alert: S.current.you_are_not,
                          //         );
                          //         widget.bloc.isImportNftFail.close();
                          //       }
                          //     },
                          //   );
                          // }
                        } else {
                          // await widget.bloc.importAllNFT(
                          //   walletAddress:
                          //       widget.bloc.tokenAddressTextNft.value,
                          //   contract: widget.bloc.tokenAddressTextNft.value,
                          // );
                          if (await Web3Utils().importNFT(
                              contract:
                                  widget.bloc.tokenAddressTextNft.value)) {
                            await widget.bloc.emitJsonNftToWalletCore(
                              contract:
                                  '0x51eE4cFa0363BAA22cE8d628ef1F75D7eE4C24a1',
                              address:
                                  '0x588B1b7C48517D1C8E1e083d4c05389D2E1A5e37',
                            );
                          }
                        }
                      },
                      child: ButtonGold(
                        title: S.current.import,
                        isEnable:
                            widget.bloc.tokenAddressTextNft.value.isNotEmpty,
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

  void _showDialog({String? alert, String? text}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                36.0.r,
              ),
            ),
          ),
          backgroundColor: AppTheme.getInstance().selectDialogColor(),
          title: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  alert ?? S.current.password_is_not_correct,
                  style: textNormalCustom(
                    Colors.white,
                    20.sp,
                    FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              spaceH16,
              Text(
                text ?? S.current.please_try_again,
                style: textNormalCustom(
                  Colors.white,
                  12.sp,
                  FontWeight.w400,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Divider(
              height: 1.h,
              color: AppTheme.getInstance().divideColor(),
            ),
            Center(
              child: TextButton(
                child: Text(
                  S.current.ok,
                  style: textNormalCustom(
                    AppTheme.getInstance().fillColor(),
                    20.sp,
                    FontWeight.w700,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
