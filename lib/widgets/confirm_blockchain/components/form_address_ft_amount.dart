import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TypeIsHaveAmount {
  HAVE_AMOUNT,
  HAVE_QUANTITY,
  NO_HAVE_AMOUNT,
}

class FormAddFtAmount extends StatelessWidget {
  FormAddFtAmount({
    this.amount,
    this.quantity,
    required this.typeForm,
    required this.from,
    required this.to,
    this.nameToken,
    Key? key,
  }) : super(key: key);
  final String from;
  final String to;
  final String? amount;
  final int? quantity;
  final TypeIsHaveAmount typeForm;
  String? nameToken;

  @override
  Widget build(BuildContext context) {
    if (typeForm == TypeIsHaveAmount.HAVE_AMOUNT) {
      return Container(
        margin: EdgeInsets.only(
          left: 10.w,
          top: 24.h,
          bottom: 20.h,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 250.w,
            minHeight: 93.h,
          ),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                bothTxtFormAddFtAmount(
                  txtLeft: S.current.from,
                  txtRight: from,
                ),
                spaceH16,
                bothTxtFormAddFtAmount(
                  txtLeft: S.current.to,
                  txtRight: to,
                ),
                spaceH16,
                bothTxtFormAddFtAmount(
                  isYellowText: true,
                  txtLeft: S.current.amount,
                  txtRight: amount.toString() + ' ${nameToken}',
                ),
              ],
            ),
          ),
        ),
      );
    } else if (typeForm == TypeIsHaveAmount.HAVE_QUANTITY) {
      return Container(
        margin: EdgeInsets.only(
          left: 10.w,
          top: 24.h,
          bottom: 20.h,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 250.w,
            minHeight: 93.h,
          ),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                bothTxtFormAddFtAmount(
                  txtLeft: S.current.from,
                  txtRight: from,
                ),
                spaceH16,
                bothTxtFormAddFtAmount(
                  txtLeft: S.current.to,
                  txtRight: to,
                ),
                spaceH16,
                bothTxtFormAddFtAmount(
                  isYellowText: true,
                  txtLeft: S.current.quantity,
                  txtRight: '$quantity ${S.current.of_all} 1',
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 250.w,
          minHeight: 56.h,
        ),
        child: Container(
          margin: EdgeInsets.only(
            left: 10.w,
            top: 24.h,
            bottom: 20.h,
          ),
          child: Column(
            children: [
              bothTxtFormAddFtAmount(
                txtLeft: S.current.from,
                txtRight: from,
              ),
              spaceH16,
              bothTxtFormAddFtAmount(
                txtLeft: S.current.to,
                txtRight: to,
              ),
            ],
          ),
        ),
      );
    }
  }

  Row bothTxtFormAddFtAmount({
    bool isYellowText = false,
    required String txtLeft,
    required String txtRight,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            txtLeft,
            style: textNormalCustom(
              Colors.white.withOpacity(0.7),
              16,
              FontWeight.w400,
            ),
          ),
        ),
        if (isYellowText) Expanded(
                flex: 2,
                child: Text(
                  txtRight,
                  style: textNormalCustom(
                    const Color(0xffE4AC1A),
                    20,
                    FontWeight.w600,
                  ),
                ),
              ) else Expanded(
                flex: 2,
                child: Text(
                  txtRight,
                  style: textNormalCustom(
                    Colors.white,
                    16,
                    FontWeight.w400,
                  ),
                ),
              )
      ],
    );
  }
}
