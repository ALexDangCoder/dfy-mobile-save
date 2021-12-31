import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/domain/model/model_token.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/form/form_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            hint: S.current.search,
            bloc: widget.bloc,
            urlIcon: ImageAssets.ic_search,
          ),
          spaceH12,
          line,
          StreamBuilder(
            stream: widget.bloc.getListTokenModel,
            builder: (context, AsyncSnapshot<List<ModelToken>> snapshot) {
              if (snapshot.data?.isEmpty ?? false) {
                return Center(
                  child: Column(
                    children: [
                      spaceH40,
                      Image.asset(ImageAssets.img_search_empty),
                      Text(
                        S.current.no_result_found,
                        style: textNormalCustom(
                          Colors.white.withOpacity(0.7),
                          20,
                          FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                      top: 24.h,
                    ),
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
                          child: showItemToken(
                            widget.bloc.getListTokenModel.value[index]
                                .nameShortToken,
                            index,
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget showItemToken(String shortToken, int index) {
    if (shortToken == 'BNB' || shortToken == 'DFY') {
      return ListTileSwitch(
        enabled: false,
        switchScale: 1,
        value: widget.bloc.getListTokenModel.value[index].isShow,
        leading: widget.bloc.getListTokenModel.value[index].iconToken.isEmpty
            ? CircleAvatar(
                backgroundColor: Colors.yellow,
                radius: 14.r,
                child: Center(
                  child: Text(
                    widget.bloc.getListTokenModel.value[index].nameShortToken
                        .substring(0, 1),
                    style: textNormalCustom(
                      Colors.black,
                      20,
                      FontWeight.w600,
                    ),
                  ),
                ),
              )
            : Image.network(
                widget.bloc.getListTokenModel.value[index].iconToken,
              ),
        onChanged: (value) {},
        switchActiveColor: Colors.grey,
        switchType: SwitchType.cupertino,
        title: Row(
          children: [
            Text(
              widget.bloc.getListTokenModel.value[index].nameToken,
              style: textNormalCustom(
                Colors.white,
                16,
                FontWeight.w600,
              ),
            ),
            spaceW6,
          ],
        ),
        subtitle: Text(
          widget.bloc.getListTokenModel.value[index].nameShortToken,
          style: textNormalCustom(
            const Color.fromRGBO(255, 255, 255, 0.5),
            16,
            FontWeight.w400,
          ),
          textAlign: TextAlign.start,
        ),
      );
    } else {
      return ListTileSwitch(
        enabled: false,
        switchScale: 1,
        value: widget.bloc.getListTokenModel.value[index].isShow,
        leading: widget.bloc.getListTokenModel.value[index].iconToken.isEmpty
            ? CircleAvatar(
                backgroundColor: Colors.yellow,
                radius: 14.r,
                child: Center(
                  child: Text(
                    widget.bloc.getListTokenModel.value[index].nameShortToken
                        .substring(0, 1),
                    style: textNormalCustom(
                      Colors.black,
                      20,
                      FontWeight.w600,
                    ),
                  ),
                ),
              )
            : Image.network(
                widget.bloc.getListTokenModel.value[index].iconToken,
              ),
        onChanged: (value) {
          widget.bloc.getListTokenModel.value[index].isShow = value;
          widget.bloc.setShowedToken(
            walletAddress:
                widget.bloc.getListTokenModel.value[index].walletAddress,
            isShow: value,
            tokenAddress:
                widget.bloc.getListTokenModel.value[index].tokenAddress,
            isImport: false,
          );
          setState(() {});
        },
        switchActiveColor: const Color(0xffE4AC1A),
        switchType: SwitchType.cupertino,
        title: Row(
          children: [
            Text(
              widget.bloc.getListTokenModel.value[index].nameToken,
              style: textNormalCustom(
                Colors.white,
                16,
                FontWeight.w600,
              ),
            ),
            spaceW6,
          ],
        ),
        subtitle: Text(
          widget.bloc.getListTokenModel.value[index].nameShortToken,
          style: textNormalCustom(
            const Color.fromRGBO(255, 255, 255, 0.5),
            16,
            FontWeight.w400,
          ),
        ),
      );
    }
  }
}
