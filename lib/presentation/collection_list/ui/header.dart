import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/collection_list/ui/filter_nft.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderCollection extends StatefulWidget {
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
                          20,
                          FontWeight.w600,
                        ),
                      ),
                      spaceH6,
                      Text(
                        widget.bodyText,
                        style: textNormalCustom(
                          Colors.white.withOpacity(0.7),
                          14,
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
                                    Colors.white.withOpacity(0.7),
                                    14,
                                    FontWeight.w400,
                                  ),
                                ),
                                spaceH15,
                                Text(
                                  S.current.contract,
                                  style: textNormalCustom(
                                    Colors.white.withOpacity(0.7),
                                    14,
                                    FontWeight.w400,
                                  ),
                                ),
                                spaceH15,
                                Text(
                                  S.current.nft_standard,
                                  style: textNormalCustom(
                                    Colors.white.withOpacity(0.7),
                                    14,
                                    FontWeight.w400,
                                  ),
                                ),
                                spaceH15,
                                Text(
                                  S.current.category,
                                  style: textNormalCustom(
                                    Colors.white.withOpacity(0.7),
                                    14,
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
                                  style: textNormalCustom(
                                    null,
                                    14,
                                    null,
                                  ),
                                ),
                                spaceH15,
                                Text(
                                  widget.contract,
                                  style: textNormalCustom(
                                    const Color(0xff46BCFF),
                                    14,
                                    null,
                                  ),
                                ),
                                spaceH15,
                                Text(
                                  widget.nftStandard,
                                  style: textNormalCustom(
                                    null,
                                    14,
                                    null,
                                  ),
                                ),
                                spaceH15,
                                Text(
                                  widget.category,
                                  style: textNormalCustom(
                                    null,
                                    14,
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
          child: SizedBox(
            height: 80.h,
            width: 80.w,
            child: AvatarView(
              borderWidth: 6,
              borderColor: AppTheme.getInstance().borderItemColor(),
              imagePath: widget.urlAvatar,
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
                builder: (context) => FilterNFT(),
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
