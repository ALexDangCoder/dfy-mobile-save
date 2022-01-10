import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';

import 'base_activity.dart';

class Burn extends StatelessWidget {
  final String urlAvatar;
  final String title;
  final String date;
  final String content;
  final String copy;
  final int index;
  final DetailCollectionBloc bloc;

  const Burn({
    Key? key,
    required this.urlAvatar,
    required this.title,
    required this.date,
    required this.content,
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
          // Burned %X copy% by %địa chỉ ví%:
          //
          // Nếu user đang connect địa chỉ ví trùng với %địa chỉ ví%, hiển thị là YOU.
          // %X copy%: Sổ bản burn. Chỉ hiển thị Đối với NFT 1155
          text: TextSpan(
            text: '${S.current.activity_burned} ',
            style: textNormalCustom(
              AppTheme.getInstance().whiteWithOpacitySevenZero(),
              14,
              FontWeight.w400,
            ),
            children: <TextSpan>[
              TextSpan(
                text: copy.isEmpty
                    ? '${S.current.activity_by} '
                    : '${S.current.activity_copied} $copy ${S.current.activity_by} ',
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
      statusIconActivity: ImageAssets.img_activity_burn,
      index: index,
      bloc: bloc,
    );
  }
}
