import 'dart:ui';
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/bloc_creare_seedphrase.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/ui/create_seedphrare_confirm.dart';
import 'package:Dfy/presentation/main_screen/ui/main_screen.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/checkbox/checkbox_create_seedphrase.dart';
import 'package:Dfy/widgets/form/form_text.dart';
import 'package:Dfy/widgets/list_passphrase/box_list_passphrasse_copy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../main.dart';

enum TypeScreen { one, two }

class CreateSeedPhrase extends StatelessWidget {
  final BLocCreateSeedPhrase bloc;
  final TypeScreen type;
  final String? typeEarseWallet;

  const CreateSeedPhrase({
    Key? key,
    required this.bloc,
    required this.type,
    this.typeEarseWallet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (bloc.passPhrase.isEmpty) {
      bloc.generateWallet(typeEarseWallet);
    }
    trustWalletChannel.setMethodCallHandler(
      bloc.nativeMethodCallBackTrustWallet,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: _Body(
          bloc: bloc,
          typeScreen: type,
          typeEarseWallet: typeEarseWallet,
        ),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({
    Key? key,
    required this.bloc,
    required this.typeScreen,
    this.typeEarseWallet,
  }) : super(key: key);
  final BLocCreateSeedPhrase bloc;
  final TypeScreen typeScreen;
  final String? typeEarseWallet;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late final TextEditingController nameWalletController;
  bool needName = true;

  @override
  void initState() {
    super.initState();
    nameWalletController = TextEditingController();
    nameWalletController.text = widget.bloc.walletNameCore;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.bloc.isCheckData,
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          if (needName) {
            nameWalletController.text = widget.bloc.walletNameCore;
            needName = false;
            widget.bloc.nameWallet.sink.add(widget.bloc.walletNameCore);
          }
          return GestureDetector(
            onTap: () {
              final FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Container(
              height: 764.h,
              width: 375.w,
              decoration: BoxDecoration(
                color: const Color(0xff3e3d5c),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.h),
                  topRight: Radius.circular(30.h),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 28.h,
                    width: 343.w,
                    margin: EdgeInsets.only(right: 16.w, left: 16.w, top: 16.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(left: 10.w, right: 10.w),
                            child: Image.asset(
                              ImageAssets.ic_back,
                              width: 24.w,
                              height: 17.h,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        Text(
                          S.current.create_new_wallet,
                          style: textNormalCustom(
                            Colors.white,
                            20,
                            FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(left: 10.w, right: 10.w),
                            child: Image.asset(
                              ImageAssets.ic_close,
                              height: 24.h,
                              width: 24.h,
                            ),
                          ),
                          onTap: () {
                            if (widget.typeScreen == TypeScreen.one) {
                              Navigator.pop(context);
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MainScreen(
                                    index: 3,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  spaceH20,
                  line,
                  spaceH24,
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            width: 343.w,
                            height: 64.h,
                            margin: EdgeInsets.symmetric(horizontal: 16.w),
                            padding: EdgeInsets.only(right: 15.w, left: 15.w),
                            decoration: BoxDecoration(
                              color: AppTheme.getInstance().itemBtsColors(),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.r)),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  ImageAssets.ic_wallet,
                                  height: 17.67.h,
                                  width: 19.14.w,
                                ),
                                SizedBox(
                                  width: 20.5.w,
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(right: 5.w),
                                    child: TextFormField(
                                      controller: nameWalletController,
                                      cursorColor: Colors.white,
                                      style: textNormal(
                                        AppTheme.getInstance().whiteColor(),
                                        16,
                                      ),
                                      onChanged: (value) {
                                        widget.bloc.nameWallet.sink.add(value);
                                        widget.bloc.isNameWallet.sink
                                            .add(value);
                                        widget.bloc.validateNameWallet(value);
                                      },
                                      decoration: InputDecoration(
                                        hintText: S.current.name_wallet,
                                        hintStyle: textNormal(
                                          Colors.white.withOpacity(0.5),
                                          16,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                StreamBuilder(
                                  stream: widget.bloc.isNameWallet,
                                  builder: (
                                    context,
                                    AsyncSnapshot<String> snapshot,
                                  ) {
                                    return snapshot.data?.isNotEmpty ?? false
                                        ? GestureDetector(
                                            onTap: () {
                                              widget.bloc.nameWallet.sink
                                                  .add('');
                                              widget.bloc.isNameWallet.sink
                                                  .add('');
                                              nameWalletController.text = '';
                                              widget.bloc.validateNameWallet(
                                                  nameWalletController.text);
                                            },
                                            child: Image.asset(
                                              ImageAssets.ic_close,
                                              width: 20.w,
                                              height: 20.h,
                                            ),
                                          )
                                        : const SizedBox.shrink();
                                  },
                                )
                              ],
                            ),
                          ),
                          spaceH4,
                          textValidate(),
                          SizedBox(
                            height: 16.h,
                          ),
                          FromText(
                            title: widget.bloc.walletAddress,
                            urlSuffixIcon: ImageAssets.ic_copy,
                            urlPrefixIcon: ImageAssets.ic_address,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          FromText(
                            title: widget.bloc.privateKey,
                            urlSuffixIcon: ImageAssets.ic_copy,
                            urlPrefixIcon: ImageAssets.ic_key24,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Column(
                            children: [
                              BoxListPassWordPhraseCopy(
                                listTitle: widget.bloc.listTitle1,
                                bLocCreateSeedPhrase: widget.bloc,
                              ),
                              SizedBox(
                                height: 17.h,
                              ),
                              CheckBoxCreateSeedPhrase(
                                title: S.current.i_understand,
                                bLocCreateSeedPhrase: widget.bloc,
                              ),
                              SizedBox(
                                height: 18.h,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        if (widget.bloc.isCheckButtonCreate.value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return CreateSeedPhraseConfirm(
                                  typeScreen: widget.typeScreen,
                                  bLocCreateSeedPhrase: widget.bloc,
                                  typeEarseWallet: widget.typeEarseWallet,
                                );
                              },
                            ),
                          ).whenComplete(
                            () => {
                              widget.bloc.resetPassPhrase(),
                              widget.bloc.isSeedPhraseImportFailed.sink
                                  .add(false),
                            },
                          );
                        }
                      },
                      child: StreamBuilder(
                        stream: widget.bloc.isCheckButtonCreate,
                        builder: (context, snapshot) {
                          return ButtonGold(
                            title: S.current.continue_s,
                            isEnable: widget.bloc.isCheckButtonCreate.value,
                          );
                        },
                      ),
                    ),
                  ),
                  spaceH38,
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
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
                child: Text(
                  _mess,
                  style: textNormal(
                    Colors.red,
                    14,
                  ),
                  textAlign: TextAlign.start,
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
