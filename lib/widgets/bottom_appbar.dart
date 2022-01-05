import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/images.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/main_screen/bloc/main_cubit.dart';
import 'package:Dfy/presentation/main_screen/ui/main_screen.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        borderRadius:  BorderRadius.only(
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
                  child: itemBottomBar(
                    ImageAssets.svgAssets(
                      snapshot.data == tabHomeIndex
                          ? ImageAssets.icTabHomeSelected
                          : ImageAssets.icTabHomeUnselected,
                    ),
                    S.current.tab_home,
                    snapshot.data == tabHomeIndex,
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    widget.mainCubit.indexSink.add(tabPawnIndex);
                  },
                  child: itemBottomBar(
                    ImageAssets.svgAssets(
                      snapshot.data == tabPawnIndex
                          ? ImageAssets.icTabPawnSelected
                          : ImageAssets.icTabPawnUnselected,
                    ),
                    S.current.tab_pawn,
                    snapshot.data == tabPawnIndex,
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    widget.mainCubit.indexSink.add(tabWalletIndex);
                  },
                  child: itemBottomBar(
                    ImageAssets.svgAssets(
                      snapshot.data == tabWalletIndex
                          ? ImageAssets.icTabWalletSelected
                          : ImageAssets.icTabWalletUnSelected,
                    ),
                    S.current.tab_wallet,
                    snapshot.data == tabWalletIndex,
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    widget.mainCubit.indexSink.add(tabMarketingPlaceIndex);
                  },
                  child: itemBottomBar(
                    ImageAssets.svgAssets(
                      snapshot.data == tabMarketingPlaceIndex
                          ? ImageAssets.icTabMarketPlaceSelected
                          : ImageAssets.icTabMarketPlaceUnselected,
                    ),
                    S.current.tab_market_place,
                    snapshot.data == tabMarketingPlaceIndex,
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    widget.mainCubit.indexSink.add(tabStakingIndex);
                  },
                  child: itemBottomBar(
                    ImageAssets.svgAssets(
                      snapshot.data == tabStakingIndex
                          ? ImageAssets.icTabStakingSelected
                          : ImageAssets.icTabStakingUnselected,
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
            12.sp,
            isSelect == true ? FontWeight.w600 : FontWeight.w400,
          ),
        )
      ],
    );
  }
}
