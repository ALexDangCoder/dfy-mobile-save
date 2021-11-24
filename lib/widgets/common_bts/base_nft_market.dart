import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/round_button.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// use for common bottom sheet
/// child is a Column
/// padding bottom is 38, use common for bts have button
/// if has right icon or text, assign value for arg text
/// if this is arg text is image isImage = true, opposite with text
class BaseNFTMarket extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget body;
  final String image;
  final Function() filterFunc;
  final Function() flagFunc;
  final Function() shareFunc;

  const BaseNFTMarket({
    Key? key,
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
      height: 764.h,
      decoration: BoxDecoration(
        color: AppTheme.getInstance().bgBtsColor(),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
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
                  child: roundButton(image: ImageAssets.ic_btn_back_svg),
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
          Expanded(
            child: NestedScrollView(
              physics: const ScrollPhysics(),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
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
                                  weight: FontWeight.w400,
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
                ];
              },
              body: body,
            ),
          )
        ],
      ),
    );
  }
}
