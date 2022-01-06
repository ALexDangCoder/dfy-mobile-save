import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Cancel extends StatelessWidget {
  final String urlAvatar;
  final String title;
  final String date;
  final String content;
  final String market;
  final String copy;

  const Cancel({
    Key? key,
    required this.urlAvatar,
    required this.title,
    required this.date,
    required this.content,
    required this.market,
    required this.copy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        spaceW12,
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topLeft,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.r),
                ),
              ),
              clipBehavior: Clip.hardEdge,
              child: CachedNetworkImage(
                width: 66.w,
                height: 66.w,
                fit: BoxFit.fill,
                errorWidget: (context, url, error) => Container(
                  color: Colors.yellow,
                  child: Text(
                    title.substring(0, 1),
                    style: textNormalCustom(
                      Colors.black,
                      60,
                      FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                imageUrl: urlAvatar,
              ),
            ),
            Positioned(
              top: -2,
              left: -4,
              child: Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1.w,
                    color: AppTheme.getInstance().bgBtsColor(),
                  ),
                  image: const DecorationImage(
                    image: AssetImage(
                      ImageAssets.img_activity_cancel,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        spaceW12,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //title
            Text(
              title,
              style: textNormalCustom(
                null,
                14,
                FontWeight.w600,
              ),
            ),
            //content
            SizedBox(
              width: MediaQuery.of(context).size.width - 106,
              child: RichText(
                // Cancelled  %copy% on %market%  by %địa chỉ ví%
                //
                // %copy%:.Số bản cancel. chỉ hiển thị khi là NFT 1155
                // %market%: sàn cancel. Sale/auction/pawn
                // %địa chỉ ví%: Địa chỉ ví đẩy lên cancel. Nếu user đang connect địa chỉ ví trùng với %địa chỉ ví%, hiển thị là YOU.

                text: TextSpan(
                  text: '${S.current.activity_cancelled} ',
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteWithOpacitySevenZero(),
                    14,
                    FontWeight.w400,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: copy.isEmpty
                          ? ''
                          : '${S.current.activity_copied} $copy ${S.current.activity_on} ',
                    ),
                    TextSpan(
                      text: '$market ${S.current.activity_by} ',
                      style: textNormalCustom(
                        AppTheme.getInstance().amountTextColor(),
                        14,
                        FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: content == S.current.activity_you
                          ? S.current.activity_you
                          : content,
                      style: content == S.current.activity_you
                          ? textNormalCustom(
                              null,
                              14,
                              FontWeight.w600,
                            )
                          : textNormalCustom(
                              null,
                              14,
                              FontWeight.w600,
                            ).copyWith(
                              decoration: TextDecoration.underline,
                            ),
                    ),
                  ],
                ),
              ),
            ),
            //date
            spaceH6,
            Text(
              date,
              style: textNormalCustom(
                AppTheme.getInstance().activityDateColor(),
                14,
                null,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
