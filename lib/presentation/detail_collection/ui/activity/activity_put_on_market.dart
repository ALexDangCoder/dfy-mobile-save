import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'base_activity.dart';

class PutOnMarket extends StatelessWidget {
  final String urlAvatar;
  final String urlSymbol;
  final String title;
  final String date;
  final String content;
  final String money;
  final String copy;
  final String each;
  final String market;
  final String moneySymbol;
  final int index;
  final DetailCollectionBloc bloc;

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
    required this.urlSymbol,
    required this.index,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseActivity(
      urlAvatar: urlAvatar,
      childText: SizedBox(
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
            children: [
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
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: urlSymbol.isNotEmpty
                    ? Image.asset(
                        urlSymbol,
                        width: 14.w,
                        height: 14.w,
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.all(
                            Radius.circular(45.r),
                          ),
                        ),
                        width: 14.w,
                        height: 14.w,
                        child: FittedBox(
                          child: Text(
                            moneySymbol.substring(0, 1),
                          ),
                        ),
                      ),
              ),
              TextSpan(
                text: ' $money $moneySymbol',
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
      title: title,
      date: date,
      index: index,
      statusIconActivity: ImageAssets.img_activity_put_on_market,
      bloc: bloc,
    );
  }
}
