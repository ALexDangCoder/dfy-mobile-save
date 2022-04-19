import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/collateral_my_acc/bloc/collateral_my_acc_bloc.dart';
import 'package:Dfy/presentation/pawn/collateral_my_acc/ui/tab/crypto.dart';
import 'package:Dfy/presentation/pawn/collateral_my_acc/ui/tab/nft.dart';
import 'package:Dfy/presentation/pawn/create_new_collateral/ui/create_new_collateral.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'filter_collateral_my_acc.dart';

class CollateralMyAcc extends StatefulWidget {
  const CollateralMyAcc({Key? key}) : super(key: key);

  @override
  _CollateralMyAccState createState() => _CollateralMyAccState();
}

class _CollateralMyAccState extends State<CollateralMyAcc>
    with SingleTickerProviderStateMixin {
  late CollateralMyAccBloc _bloc;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _bloc = CollateralMyAccBloc();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateNewCollateral(),
            ),
          ).whenComplete(
            () => _bloc.refreshPosts(),
          );
        },
        child: Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: AppTheme.getInstance().colorFab(),
            ),
          ),
          child: Icon(
            Icons.add,
            size: 32.sp,
            color: AppTheme.getInstance().whiteColor(),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () {
            final FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Container(
            height: 812.h,
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            decoration: BoxDecoration(
              color: AppTheme.getInstance().bgBtsColor(),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.h),
                topRight: Radius.circular(30.h),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spaceH16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 16.w,
                        ),
                        width: 28.w,
                        height: 28.h,
                        child: Image.asset(
                          ImageAssets.ic_back,
                        ),
                      ),
                    ),
                    Text(
                      S.current.collateral_list,
                      style: textNormalCustom(
                        null,
                        20.sp,
                        FontWeight.w700,
                      ).copyWith(
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) => FilterCollateralMyAcc(
                            bloc: _bloc,
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 16.w),
                        width: 24.w,
                        height: 24.h,
                        child: Image.asset(ImageAssets.ic_filter),
                      ),
                    ),
                  ],
                ),
                spaceH20,
                line,
                spaceH12,
                Flexible(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: TabBar(
                          unselectedLabelColor: const Color(0xFF9997FF),
                          labelColor: Colors.white,
                          indicatorColor: const Color(0xFF6F6FC5),
                          controller: _tabController,
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelStyle: textNormalCustom(
                            Colors.red,
                            14,
                            FontWeight.w600,
                          ),
                          tabs: [
                            const Tab(
                              text: 'Cryptocurrency',
                            ),
                            Tab(
                              text: S.current.nft,
                            ),
                          ],
                        ),
                      ),
                      spaceH12,
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            Crypto(
                              bloc: _bloc,
                            ),
                            NFTCollateral(
                              bloc: _bloc,
                            ), //todo
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
