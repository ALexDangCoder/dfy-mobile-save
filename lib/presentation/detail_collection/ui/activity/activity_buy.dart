import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Buy extends StatelessWidget {
  final String urlAvatar;
  final String title;
  final String date;
  final String content;
  final String amount;
  final String copy;
  final String urlSymbol;
  final String amountSymbol;

  const Buy({
    Key? key,
    required this.urlAvatar,
    required this.title,
    required this.date,
    required this.content,
    required this.amount,
    required this.copy,
    required this.urlSymbol,
    required this.amountSymbol,
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
                      ImageAssets.img_activity_buy,
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
                // Bought %copy% for  %amount% by %địa chỉ ví%
                // %amount%: số tiền mua
                // %copies%: số bản mua. chỉ hiển thị với NFT 1155
                // %địa chỉ ví%: Địa chỉ ví buy.  Nếu user đang connect địa chỉ ví trùng với %địa chỉ ví%, hiển thị là YOU.
                text: TextSpan(
                  text: '${S.current.activity_bought} ',
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteWithOpacitySevenZero(),
                    14,
                    FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      text: copy.isEmpty
                          ? ''
                          : '${S.current.activity_copied} $copy ${S.current.activity_for} ',
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: CachedNetworkImage(
                        width: 14.w,
                        height: 14.w,
                        errorWidget: (context, url, error) => CircleAvatar(
                          backgroundColor: Colors.yellow,
                          radius: 14.r,
                          child: Center(
                            child: Text(
                              amountSymbol.substring(0, 1),
                              style: textNormalCustom(
                                Colors.black,
                                8,
                                FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        imageUrl: urlSymbol,
                      ),
                    ),
                    TextSpan(
                      text: ' $amount $amountSymbol',
                      style: textNormalCustom(
                        AppTheme.getInstance().amountTextColor(),
                        14,
                        FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: ' ${S.current.activity_by} ',
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
