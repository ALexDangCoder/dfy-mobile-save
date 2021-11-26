import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseNFTMarket extends StatelessWidget {
  final String title;
  final Widget child;
  final TabBar tabBar;
  final Widget body;
  final String image;
  final Function() filterFunc;
  final Function() flagFunc;
  final Function() shareFunc;

  const BaseNFTMarket({
    Key? key,
    required this.tabBar,
    required this.title,
    required this.child,
    required this.image,
    required this.filterFunc,
    required this.flagFunc,
    required this.shareFunc,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 764.h,
      decoration: BoxDecoration(
        color: AppTheme.getInstance().bgBtsColor(),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: NestedScrollView(
        physics: const ScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 360.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.r),
                            topRight: Radius.circular(30.r),
                          ),
                          child: Image.network(
                            image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16.w,
                        top: 16.h,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child:
                              roundButton(image: ImageAssets.ic_btn_back_svg),
                        ),
                      ),
                      Positioned(
                        right: 16.w,
                        top: 16.h,
                        child: InkWell(
                          onTap: filterFunc,
                          child: roundButton(image: ImageAssets.ic_filter_svg),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 8.h,
                      left: 16.w,
                      right: 16.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: tokenDetailAmount(),
                              ),
                            ),
                            SizedBox(
                              width: 25.h,
                            ),
                            InkWell(
                              onTap: () {
                                flagFunc();
                              },
                              child: roundButton(
                                image: ImageAssets.ic_flag_svg,
                                whiteBackground: true,
                              ),
                            ),
                            SizedBox(
                              width: 20.h,
                            ),
                            InkWell(
                              onTap: () {
                                shareFunc();
                              },
                              child: roundButton(
                                image: ImageAssets.ic_share_svg,
                                whiteBackground: true,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '1 of 1 available',
                          textAlign: TextAlign.left,
                          style: tokenDetailAmount(
                            fontSize: 16,
                          ),
                        ),
                        spaceH12,
                        line,
                      ],
                    ),
                  ),
                  child,
                ],
              ),
            ),
            SliverPersistentHeader(
              delegate: BaseSliverHeader(tabBar),
              pinned: true,
            ),
          ];
        },
        body: body,
      ),
    );
  }
}

class BaseSliverHeader extends SliverPersistentHeaderDelegate {
  BaseSliverHeader(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w,),
      color: AppTheme.getInstance().bgBtsColor(),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(BaseSliverHeader oldDelegate) {
    return false;
  }
}
