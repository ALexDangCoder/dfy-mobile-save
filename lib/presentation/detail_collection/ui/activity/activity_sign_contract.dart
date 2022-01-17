import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';

import 'base_activity.dart';
import 'base_text_bsc.dart';

class SignContract extends StatelessWidget {
  final String urlAvatar;
  final String title;
  final String date;
  final String addressSend;
  final String address;
  final int index;
  final DetailCollectionBloc bloc;

  const SignContract({
    Key? key,
    required this.urlAvatar,
    required this.title,
    required this.date,
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
          //Signed a pawn contract  between  %địa chỉ ví vay% and %địa chỉ ví cho vay%
          //
          // %địa chỉ ví vay%: Địa chỉ ví gửi offer. Nếu user đang connect địa chỉ ví trùng với %địa chỉ ví%, hiển thị là YOU.
          // %địa chỉ ví cho vay%: Địa chỉ ví gửi offer. Nếu user đang connect địa chỉ ví trùng với %địa chỉ ví%, hiển thị là YOU.
          text: TextSpan(
            text: '${S.current.activity_signed_a_pawn_contract_between} ',
            style: textNormalCustom(
              AppTheme.getInstance().whiteWithOpacitySevenZero(),
              14,
              FontWeight.w400,
            ),
            children: [
              baseTextBSC(addressSend),
              TextSpan(
                text: ' ${S.current.activity_and} ',
              ),
              baseTextBSC(address),
            ],
          ),
        ),
      ),
      title: title,
      date: date,
      index: index,
      bloc: bloc,
      statusIconActivity: ImageAssets.img_activity_sign_contract,
    );
  }
}
