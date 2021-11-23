import 'dart:developer';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/market_place/hard_nft/bloc/hard_nft_bloc.dart';
import 'package:Dfy/presentation/market_place/hard_nft/ui/tab_content/evaluation_widget.dart';
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
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 575.h,
      ),
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: tabList,
            indicatorColor: AppTheme.getInstance().unselectedTabLabelColor(),
            unselectedLabelColor:
                AppTheme.getInstance().unselectedTabLabelColor(),
            labelColor: AppTheme.getInstance().whiteColor(),
            labelStyle: unselectLabel,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Container(),
                Container(),
                EvaluationWidget(bloc: widget.bloc),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget smallImage({required String img, required bool isCurrentImg}) {
    return InkWell(
      onTap: () {
        widget.bloc.changeImage(img);
      },
      child: Container(
        width: 79.w,
        height: 64.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          border: Border.all(
            color: isCurrentImg ? const Color(0xFFE4AC1A) : Colors.transparent,
            width: 2,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          child: Image.network(
            img,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget textRow({
    required String name,
    required String value,
    Color? valueColor,
    bool clickAble = false,
    String? token,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: tokenDetailAmount(
                color: AppTheme.getInstance().currencyDetailTokenColor(),
                weight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            width: 24.w,
          ),
          if (clickAble)
            Expanded(
              flex: 3,
              child: InkWell(
                onTap: () {
                  log('Evaluation');
                },
                child: Text(
                  value,
                  style: tokenDetailAmount(
                    color: AppTheme.getInstance().whiteColor(),
                    fontSize: 14,
                    weight: FontWeight.w400,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            )
          else
            Expanded(
              flex: 3,
              child: token == null
                  ? Text(
                      value,
                      style: tokenDetailAmount(
                        color: AppTheme.getInstance().whiteColor(),
                        fontSize: 14,
                        weight: FontWeight.w400,
                      ),
                    )
                  : Row(
                      children: [
                        sizedSvgImage(w: 20, h: 20, image: token),
                        Text(
                          value,
                          style: tokenDetailAmount(
                            color: AppTheme.getInstance().whiteColor(),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
            ),
        ],
      ),
    );
  }
}
