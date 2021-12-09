import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/form/form_search.dart';
import 'package:flutter/material.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

class ChooseToken extends StatefulWidget {
  final WalletCubit bloc;

  const ChooseToken({Key? key, required this.bloc}) : super(key: key);

  @override
  State<ChooseToken> createState() => _ChooseTokenState();
}

class _ChooseTokenState extends State<ChooseToken> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff3e3d5c),
      child: Column(
        children: [
          spaceH12,
          FormSearch(
            hint: S.current.search_token,
            bloc: widget.bloc,
            urlIcon1: ImageAssets.ic_search,
          ),
          spaceH12,
          line,
          spaceH24,
          StreamBuilder(
            stream: widget.bloc.getListTokenModel,
            builder: (context, snapshot) {
              return Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: widget.bloc.getListTokenModel.value.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        final FocusScopeNode currentFocus =
                            FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                      },
                      child: SizedBox(
                        height: 73,
                        width: 322,
                        child: ListTileSwitch(
                          enabled: false,
                          switchScale: 1,
                          value:
                              widget.bloc.getListTokenModel.value[index].isShow,
                          leading: Image.network(
                            widget
                                .bloc.getListTokenModel.value[index].iconToken,
                          ),
                          onChanged: (value) {
                            widget.bloc.getListTokenModel.value[index].isShow =
                                value;
                            print(value);
                            widget.bloc.setShowedToken(
                              walletAddress: widget.bloc.getListTokenModel
                                  .value[index].walletAddress,
                              isShow: value,
                              tokenAddress: widget.bloc.getListTokenModel
                                  .value[index].tokenAddress,
                            );

                            setState(() {});
                          },
                          switchActiveColor: const Color(0xffE4AC1A),
                          switchType: SwitchType.cupertino,
                          title: Row(
                            children: [
                              Text(
                                widget.bloc.getListTokenModel.value[index]
                                    .nameToken,
                                style: textNormalCustom(
                                  Colors.white,
                                  16,
                                  FontWeight.w600,
                                ),
                              ),
                              spaceW6,
                              Text(
                                widget.bloc.getListTokenModel.value[index]
                                    .nameShortToken,
                                style: textNormalCustom(
                                  const Color.fromRGBO(255, 255, 255, 0.7),
                                  18,
                                  FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            '${widget.bloc.getListTokenModel.value[index].
                            balanceToken.toStringAsFixed(5)} ${widget.bloc.
                            getListTokenModel.value[index].nameShortToken} ',
                            style: textNormalCustom(
                              const Color.fromRGBO(255, 255, 255, 0.5),
                              16,
                              FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
