import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/main_screen/bloc/main_cubit.dart';
import 'package:Dfy/presentation/main_screen/ui/main_screen.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@immutable
class CustomBottomHomeAppbar extends StatefulWidget {
  MainCubit mainCubit;

  CustomBottomHomeAppbar({Key? key, required this.mainCubit}) : super(key: key);

  @override
  _CustomBottomHomeAppbarState createState() => _CustomBottomHomeAppbarState();
}

class _CustomBottomHomeAppbarState extends State<CustomBottomHomeAppbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgBottomTab,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0.r),
          topRight: Radius.circular(20.0.r),
        ),
        border: Border.all(
          width: 1.3.w,
          color: const Color.fromRGBO(255, 255, 255, 0.2),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: 96.h,
      child: StreamBuilder(
        stream: widget.mainCubit.indexStream,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          return Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    widget.mainCubit.indexSink.add(tabHomeIndex);
                  },
                  child: snapshot.data == tabHomeIndex
                      ? itemBottomBar(
                          itemSelected(
                            child: ImageAssets.svgAssets(
                              ImageAssets.icTabHomeSelected,
                            ),
                          ),
                          S.current.tab_home,
                          snapshot.data == tabHomeIndex,
                        )
                      : itemBottomBar(
                          ImageAssets.svgAssets(
                            ImageAssets.icTabHomeUnselected,
                          ),
                          S.current.tab_home,
                          snapshot.data == tabHomeIndex,
                        ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    widget.mainCubit.indexSink.add(tabMarketingPlaceIndex);
                  },
                  child: snapshot.data == tabMarketingPlaceIndex
                      ? itemBottomBar(
                          itemSelected(
                            child: ImageAssets.svgAssets(
                              ImageAssets.icTabMarketPlaceSelected,
                            ),
                          ),
                          S.current.tab_market_place,
                          snapshot.data == tabMarketingPlaceIndex,
                        )
                      : itemBottomBar(
                          ImageAssets.svgAssets(
                            ImageAssets.icTabMarketPlaceUnselected,
                          ),
                          S.current.tab_market_place,
                          snapshot.data == tabMarketingPlaceIndex,
                        ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    widget.mainCubit.indexSink.add(tabWalletIndex);
                  },
                  child: snapshot.data == tabWalletIndex
                      ? itemBottomBar(
                          itemSelected(
                            child: ImageAssets.svgAssets(
                              ImageAssets.icTabWalletSelected,
                            ),
                          ),
                          S.current.tab_wallet,
                          snapshot.data == tabWalletIndex,
                        )
                      : itemBottomBar(
                          ImageAssets.svgAssets(
                            ImageAssets.icTabWalletUnSelected,
                          ),
                          S.current.tab_wallet,
                          snapshot.data == tabWalletIndex,
                        ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    widget.mainCubit.indexSink.add(tabPawnIndex);
                  },
                  child: snapshot.data == tabPawnIndex
                      ? itemBottomBar(
                          itemSelected(
                            child: ImageAssets.svgAssets(
                              ImageAssets.icTabPawnSelected,
                            ),
                          ),
                          S.current.tab_pawn,
                          snapshot.data == tabPawnIndex,
                        )
                      : itemBottomBar(
                          ImageAssets.svgAssets(
                            ImageAssets.icTabPawnUnselected,
                          ),
                          S.current.tab_pawn,
                          snapshot.data == tabPawnIndex,
                        ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    widget.mainCubit.indexSink.add(tabStakingIndex);
                  },
                  child: snapshot.data == tabStakingIndex
                      ? itemBottomBar(
                          itemSelected(
                            child: ImageAssets.svgAssets(
                                ImageAssets.icTabStakingSelected),
                          ),
                          S.current.tab_staking,
                          snapshot.data == tabStakingIndex,
                        )
                      : itemBottomBar(
                          ImageAssets.svgAssets(
                            ImageAssets.icTabStakingUnselected,
                          ),
                          S.current.tab_staking,
                          snapshot.data == tabStakingIndex,
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget itemSelected({
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            45,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.getInstance().getShadowBottomBar(),
            spreadRadius: 10,
            blurRadius: 15,
            offset: const Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      child: child,
    );
  }

  Widget itemBottomBar(Widget child, String value, bool isSelect) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        child,
        spaceH4,
        Text(
          value,
          style: textNormalCustom(
            isSelect == true ? Colors.white : Colors.white.withOpacity(0.3),
            12,
            isSelect == true ? FontWeight.w600 : FontWeight.w400,
          ),
        )
      ],
    );
  }
}
