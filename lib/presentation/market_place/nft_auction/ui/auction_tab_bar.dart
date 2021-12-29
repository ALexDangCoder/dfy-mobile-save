import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/nft_auction/ui/bid_tab.dart';
import 'package:Dfy/presentation/market_place/nft_auction/ui/history_tab.dart';
import 'package:Dfy/presentation/market_place/nft_auction/ui/owner_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuctionTabBar extends StatefulWidget {
  const AuctionTabBar({Key? key}) : super(key: key);
  @override
  _AuctionTabBarState createState() => _AuctionTabBarState();
}

class _AuctionTabBarState extends State<AuctionTabBar>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final List<Widget> tabPage = const [
    HistoryTab(listHistory: [],),
    OwnerTab(),
    BidTab(),
  ];
  final List<Tab> titTab = [
    Tab(
      text: S.current.history,
    ),
    Tab(
      text: S.current.owner,
    ),
    Tab(
      text: S.current.bidding,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 16.h),
      height: 393.h,
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            unselectedLabelColor: AppTheme.getInstance().titleTabColor(),
            indicatorColor: AppTheme.getInstance().titleTabColor(),
            labelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            tabs: titTab,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: tabPage,
            ),
          )
        ],
      ),
    );
  }
}
