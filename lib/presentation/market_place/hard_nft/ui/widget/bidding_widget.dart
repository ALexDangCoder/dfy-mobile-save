import 'dart:developer';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/market_place/hard_nft/bloc/hard_nft_bloc.dart';
import 'package:Dfy/presentation/market_place/hard_nft/ui/tab_content/bidding_tab.dart';
import 'package:Dfy/presentation/market_place/hard_nft/ui/tab_content/evaluation_tab.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BiddingWidget extends StatefulWidget {
  final HardNFTBloc bloc;
  final List<Tab> tabList;

  const BiddingWidget({Key? key, required this.bloc, required this.tabList}) : super(key: key);

  @override
  _BiddingWidgetState createState() => _BiddingWidgetState();
}

class _BiddingWidgetState extends State<BiddingWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    final int tabLen = widget.tabList.length;
    _tabController = TabController(length: tabLen, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 55.h,
          child: TabBar(
            onTap: (i) {
              widget.bloc.changeTab(i);
            },
            controller: _tabController,
            tabs: widget.tabList,
            indicatorColor: AppTheme.getInstance().unselectedTabLabelColor(),
            unselectedLabelColor:
                AppTheme.getInstance().unselectedTabLabelColor(),
            labelColor: AppTheme.getInstance().whiteColor(),
            labelStyle: unselectLabel,
            isScrollable: true,
          ),
        ),
        StreamBuilder<int>(
          stream: widget.bloc.changeTabStream,
          initialData: 0,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final _index = snapshot.data ?? 0;
              switch (_index) {
                case 0:
                  return listTab()[0];
                case 1:
                  return listTab()[1];
                case 2:
                  return listTab()[2];
                default:
                  return listTab()[3];
              }
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }

  List<Widget> listTab() {
    return [
      Container(),
      Container(),
      EvaluationTab(bloc: HardNFTBloc()),
      BidingTab(bloc: HardNFTBloc()),
    ];
  }
}
