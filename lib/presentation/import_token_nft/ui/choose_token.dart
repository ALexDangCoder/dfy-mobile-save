import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/images.dart';
import 'package:Dfy/config/resources/strings.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/import_token_nft/bloc/import_token_nft_bloc.dart';
import 'package:Dfy/widgets/form/form_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

class ChooseToken extends StatefulWidget {
  final ImportTokenNftBloc bloc;

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
            urlIcon1: url_ic_search,
          ),
          spaceH12,
          line,
          spaceH24,
          StreamBuilder(
            stream: widget.bloc.getList,
            builder: (context, snapshot) {
              return Expanded(
                child: ListView.builder(
                  itemCount: widget.bloc.getList.value.length,
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
                          switchScale: 1,
                          value:
                              widget.bloc.getList.value[index].isShow ?? false,
                          leading: Image.asset(
                              widget.bloc.getList.value[index].iconToken ?? ''),
                          onChanged: (value) {
                            widget.bloc.getList.value[index].isShow = value;
                            widget.bloc.setShowedToken(
                                walletAddress: "walletAddress",
                                tokenID:
                                    widget.bloc.getList.value[index].tokenId ??
                                        0,
                                isShow: value);
                            setState(() {});
                          },
                          switchActiveColor: const Color(0xffE4AC1A),
                          switchType: SwitchType.cupertino,
                          title: Row(
                            children: [
                              Text(
                                widget.bloc.getList.value[index].nameToken ??
                                    '',
                                style: textNormalCustom(
                                  Colors.white,
                                  16,
                                  FontWeight.w600,
                                ),
                              ),
                              spaceW6,
                              Text(
                                widget.bloc.getList.value[index]
                                        .nameTokenSymbol ??
                                    '',
                                style: textNormalCustom(
                                  const Color.fromRGBO(255, 255, 255, 0.7),
                                  18,
                                  FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            '${widget.bloc.getList.value[index].amountToken?.toStringAsFixed(5)}' +
                                ' ${widget.bloc.getList.value[index]
                                    .nameTokenSymbol ?? ''} ',
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
