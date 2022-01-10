import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';

import 'base_activity.dart';

class Cancel extends StatelessWidget {
  final String urlAvatar;
  final String title;
  final String date;
  final String content;
  final String market;
  final String copy;
  final int index;
  final DetailCollectionBloc bloc;

  const Cancel({
    Key? key,
    required this.urlAvatar,
    required this.title,
    required this.date,
    required this.content,
    required this.market,
    required this.copy,
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
      title: title,
      date: date,
      index: index,
      bloc: bloc,
      statusIconActivity: ImageAssets.img_activity_cancel,
    );
  }
}
