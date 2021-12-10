import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/domain/model/private_key_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/show_pw_prvkey_seedpharse/bloc/confirm_pw_prvkey_seedpharse_cubit.dart';
import 'package:Dfy/presentation/wallet/ui/hero.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/dialog_remove/choose_acc.dart';
import 'package:Dfy/widgets/form/form%20_text_privatekey.dart';
import 'package:Dfy/widgets/form/form_text_walletaddress.dart';
import 'package:Dfy/widgets/list_passphrase/box_list_passphrase_show.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivateKeySeedPhrase extends StatelessWidget {
  const PrivateKeySeedPhrase({
    Key? key,
    required this.bloc,
  }) : super(key: key);
  final ConfirmPwPrvKeySeedpharseCubit bloc;

  @override
  Widget build(BuildContext context) {
    return _Body(
      bloc: bloc,
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final ConfirmPwPrvKeySeedpharseCubit bloc;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
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
            onRightClick: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            text: ImageAssets.ic_close,
            child: Column(
              children: [
                spaceH24,
                Expanded(
                  child: SingleChildScrollView(
                    child: StreamBuilder<List<PrivateKeyModel>>(
                      stream: widget.bloc.listPrivateKey,
                      initialData: const [],
                      builder: (context, snapshot) {
                        if (snapshot.hasData ) {
                          return Column(
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
                                child: FromTextWalletAddress(
                                  titleCopy: snapshot
                                          .data?[index ?? 0].walletAddress ??
                                      '',
                                  title: widget.bloc.formatText(
                                    snapshot.data?[index ?? 0].walletAddress ??
                                        '',
                                  ),
                                  urlSuffixIcon: ImageAssets.ic_line_down,
                                  urlPrefixIcon: ImageAssets.ic_address,
                                ),
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              FromTextPrivateKey(
                                titleCopy:
                                    snapshot.data?[index ?? 0].privateKey ?? '',
                                title: widget.bloc.formatText(
                                  snapshot.data?[index ?? 0].privateKey ?? '',
                                ),
                                urlSuffixIcon: ImageAssets.ic_copy,
                                urlPrefixIcon: ImageAssets.ic_key24,
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Column(
                                children: [
                                  BoxListPassWordPhraseShow(
                                    listTitle: widget.bloc.stringToList(
                                      snapshot.data?[index ?? 0].seedPhrase ??
                                          '',
                                    ),
                                    text:
                                        snapshot.data?[index ?? 0].seedPhrase ??
                                            '',
                                  ),
                                ],
                              )
                            ],
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
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
