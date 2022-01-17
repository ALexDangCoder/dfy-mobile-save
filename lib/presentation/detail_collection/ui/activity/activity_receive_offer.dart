import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'base_activity.dart';
import 'base_text_bsc.dart';

class ReceiveOffer extends StatelessWidget {
  final String urlAvatar;
  final String urlSymbol;
  final String title;
  final String date;
  final String content;
  final String value;
  final String valueSymbol;
  final int index;
  final DetailCollectionBloc bloc;

  const ReceiveOffer({
    Key? key,
    required this.urlAvatar,
    required this.title,
    required this.date,
    required this.content,
    required this.value,
    required this.valueSymbol,
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
          // Received an offer worth  %r%    from    %địa chỉ ví%
          //
          // %địa chỉ ví%: Địa chỉ ví gửi offer. Nếu user đang connect địa chỉ ví trùng với %địa chỉ ví%, hiển thị là YOU.
          // %value%: giá trị offer

          text: TextSpan(
            text: '${S.current.activity_received_an_offer_worth} ',
            style: textNormalCustom(
              AppTheme.getInstance().whiteWithOpacitySevenZero(),
              14,
              FontWeight.w400,
            ),
            children: [
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
                            valueSymbol.substring(0, 1),
                          ),
                        ),
                      ),
              ),
              TextSpan(
                text: ' $value $valueSymbol',
                style: textNormalCustom(
                  AppTheme.getInstance().amountTextColor(),
                  14,
                  FontWeight.w600,
                ),
              ),
              TextSpan(
                text: ' ${S.current.from} ',
              ),
              baseTextBSC(content),
            ],
          ),
        ),
      ),
      title: title,
      date: date,
      statusIconActivity: ImageAssets.img_activity_receive_offer,
      bloc: bloc,
      index: index,
    );
  }
}
