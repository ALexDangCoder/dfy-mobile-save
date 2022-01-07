import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';

import 'base_activity.dart';

class Like extends StatelessWidget {
  final String urlAvatar;
  final String title;
  final String date;
  final String content;
  final int index;
  final DetailCollectionBloc bloc;

  const Like({
    Key? key,
    required this.urlAvatar,
    required this.title,
    required this.date,
    required this.content,
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
          // %địa chỉ ví%: Nếu user đang connect địa chỉ ví trùng với %địa chỉ ví%, hiển thị là YOU
          text: TextSpan(
            text: '${S.current.activity_liked_by} ',
            style: textNormalCustom(
              AppTheme.getInstance().whiteWithOpacitySevenZero(),
              14,
              FontWeight.w400,
            ),
            children: <TextSpan>[
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
      bloc: bloc,
      statusIconActivity: ImageAssets.img_activity_like,
      index: index,
    );
  }
}
