import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/image_asset.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseDetailNFT extends StatelessWidget {
  const BaseDetailNFT({
    Key? key,
    this.callback,
    required this.title,
    required this.url,
    required this.children,
  }) : super(key: key);
  final Function()? callback;
  final String title;
  final String url;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 46.h),
      height: 764.h,
      width: 375.w,
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
              Container(
                height: 360.h,
                decoration: BoxDecoration(
                  color: AppTheme.getInstance().bgBtsColor(),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      url,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 16.w,
                left: 16.w,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 32.h,
                    width: 32.w,
                    decoration: BoxDecoration(
                      color:
                          AppTheme.getInstance().bgBtsColor().withOpacity(0.6),
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: AssetImage(ImageAssets.ic_back),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 16.w,
                top: 16.w,
                child: InkWell(
                  onTap: callback,
                  child: Container(
                    height: 32.h,
                    width: 32.w,
                    decoration: BoxDecoration(
                      color:
                          AppTheme.getInstance().bgBtsColor().withOpacity(0.6),
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: AssetImage(ImageAssets.ic_filter),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 8.h,
                  right: 16.w,
                  left: 16.w,
                ),
                child: Column(
                  children: [
                    Container(
                      height: 74.h,
                      width: 433.w,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppTheme.getInstance().divideColor(),
                            width: 1.5,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: textNormalCustom(
                                  AppTheme.getInstance().textThemeColor(),
                                  24,
                                  FontWeight.w600,
                                ),
                              ),
                              Text(
                                '1 of 1',
                                style: textNormalCustom(
                                  AppTheme.getInstance().textThemeColor(),
                                  16,
                                  FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(
                                child: Container(
                                  height: 32.h,
                                  width: 32.w,
                                  decoration: BoxDecoration(
                                    color: AppTheme.getInstance()
                                        .bgBtsColor()
                                        .withOpacity(0.6),
                                    shape: BoxShape.circle,
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        ImageAssets.ic_filter,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  height: 32.h,
                                  width: 32.w,
                                  decoration: BoxDecoration(
                                    color: AppTheme.getInstance()
                                        .bgBtsColor()
                                        .withOpacity(0.6),
                                    shape: BoxShape.circle,
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        ImageAssets.ic_lock,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    ...children
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
