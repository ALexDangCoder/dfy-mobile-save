import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/domain/model/pawn/borrow_available_collateral.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({Key? key, required this.commentBorrow}) : super(key: key);

  final CommentBorrow commentBorrow;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.only(
        left: 16.w,
        top: 12.h,
        bottom: 12.h,
        right: 16.w,
      ),
      decoration: BoxDecoration(
        color: borderItemColors,
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
        border: Border.all(color: dialogColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (commentBorrow.userReview?.name != null)
            Row(
              children: [
                Text(
                  commentBorrow.userReview?.name ?? '',
                  style: textNormalCustom(Colors.white, 16, FontWeight.w600),
                ),
                spaceW6,
                if (commentBorrow.userReview?.isKYC == true)
                  sizedSvgImage(
                    w: 14,
                    h: 14,
                    image: ImageAssets.ic_verify_svg,
                  ),
              ],
            )
          else
            Text(
              commentBorrow.userReview?.walletAddress
                      ?.formatAddress(index: 5) ??
                  '',
              style: textNormalCustom(Colors.white, 16, FontWeight.w600)
                  .copyWith(decoration: TextDecoration.underline),
            ),
          spaceH12,
          SizedBox(
            height: 24.h,
            child: Row(
              children: [
                SizedBox(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: commentBorrow.point,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      if (commentBorrow.point != 0) {
                        return Row(
                          children: [
                            Image.asset(
                              ImageAssets.img_rate,
                              height: 24.h,
                              width: 24.w,
                            ),
                            spaceW10,
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
                SizedBox(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5 - (commentBorrow.point ?? 0),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          Image.asset(
                            ImageAssets.img_rate2,
                            height: 24.h,
                            width: 24.w,
                          ),
                          spaceW10,
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          spaceH16,
          Row(
            children: [
              Text(
                commentBorrow.content ?? '',
                style: textNormalCustom(Colors.white, 16, FontWeight.w400),
              ),
            ],
          ),
          spaceH56,
          Text(
            formatDateTime.format(
              DateTime.fromMillisecondsSinceEpoch(
                commentBorrow.createAt ?? 0,
              ),
            ),
            style: textNormalCustom(
              Colors.white.withOpacity(0.5),
              16,
              FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
