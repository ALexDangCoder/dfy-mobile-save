import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PutOnMarket extends StatelessWidget {
  final String urlAvatar;
  final String title;
  final String date;
  final String content;
  final String money;
  final String copy;
  final String each;
  final String market;
  final String moneySymbol;

  const PutOnMarket({
    Key? key,
    required this.urlAvatar,
    required this.title,
    required this.date,
    required this.content,
    required this.money,
    required this.copy,
    required this.each,
    required this.market,
    required this.moneySymbol,
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
                      ImageAssets.img_activity_put_on_market,
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
                //Put  %copy% on %market%   by  %địa chỉ ví%    for     %money%       each
                //
                // %copy%:.Số bản list sàn, chỉ hiển thị khi là NFT 1155
                // %market%: sàn list lên. Sale/auction/pawn
                // %địa chỉ ví%: Địa chỉ ví đẩy lên sàn. Nếu user đang connect địa chỉ ví trùng với %địa chỉ ví%, hiển thị là YOU.
                // %money%: Giá reserve price/sale/pawn
                // Each: chỉ hiển thị chữ này khi là NFT 1155

                text: TextSpan(
                  text: '${S.current.activity_put} ',
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
                    TextSpan(
                      text: ' ${S.current.activity_for} ',
                    ),
                    TextSpan(
                      text: '$money $moneySymbol',
                      style: textNormalCustom(
                        AppTheme.getInstance().amountTextColor(),
                        14,
                        FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: each == '' ? '' : ' ${S.current.activity_each}',
                      style: textNormalCustom(
                        null,
                        14,
                        null,
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
