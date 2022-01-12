import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:Dfy/utils/extensions/common_ext.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';

WidgetSpan baseTextBSC(String content) {
  final String address = _funCheckAddress(addressWallet: content);
  return WidgetSpan(
    child: GestureDetector(
      onTap: () {
        launchURL(DetailCollectionBloc.BSC_SCAN + content);
      },
      child: Text(
        address,
        style: textNormalCustom(
          null,
          14,
          FontWeight.w600,
        ).copyWith(
          decoration: TextDecoration.underline,
        ),
      ),
    ),
  );
}

String _funCheckAddress({
  required String addressWallet,
}) {
  String myAddressSend = '';
  if (addressWallet.length < 12) {
    myAddressSend = addressWallet;
  } else {
    myAddressSend = addressWallet.formatAddressActivityFire();
  }
  return myAddressSend;
}
