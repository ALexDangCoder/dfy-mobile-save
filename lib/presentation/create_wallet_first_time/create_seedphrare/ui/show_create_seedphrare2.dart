import 'dart:ui';
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/images.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';

import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/item.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/bloc_creare_seedphrase.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/create_seed_phrase_state.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/ui/show_create_successfully.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/checkbox/checkbox_custom2.dart';
import 'package:Dfy/widgets/list_passphrase/box_list_passphrase.dart';
import 'package:Dfy/widgets/list_passphrase/list_passphrase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showCreateSeedPhrase2(
  BuildContext context,
  BLocCreateSeedPhrase bLocCreateSeedPhrase,
) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Body(
        bLocCreateSeedPhrase: bLocCreateSeedPhrase,
      );
    },
  ).whenComplete(
    () => {
      bLocCreateSeedPhrase.reloadListSeedPhrase1(),
      bLocCreateSeedPhrase.isSeedPhraseImportFailed.sink.add(false),
    },
  );
}

class Body extends StatefulWidget {
  const Body({Key? key, required this.bLocCreateSeedPhrase}) : super(key: key);

  final BLocCreateSeedPhrase bLocCreateSeedPhrase;

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
            showCreateSuccessfully(
              context,
              widget.bLocCreateSeedPhrase,
            );
          }
        },
        builder: (ctx, _) {
          return Container(
            height: 764.h,
            width: 375.w,
            decoration: BoxDecoration(
              color: AppTheme.getInstance().bgBtsColor(),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.h),
                topRight: Radius.circular(30.h),
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 28.h,
                  width: 323.w,
                  margin: EdgeInsets.only(right: 26.w, left: 26.w, top: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Image.asset(
                          url_ic_out,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(
                        width: 66.w,
                      ),
                      Text(
                        S.current.create_new_wallet,
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 64.w,
                      ),
                      GestureDetector(
                        child: Image.asset(
                          url_ic_close,
                        ),
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRouter.main,
                            (route) => route.isFirst,
                          );
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 26.w, left: 26.w),
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
                          children: [
                            StreamBuilder(
                              stream: bLocCreateSeedPhrase.listSeedPhrase,
                              builder: (context,
                                  AsyncSnapshot<List<Item>> snapshot,) {
                                final listSeedPhrase = snapshot.data;
                                return BoxListPassWordPhrase(
                                  listTitle: listSeedPhrase ?? [],
                                  bLocCreateSeedPhrase: bLocCreateSeedPhrase,
                                );
                              },
                            ),
                            StreamBuilder(
                              stream:
                                  bLocCreateSeedPhrase.isSeedPhraseImportFailed,
                              builder: (context, AsyncSnapshot<bool> snapshot) {
                                bLocCreateSeedPhrase.getIsSeedPhraseImport2();
                                return SizedBox(
                                  width: 323.w,
                                  child: snapshot.data ?? false
                                      ? Text(
                                          'Failed',
                                          style: textNormal(Colors.red, 14),
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
                                AsyncSnapshot<List<Item>> snapshot,
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
                          title: S.current.i_understand,
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
                          title: 'Continue',
                          isEnable: bLocCreateSeedPhrase.isCheckButton.value,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
