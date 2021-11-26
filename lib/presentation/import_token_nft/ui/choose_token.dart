import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
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
      color: AppTheme.getInstance().bgBtsColor(),
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
                        height: 73.h,
                        width: 322.w,
                        child: ListTileSwitch(
                          switchScale: 1,
                          value: widget
                                  .bloc.getListTokenModel.value[index].isShow ??
                              false,
                          leading: SizedBox(
                            width: 46.w,
                            height: 46.h,
                            child: Image.asset(
                              widget.bloc.getListTokenModel.value[index]
                                      .iconToken ??
                                  '',
                            ),
                          ),
                          onChanged: (value) {
                            widget.bloc.getListTokenModel.value[index].isShow =
                                value;
                            widget.bloc.setShowedToken(
                              walletAddress: 'walletAddress',
                              tokenID: widget.bloc.getListTokenModel
                                      .value[index].tokenId ??
                                  0,
                              isShow: value,
                            );
                            widget.bloc
                                .sortList(widget.bloc.getListTokenModel.value);
                            setState(() {});
                          },
                          switchActiveColor: AppTheme.getInstance().fillColor(),
                          switchType: SwitchType.cupertino,
                          title: Row(
                            children: [
                              Text(
                                widget.bloc.getListTokenModel.value[index]
                                        .nameToken ??
                                    '',
                                style: textNormalCustom(
                                AppTheme.getInstance().whiteColor(),
                                  16.sp,
                                  FontWeight.w600,
                                ),
                              ),
                              spaceW6,
                              Text(
                                widget.bloc.getListTokenModel.value[index]
                                        .nameTokenSymbol ??
                                    '',
                                style: textNormalCustom(
                                  AppTheme.getInstance().whiteWithOpacity(),
                                  18.sp,
                                  FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            '${widget.bloc.getListTokenModel.value[index].amountToken?.toStringAsFixed(5)}' +
                                ' ${widget.bloc.getListTokenModel.value[index].nameTokenSymbol ?? ''} ',
                            style: textNormalCustom(
                              AppTheme.getInstance().whiteWithOpacityFireZero(),
                              16.sp,
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
