import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';

import 'base_activity.dart';

class TransferActivity extends StatelessWidget {
  final String urlAvatar;
  final String title;
  final String date;
  final String addressSend;
  final String address;
  final String copy;
  final int index;
  final DetailCollectionBloc bloc;

  const TransferActivity({
    Key? key,
    required this.urlAvatar,
    required this.title,
    required this.date,
    required this.copy,
    required this.addressSend,
    required this.address,
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
          //Transferred %X copy% from %địa chỉ ví gửi% to  %địa chỉ ví nhận%
          //
          // %địa chỉ ví gửi%: Địa chỉ ví gửi. Nếu user đang connect địa chỉ ví trùng với %địa chỉ ví gửi%, hiển thị là YOU.
          // %địa chỉ ví nhận%: Địa chỉ ví nhận.  Nếu user đang connect địa chỉ ví trùng với %địa chỉ nhận%, hiển thị là YOU.
          // %X copies%: Sổ bản transfer. Chỉ hiển thị Đối với NFT 1155
          text: TextSpan(
            text: '${S.current.activity_transferred} ',
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
                text: addressSend == S.current.activity_you
                    ? S.current.activity_you
                    : addressSend,
                style: addressSend == S.current.activity_you
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
                text: ' ${S.current.activity_from_to} ',
              ),
              TextSpan(
                text: address == S.current.activity_you
                    ? S.current.activity_you
                    : address,
                style: address == S.current.activity_you
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
      statusIconActivity: ImageAssets.img_activity_transfer,
      index: index,
      bloc: bloc,
    );
  }
}
