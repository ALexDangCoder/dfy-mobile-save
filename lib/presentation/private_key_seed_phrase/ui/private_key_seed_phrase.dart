import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/private_key_seed_phrase/bloc/private_key_seed_phrase_bloc.dart';
import 'package:Dfy/presentation/wallet/ui/hero.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/dialog_remove/choose_acc.dart';
import 'package:Dfy/widgets/form/form%20_text3.dart';
import 'package:Dfy/widgets/form/form_text4.dart';
import 'package:Dfy/widgets/list_passphrase/box_list_passphrase_copy2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivateKeySeedPhrase extends StatelessWidget {
  const PrivateKeySeedPhrase({
    Key? key,
    required this.bloc,
  }) : super(key: key);
  final PrivateKeySeedPhraseBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          SizedBox(
            height: 48.h,
          ),
          Body(
            bloc: bloc,
          ),
        ],
      ),
    );
  }
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
          return BaseBottomSheet(
            title: S.current.prv_key_ft_seed_phr,
            isImage: true,
            callback: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            text: ImageAssets.ic_close,
            child: Column(
              children: [
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
                          child: FromText4(
                            titleCopy: widget.bloc.listWallet[index ?? 0]
                                    .walletAddress ??
                                '',
                            title: widget.bloc.formatText(
                              widget.bloc.listWallet[index ?? 0]
                                      .walletAddress ??
                                  '',
                            ),
                            urlSuffixIcon: ImageAssets.ic_line_down,
                            urlPrefixIcon: ImageAssets.ic_address,
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
                          urlSuffixIcon: ImageAssets.ic_copy,
                          urlPrefixIcon: ImageAssets.ic_key24,
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
