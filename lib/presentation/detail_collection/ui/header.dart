import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:Dfy/presentation/detail_collection/ui/filter_nft.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderCollection extends StatefulWidget {
  final DetailCollectionBloc collectionBloc;
  final String urlBackground;
  final String urlAvatar;
  final String title;
  final String bodyText;
  final String owner;
  final String contract;
  final String nftStandard;
  final String category;

  const HeaderCollection({
    Key? key,
    required this.urlBackground,
    required this.urlAvatar,
    required this.title,
    required this.bodyText,
    required this.owner,
    required this.contract,
    required this.nftStandard,
    required this.category,
    required this.collectionBloc,
  }) : super(key: key);

  @override
  _HeaderCollectionState createState() => _HeaderCollectionState();
}

class _HeaderCollectionState extends State<HeaderCollection> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            Image.asset(
              widget.urlBackground,
              fit: BoxFit.fill,
              width: 375.w,
              height: 145.h,
            ),
            SizedBox(
              height: 160.h,
              child: SingleChildScrollView(
                // reverse: true,
                primary: false,
                child: Container(
                  margin: EdgeInsets.only(
                    right: 16.w,
                    left: 16.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 46.h,
                      ),
                      Text(
                        widget.title,
                        style: textNormalCustom(
                          null,
                          20.sp,
                          FontWeight.w600,
                        ),
                      ),
                      spaceH6,
                      Text(
                        widget.bodyText,
                        style: textNormalCustom(
                          AppTheme.getInstance().whiteWithOpacity(),
                          14.sp,
                          null,
                        ),
                      ),
                      spaceH15,
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.current.owner,
                                  style: textNormalCustom(
                                    AppTheme.getInstance().whiteWithOpacity(),
                                    14.sp,
                                    FontWeight.w400,
                                  ),
                                ),
                                spaceH15,
                                Text(
                                  S.current.contract,
                                  style: textNormalCustom(
                                    AppTheme.getInstance().whiteWithOpacity(),
                                    14.sp,
                                    FontWeight.w400,
                                  ),
                                ),
                                spaceH15,
                                Text(
                                  S.current.nft_standard,
                                  style: textNormalCustom(
                                    AppTheme.getInstance().whiteWithOpacity(),
                                    14.sp,
                                    FontWeight.w400,
                                  ),
                                ),
                                spaceH15,
                                Text(
                                  S.current.category,
                                  style: textNormalCustom(
                                    AppTheme.getInstance().whiteWithOpacity(),
                                    14.sp,
                                    FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.owner,
                                  style: textNormalCustomUnderline(
                                    null,
                                    14.sp,
                                    null,
                                  ),
                                ),
                                spaceH15,
                                Text(
                                  widget.contract,
                                  style: textNormalCustomUnderline(
                                    const Color(0xff46BCFF),
                                    14.sp,
                                    null,
                                  ),
                                ),
                                spaceH15,
                                Text(
                                  widget.nftStandard,
                                  style: textNormalCustom(
                                    null,
                                    14.sp,
                                    null,
                                  ),
                                ),
                                spaceH15,
                                Text(
                                  widget.category,
                                  style: textNormalCustom(
                                    null,
                                    14.sp,
                                    null,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      spaceH20,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 105.h,
          child: Container(
            height: 80.h,
            width: 80.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppTheme.getInstance().borderItemColor(),
                width: 6.w,
              ),
            ),
            child: Container(
              clipBehavior: Clip.hardEdge,
              width: 74.w,
              height: 74.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage(
                      widget.urlAvatar,
                    ),
                    fit: BoxFit.cover),
              ),
            ),
          ),
        ),
        Positioned(
          top: 16.h,
          left: 16.h,
          child: SizedBox(
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: SizedBox(
                height: 32.h,
                width: 32.w,
                child: Image.asset(ImageAssets.img_back),
              ),
            ),
          ),
        ),
        Positioned(
          top: 16.h,
          right: 16.h,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) => FilterNFT(
                  collectionBloc: widget.collectionBloc,
                ),
              );
            },
            child: SizedBox(
              height: 32.h,
              width: 32.w,
              child: Image.asset(ImageAssets.img_filter),
            ),
          ),
        ),
      ],
    );
  }
}
