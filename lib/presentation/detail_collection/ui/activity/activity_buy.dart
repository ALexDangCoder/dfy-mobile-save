import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'base_activity.dart';

class Buy extends StatelessWidget {
  final String urlAvatar;
  final String title;
  final String date;
  final String content;
  final String amount;
  final String copy;
  final String urlSymbol;
  final String amountSymbol;
  final int index;
  final DetailCollectionBloc bloc;

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
                            amountSymbol.substring(0, 1),
                          ),
                        ),
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
      title: title,
      date: date,
      statusIconActivity: ImageAssets.img_activity_buy,
      index: index,
      bloc: bloc,
    );
  }
}
