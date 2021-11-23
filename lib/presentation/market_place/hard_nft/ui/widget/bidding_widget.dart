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

  const BiddingWidget({Key? key, required this.bloc}) : super(key: key);

  @override
  _BiddingWidgetState createState() => _BiddingWidgetState();
}

class _BiddingWidgetState extends State<BiddingWidget>
    with TickerProviderStateMixin {
  List<Tab> tabList = <Tab>[
    const Tab(text: 'History'),
    const Tab(text: 'Owner'),
    const Tab(text: 'Evaluation'),
  ];
  late TabController _tabController;

  @override
  void initState() {
    final int tabLen = tabList.length;
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
            tabs: tabList,
            indicatorColor: AppTheme.getInstance().unselectedTabLabelColor(),
            unselectedLabelColor:
                AppTheme.getInstance().unselectedTabLabelColor(),
            labelColor: AppTheme.getInstance().whiteColor(),
            labelStyle: unselectLabel,
          ),
        ),
        StreamBuilder<int>(
          stream: widget.bloc.changeTabStream,
          initialData: 0,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final _index = snapshot.data ?? 0;
              log('>>>>>>>>>>>>>>>>>>>>>>>>>> $_index');
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
      EvaluationTab(bloc: widget.bloc),
      BidingTab(bloc: widget.bloc),
    ];
  }
}
