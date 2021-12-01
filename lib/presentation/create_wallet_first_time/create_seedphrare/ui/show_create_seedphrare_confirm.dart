import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/bloc_creare_seedphrase.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/create_seed_phrase_state.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/ui/show_create_seedphrase.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/ui/show_create_successfully.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/ui/show_create_successfully_have_wallet.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/checkbox/checkbox_custom2.dart';
import 'package:Dfy/widgets/list_passphrase/box_list_passphrase.dart';
import 'package:Dfy/widgets/list_passphrase/list_passphrase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showCreateSeedPhraseConfirm(
  bool isCheckApp,
  BuildContext context,
  BLocCreateSeedPhrase bLocCreateSeedPhrase,
  TypeScreen typeScreen,
) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Body(
        isCheckApp: isCheckApp,
        typeScreen: typeScreen,
        bLocCreateSeedPhrase: bLocCreateSeedPhrase,
      );
    },
  ).whenComplete(
    () => {
      bLocCreateSeedPhrase.resetPassPhrase(),
      bLocCreateSeedPhrase.isSeedPhraseImportFailed.sink.add(false),
    },
  );
}

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.bLocCreateSeedPhrase,
    required this.typeScreen,
    required this.isCheckApp,
  }) : super(key: key);

  final BLocCreateSeedPhrase bLocCreateSeedPhrase;
  final TypeScreen typeScreen;
  final bool isCheckApp;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final bLocCreateSeedPhrase = widget.bLocCreateSeedPhrase;
    return BlocConsumer<BLocCreateSeedPhrase, SeedState>(
      bloc: widget.bLocCreateSeedPhrase,
      listener: (ctx, state) {
        if (state is SeedNavState) {
          if (widget.isCheckApp) {
            showCreateSuccessfullyHaveWallet(
              context: context,
              type: KeyType.CREATE,
              wallet: Wallet(
                name: bLocCreateSeedPhrase.nameWallet.value,
                address: bLocCreateSeedPhrase.walletAddress,
              ),
            );
          } else {
            showCreateSuccessfully(
              type: KeyType.CREATE,
              context: context,
              bLocCreateSeedPhrase: widget.bLocCreateSeedPhrase,
              wallet: Wallet(
                name: bLocCreateSeedPhrase.nameWallet.value,
                address: bLocCreateSeedPhrase.walletAddress,
              ),
            );
          }
        }
      },
      builder: (ctx, _) {
        return Container(
          height: 764.h,
          width: 375.w,
          decoration: BoxDecoration(
            color: AppTheme.getInstance().bgBtsColor(),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
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
                          Navigator.pop(context);
                        } else {
                          Navigator.pop(context);
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
                        margin: EdgeInsets.only(right: 16.w, left: 16.w),
                        child: Text(
                          S.current.tap_the_word,
                          style: textNormal(
                            AppTheme.getInstance().textThemeColor(),
                            16.sp,
                          ),
                        ),
                      ),
                      spaceH20,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StreamBuilder(
                            stream: bLocCreateSeedPhrase.listSeedPhrase,
                            builder: (
                              context,
                              AsyncSnapshot<List<String>> snapshot,
                            ) {
                              final listSeedPhrase = snapshot.data;
                              return Container(
                                margin:
                                    EdgeInsets.only(right: 16.w, left: 16.w),
                                child: BoxListPassWordPhrase(
                                  listTitle: listSeedPhrase ?? [],
                                  bLocCreateSeedPhrase: bLocCreateSeedPhrase,
                                ),
                              );
                            },
                          ),
                          StreamBuilder(
                            stream:
                                bLocCreateSeedPhrase.isSeedPhraseImportFailed,
                            builder: (context, AsyncSnapshot<bool> snapshot) {
                              bLocCreateSeedPhrase.getIsSeedPhraseImport2();
                              return Container(
                                margin:
                                    EdgeInsets.only(right: 16.w, left: 16.w),
                                width: 343.w,
                                child: snapshot.data ?? false
                                    ? Text(
                                        S.current.invalid_order,
                                        style: textNormal(
                                          Colors.red,
                                          14.sp,
                                        ),
                                      )
                                    : null,
                              );
                            },
                          ),
                          spaceH24,
                          StreamBuilder(
                            stream: bLocCreateSeedPhrase.listTitle,
                            builder: (
                              BuildContext context,
                              AsyncSnapshot<List<String>> snapshot,
                            ) {
                              bLocCreateSeedPhrase.getIsSeedPhraseImport2();
                              final listTitle = snapshot.data;
                              return ListPassPhrase(
                                listTitle: listTitle ?? [],
                                bLocCreateSeedPhrase: bLocCreateSeedPhrase,
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 41.h,
                      ),
                      CheckBoxCustom2(
                        title: S.current.do_not,
                        bLocCreateSeedPhrase: bLocCreateSeedPhrase,
                      ),
                      SizedBox(
                        height: 80.h,
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    if (bLocCreateSeedPhrase.isCheckBox2.value &&
                        bLocCreateSeedPhrase.getIsSeedPhraseImport()) {
                      bLocCreateSeedPhrase.getCheck();
                      if (!bLocCreateSeedPhrase
                          .isSeedPhraseImportFailed.value) {
                        bLocCreateSeedPhrase.storeWallet(
                          seedPhrase: bLocCreateSeedPhrase.passPhrase,
                          walletName: bLocCreateSeedPhrase.nameWallet.value,
                          password: bLocCreateSeedPhrase.passWord,
                        );
                      }
                    }
                  },
                  child: StreamBuilder(
                    stream: bLocCreateSeedPhrase.isCheckButton,
                    builder: (context, AsyncSnapshot<bool> snapshot) {
                      return ButtonGold(
                        title: S.current.continue_s,
                        isEnable: bLocCreateSeedPhrase.isCheckButton.value,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
