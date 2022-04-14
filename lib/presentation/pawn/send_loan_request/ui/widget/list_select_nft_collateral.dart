
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/send_loan_request/bloc/send_loan_request_cubit.dart';
import 'package:Dfy/presentation/pawn/send_loan_request/ui/tab/not_on_market_tab.dart';
import 'package:Dfy/presentation/pawn/send_loan_request/ui/tab/pawn_tab.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListSelectNftCollateral extends StatefulWidget {
  const ListSelectNftCollateral({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final SendLoanRequestCubit cubit;

  @override
  _ListSelectNftCollateralState createState() =>
      _ListSelectNftCollateralState();
}

class _ListSelectNftCollateralState extends State<ListSelectNftCollateral>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int initIndexTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(initialIndex: initIndexTab, length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    widget.cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      ),
                    ),
                    SizedBox(
                      width: 270.w,
                      child: Text(
                        'Select NFT collateral',
                        style: textNormalCustom(
                          null,
                          20.sp,
                          FontWeight.w700,
                        ).copyWith(
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 16.w),
                        width: 24.w,
                        height: 24.h,
                        child: Image.asset(ImageAssets.ic_close),
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
                            Tab(
                              text: S.current.loan_request,
                            ),
                            Tab(
                              text: S.current.not_on_market,
                            ),
                          ],
                        ),
                      ),
                      spaceH6,
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            PawnTab(
                              cubit: widget.cubit,
                            ),
                            NotOnMarketTab(
                              cubit: widget.cubit,
                            ),
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
