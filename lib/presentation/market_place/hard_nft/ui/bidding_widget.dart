import 'dart:developer';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/market_place/hard_nft/bloc/hard_nft_bloc.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/button/round_button.dart';
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
    // TODO: implement initState
    final int tabLen = tabList.length;
    _tabController = TabController(length: tabLen, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 800.h,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spaceH24,
                    textRow(
                      name: 'Evaluated by',
                      value: 'The London Evaluation',
                      clickAble: true,
                    ),
                    textRow(
                        name: 'Evaluated time',
                        value: DateTime.now().stringFromDateTime),
                    textRow(
                      name: 'Maximum amount',
                      value: ' ${1200000.stringIntFormat} USDT',
                      token: ImageAssets.ic_token_dfy_svg,
                    ),
                    textRow(name: 'Depreciation (% annually)', value: '20%'),
                    textRow(name: 'Conclusion', value: 'Fast & furious'),
                    Text(
                      'Images and videos',
                      style: tokenDetailAmount(
                        color:
                            AppTheme.getInstance().currencyDetailTokenColor(),
                        weight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    spaceH16,
                    Stack(
                      children: [
                        StreamBuilder<String>(
                          stream: widget.bloc.imageStream,
                          initialData:
                              'https://cdn11.bigcommerce.com/s-yrkef1j7/images/stencil/1280x1280/products/294/37821/QQ20190807220008__01299.1565241023.png?c=2',
                          builder: (context, snapShot) {
                            if (snapShot.hasData) {
                              final String img = snapShot.data ?? '';
                              return SizedBox(
                                width: 350.w,
                                height: 200.h,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.r)),
                                  child: Image.network(
                                    img,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                        Positioned(
                          top: (200.h - 32.h) / 2,
                          left: 16.w,
                          child: InkWell(
                            onTap: () {},
                            child:
                                roundButton(image: ImageAssets.ic_btn_back_svg),
                          ),
                        ),
                        Positioned(
                          top: (200.h - 32.h) / 2,
                          right: 16.w,
                          child: InkWell(
                            onTap: () {},
                            child:
                                roundButton(image: ImageAssets.ic_btn_next_svg),
                          ),
                        ),
                      ],
                    ),
                    spaceH12,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: widget.bloc.listImg
                          .map(
                            (e) => smallImage(e),
                          )
                          .toList(),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget smallImage(String img) {
    return InkWell(
      onTap: (){
        widget.bloc.changeImage(img);
      },
      child: SizedBox(
        width: 79.w,
        height: 64.h,
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
