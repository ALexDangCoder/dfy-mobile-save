import 'dart:ui';
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/bloc_creare_seedphrase.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/ui/show_create_seedphrare_confirm.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/checkbox/checkbox_custom.dart';
import 'package:Dfy/widgets/form/form_text.dart';
import 'package:Dfy/widgets/list_passphrase/box_list_passphrasse_copy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../main.dart';

enum TypeScreen { one, tow }

void showCreateSeedPhrase1(
  BuildContext context,
  bool isCheckApp,
  BLocCreateSeedPhrase blocCreateSeedPhrase,
  TypeScreen type,
) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      if (blocCreateSeedPhrase.passPhrase.isEmpty) {
        blocCreateSeedPhrase.generateWallet(
          password: blocCreateSeedPhrase.passWord,
        );
      }
      trustWalletChannel.setMethodCallHandler(
        blocCreateSeedPhrase.nativeMethodCallBackTrustWallet,
      );

      return Body(
        blocCreateSeedPhrase: blocCreateSeedPhrase,
        typeScreen: type,
        isCheckApp: isCheckApp,
      );
    },
  ).whenComplete(
    () => blocCreateSeedPhrase.isCheckBox1.sink.add(false),
  );
}

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.blocCreateSeedPhrase,
    required this.typeScreen,
    required this.isCheckApp,
  }) : super(key: key);
  final BLocCreateSeedPhrase blocCreateSeedPhrase;
  final TypeScreen typeScreen;
  final bool isCheckApp;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late final TextEditingController nameWallet;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    nameWallet = TextEditingController();
    nameWallet.text = widget.blocCreateSeedPhrase.nameWallet.value;
    nameWallet.addListener(() {
      widget.blocCreateSeedPhrase.nameWallet.sink.add(nameWallet.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.blocCreateSeedPhrase.isCheckData,
      builder: (context, snapshot) {
        if (snapshot.data == true) {
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
                            20.sp,
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
                              Navigator.pop(context);
                              Navigator.pop(context);
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
                                Expanded(// TODO TEXT CHUA CENTER
                                  child: Container(
                                    padding: EdgeInsets.only(right: 5.w),
                                    child: TextFormField(
                                      maxLength: 20,
                                      controller: nameWallet,
                                      cursorColor: Colors.white,
                                      style: textNormal(
                                        AppTheme.getInstance().whiteColor(),
                                        16.sp,
                                      ),
                                      onChanged: (value) {
                                        widget.blocCreateSeedPhrase.isButton();
                                      },
                                      decoration: InputDecoration(
                                        hintText: S.current.name_wallet,
                                        hintStyle: textNormal(
                                          AppTheme.getInstance()
                                              .whiteWithOpacityFireZero(),
                                          16.sp,
                                        ),
                                        counterText: '',
                                        border: InputBorder.none,
                                      ),
                                      // onFieldSubmitted: ,
                                    ),
                                  ),
                                ),
                                Container(
                                  child:
                                      widget.blocCreateSeedPhrase.isWalletName()
                                          ? GestureDetector(
                                              onTap: () {
                                                widget.blocCreateSeedPhrase
                                                    .nameWallet.sink
                                                    .add('');
                                                nameWallet.text = '';
                                                widget.blocCreateSeedPhrase
                                                    .isButton();
                                                setState(() {});
                                              },
                                              child: Image.asset(
                                                ImageAssets.ic_close,
                                                width: 20.w,
                                                height: 20.h,
                                              ),
                                            )
                                          : null,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 343.w,
                            child: widget.blocCreateSeedPhrase.isWalletName()
                                ? null
                                : Text(
                                    S.current.name_not_null,
                                    style: textNormal(
                                      Colors.red,
                                      14.sp,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          FromText(
                            title: widget.blocCreateSeedPhrase.walletAddress,
                            urlSuffixIcon: ImageAssets.ic_copy,
                            urlPrefixIcon: ImageAssets.ic_address,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          FromText(
                            title: widget.blocCreateSeedPhrase.privateKey,
                            urlSuffixIcon: ImageAssets.ic_copy,
                            urlPrefixIcon: ImageAssets.ic_key24,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Column(
                            children: [
                              BoxListPassWordPhraseCopy(
                                listTitle:
                                    widget.blocCreateSeedPhrase.listTitle1,
                                bLocCreateSeedPhrase:
                                    widget.blocCreateSeedPhrase,
                              ),
                              SizedBox(
                                height: 17.h,
                              ),
                              CheckBoxCustom(
                                title: S.current.do_not,
                                bLocCreateSeedPhrase:
                                    widget.blocCreateSeedPhrase,
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
                        if (widget.blocCreateSeedPhrase.isCheckBox1.value &&
                            widget.blocCreateSeedPhrase.isWalletName()) {
                          showCreateSeedPhrase2(
                            widget.isCheckApp,
                            context,
                            widget.blocCreateSeedPhrase,
                            widget.typeScreen,
                          );
                        }
                      },
                      child: StreamBuilder(
                        stream: widget.blocCreateSeedPhrase.isCheckButton1,
                        builder: (context, snapshot) {
                          return ButtonGold(
                            title: S.current.continue_s,
                            isEnable: widget
                                .blocCreateSeedPhrase.isCheckButton1.value,
                          );
                        },
                      ),
                    ),
                  ),
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
}
