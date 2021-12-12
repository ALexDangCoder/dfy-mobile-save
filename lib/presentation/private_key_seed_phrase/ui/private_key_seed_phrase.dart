
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
    widget.bloc.sendPrivateKey(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return StreamBuilder(
    //   stream: widget.bloc.index,
    //   builder: (context, AsyncSnapshot<int> snapshot) {
    //     if (snapshot.hasData) {
    //       final index = snapshot.data ?? 0;
    //       return BaseBottomSheet(
    //         title: S.current.prv_key_ft_seed_phr,
    //         isImage: true,
    //         onRightClick: () {
    //           Navigator.pop(context);
    //           Navigator.pop(context);
    //         },
    //         text: ImageAssets.ic_close,
    //         child: Column(
    //           children: [
    //             spaceH24,
    //             Expanded(
    //               child: SingleChildScrollView(
    //                 child: StreamBuilder<List<PrivateKeyModel>>(
    //                   stream: widget.bloc.listPrivateKey,
    //                   // initialData: const [],
    //                   builder: (context, snapshot) {
    //                     final list = snapshot.data;
    //                     if (snapshot.hasData) {
    //                       return Column(
    //                         children: [
    //                           GestureDetector(
    //                             onTap: () {
    //                               Navigator.of(context).push(
    //                                 HeroDialogRoute(
    //                                   builder: (context) {
    //                                     log('>>>> RETURN LIST WALLET ON PUSH <<<<<<<');
    //                                     return ChooseAcc(
    //                                       listWalletCore:
    //                                           widget.bloc.listWalletCore,
    //                                       bloc: widget.bloc,
    //                                     );
    //                                   },
    //                                   isNonBackground: false,
    //                                 ),
    //                               );
    //                             },
    //                             child: FromTextWalletAddress(
    //                               titleCopy: list?[index].walletAddress ?? '',
    //                               title: widget.bloc.formatText(
    //                                 list?[index].walletAddress ?? '',
    //                               ),
    //                               urlSuffixIcon: ImageAssets.ic_line_down,
    //                               urlPrefixIcon: ImageAssets.ic_address,
    //                             ),
    //                           ),
    //                           SizedBox(
    //                             height: 16.h,
    //                           ),
    //                           FromTextPrivateKey(
    //                             titleCopy: list?[index].privateKey ?? '',
    //                             title: widget.bloc.formatText(
    //                               list?[index].privateKey ?? '',
    //                             ),
    //                             urlSuffixIcon: ImageAssets.ic_copy,
    //                             urlPrefixIcon: ImageAssets.ic_key24,
    //                           ),
    //                           SizedBox(
    //                             height: 20.h,
    //                           ),
    //                           Column(
    //                             children: [
    //                               BoxListPassWordPhraseShow(
    //                                 listTitle: widget.bloc.stringToList(
    //                                   list?[index].seedPhrase ?? '',
    //                                 ),
    //                                 text: list?[index].seedPhrase ?? '',
    //                               ),
    //                             ],
    //                           )
    //                         ],
    //                       );
    //                     } else {
    //                       return const Center(
    //                         child: CircularProgressIndicator(),
    //                       );
    //                     }
    //                   },
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
    //     } else {
    //       return const Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     }
    //   },
    // );
    return StreamBuilder<PrivateKeyModel>(
      stream: widget.bloc.privateKeySubject,
      builder: (context, snapshotModel) {
        if (snapshotModel.hasData) {
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
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              HeroDialogRoute(
                                builder: (context) {
                                  return ChooseAcc(
                                    listWalletCore: widget.bloc.listWalletCore,
                                    bloc: widget.bloc,
                                  );
                                },
                                isNonBackground: false,
                              ),
                            );
                          },
                          child: FromTextWalletAddress(
                            titleCopy: snapshotModel.data?.walletAddress ?? '',
                            title: widget.bloc.formatText(
                              snapshotModel.data?.walletAddress ?? '',
                            ),
                            urlSuffixIcon: ImageAssets.ic_line_down,
                            urlPrefixIcon: ImageAssets.ic_address,
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        FromTextPrivateKey(
                          titleCopy: snapshotModel.data?.privateKey ?? '',
                          title: widget.bloc.formatText(
                            snapshotModel.data?.privateKey ?? '',
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
                                snapshotModel.data?.seedPhrase ?? '',
                              ),
                              text: snapshotModel.data?.seedPhrase ?? '',
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
