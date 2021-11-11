import 'dart:ui';
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/images.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/private_key_seed_phrase/bloc/private_key_seed_phrase_bloc.dart';
import 'package:Dfy/presentation/wallet/ui/hero.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/dialog_remove/choose_acc.dart';
import 'package:Dfy/widgets/form/form%20_text3.dart';
import 'package:Dfy/widgets/list_passphrase/box_list_passphrase_copy2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showPrivateKeySeedPhrase(
  BuildContext context,
  PrivateKeySeedPhraseBloc bloc,
) {
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
  const Body({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final PrivateKeySeedPhraseBloc bloc;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late final TextEditingController nameWallet;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.bloc.index,
      builder: (context, AsyncSnapshot<int> snapshot) {
        if (snapshot.hasData) {
          final index = snapshot.data;
          return Container(
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
                  width: 323.w,
                  margin: EdgeInsets.only(right: 26.w, left: 26.w, top: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: Image.asset(
                            ImageAssets.ic_out,
                            width: 20.w,
                            height: 20,
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
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: Image.asset(
                            ImageAssets.ic_close,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
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
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              HeroDialogRoute(
                                builder: (context) {
                                  return ChooseAcc(
                                    bloc: widget.bloc,
                                  );
                                },
                                isNonBackground: false,
                              ),
                            );
                          },
                          child: FromText3(
                            titleCopy: widget.bloc.listWallet[index ?? 0]
                                    .walletAddress ??
                                '',
                            title: widget.bloc.formatText(
                              widget.bloc.listWallet[index ?? 0]
                                      .walletAddress ??
                                  '',
                            ),
                            urlSuffixIcon: url_ic_outline,
                            urlPrefixIcon: url_ic_addresss,
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        FromText3(
                          titleCopy:
                              widget.bloc.listWallet[index ?? 0].privateKey ??
                                  '',
                          title: widget.bloc.formatText(
                            widget.bloc.listWallet[index ?? 0].privateKey ?? '',
                          ),
                          urlSuffixIcon: url_ic_copy,
                          urlPrefixIcon: url_ic_key,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Column(
                          children: [
                            BoxListPassWordPhraseCopy2(
                              listTitle: widget.bloc.stringToList(
                                widget.bloc.listWallet[index ?? 0].seedPhrase ??
                                    '',
                              ),
                              text: widget
                                      .bloc.listWallet[index ?? 0].seedPhrase ??
                                  '',
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
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
