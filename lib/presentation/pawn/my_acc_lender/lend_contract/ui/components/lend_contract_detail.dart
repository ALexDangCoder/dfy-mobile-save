import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/lend_contract/ui/components/tab_contract_info.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/lend_contract/ui/components/tab_repayment_history.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LendContractDetail extends StatefulWidget {
  const LendContractDetail({Key? key}) : super(key: key);

  @override
  _LendContractDetailState createState() => _LendContractDetailState();
}

class _LendContractDetailState extends State<LendContractDetail>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
        title: S.current.contract_detail,
        child: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            physics: const NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context, isScolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: AppTheme.getInstance().bgBtsColor(),
                  collapsedHeight: 375.h,
                  flexibleSpace: Column(
                    children: [
                      spaceH24,
                      _lenderFtBorrowerInformation(),
                      spaceH20,
                      _lenderFtBorrowerInformation(isBorrower: true),
                      spaceH20,
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  delegate: MyDelegate(
                    TabBar(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      labelColor: AppTheme.getInstance().whiteColor(),
                      unselectedLabelColor:
                          AppTheme.getInstance().titleTabColor(),
                      indicatorColor: formColor,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelStyle: textNormalCustom(
                        Colors.grey.shade400,
                        14,
                        FontWeight.w600,
                      ),
                      tabs: [
                        Tab(
                          text: S.current.contact_info.capitalize(),
                          height: 50.h,
                        ),
                        Tab(
                          text: S.current.ltv_liquid_thres.capitalize(),
                          height: 50.h,
                        ),
                        Tab(
                          text: S.current.repayment_history.capitalize(),
                          height: 50.h,
                        )
                      ],
                    ),
                  ),
                  floating: true,
                  pinned: true,
                )
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                TabContractInfo(),
                Container(
                  color: Colors.red,
                ),
                TabRepaymentHistory()
              ],
            ),
          ),
        )
        // Column(
        //   children: [
        //
        //     SizedBox(
        //       width: 345.w,
        //       child: TabBar(
        //         physics: const NeverScrollableScrollPhysics(),
        //         controller: _tabController,
        //         labelColor: AppTheme.getInstance().whiteColor(),
        //         unselectedLabelColor: AppTheme.getInstance().titleTabColor(),
        //         indicatorColor: formColor,
        //         indicatorSize: TabBarIndicatorSize.tab,
        //         labelStyle: textNormalCustom(
        //           Colors.grey.shade400,
        //           14,
        //           FontWeight.w600,
        //         ),
        //         tabs: [
        //           Tab(
        //             text: S.current.contact_info.capitalize(),
        //             height: 50.h,
        //           ),
        //           Tab(
        //             text: S.current.ltv_liquid_thres.capitalize(),
        //             height: 50.h,
        //           ),
        //           Tab(
        //             text: S.current.repayment_history.capitalize(),
        //             height: 50.h,
        //           )
        //         ],
        //       ),
        //     ),
        //     Expanded(
        //       child: TabBarView(
        //         controller: _tabController,
        //         children: [
        //           TabContractInfo(),
        //           Container(
        //             color: Colors.red,
        //           ),
        //           TabRepaymentHistory()
        //         ],
        //       ),
        //     )
        //   ],
        // ),
        );
  }

  Container _lenderFtBorrowerInformation({bool? isBorrower = false}) {
    return Container(
      width: 343.w,
      padding: EdgeInsets.only(
        top: 12.h,
        left: 12.w,
        right: 12.w,
        bottom: 20.h,
      ),
      decoration: BoxDecoration(
        color: AppTheme.getInstance().borderItemColor(),
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
        border: Border.all(
          color: AppTheme.getInstance().divideColor(),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (isBorrower ?? false)
                ? S.current.borrower.capitalize()
                : S.current.lender.capitalize(),
            style: textNormalCustom(
              AppTheme.getInstance().whiteColor(),
              20,
              FontWeight.w700,
            ),
          ),
          spaceH8,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  S.current.address.capitalize().withColon(),
                  style: textNormalCustom(
                    AppTheme.getInstance().getGray3(),
                    16,
                    FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'hu',
                      style: textNormalCustom(
                        AppTheme.getInstance().blueColor(),
                        16,
                        FontWeight.w400,
                      ),
                    ),
                    spaceH8,
                    Row(
                      children: [
                        SizedBox(
                          height: 20.h,
                          width: 20.w,
                          child: Image.asset(ImageAssets.ic_star),
                        ),
                        spaceW5,
                        Text(
                          '100',
                          style: textNormalCustom(
                            AppTheme.getInstance().whiteColor(),
                            20,
                            FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          if (isBorrower ?? false)
            Container()
          else
            Column(
              children: [
                spaceH16,
                Padding(
                  padding: EdgeInsets.only(
                    left: 33.w,
                  ),
                  child: Row(
                    children: [
                      Container(
                        // height: 40.h,
                        padding: EdgeInsets.only(
                          left: 16.w,
                          right: 16.w,
                          top: 10.h,
                          bottom: 10.h,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppTheme.getInstance().fillColor(),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.r),
                          ),
                          gradient: RadialGradient(
                            center: const Alignment(0.5, -0.5),
                            radius: 4,
                            colors:
                                AppTheme.getInstance().gradientButtonColor(),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            S.current.view_profile.capitalize(),
                            style: textNormalCustom(
                              AppTheme.getInstance().whiteColor(),
                              16,
                              FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      spaceW30,
                      spaceW6,
                      Container(
                        // height: 40.h,
                        padding: EdgeInsets.only(
                          left: 16.w,
                          right: 16.w,
                          top: 10.h,
                          bottom: 10.h,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppTheme.getInstance().fillColor(),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.r),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            S.current.review,
                            style: textNormalCustom(
                              AppTheme.getInstance().fillColor(),
                              16,
                              FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
        ],
      ),
    );
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate {
  MyDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      width: 345.w,
      color: AppTheme.getInstance().bgBtsColor(),
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
