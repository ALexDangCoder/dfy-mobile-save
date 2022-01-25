import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';

import 'constants/app_constants.dart';

enum EnumTokenType {
  NFT,
  DFY,
  BTC,
  BNB,
}

extension TokenTypeExtension on EnumTokenType {
  String get imageToken {
    switch (this) {
      case EnumTokenType.DFY:
        return ImageAssets.ic_token_dfy_svg;
      case EnumTokenType.BTC:
        return ImageAssets.ic_token_btc_svg;
      case EnumTokenType.BNB:
        return ImageAssets.ic_token_bnb_svg;
      case EnumTokenType.NFT:
        return ImageAssets.ic_token_dfy_svg;
    }
  }

  String get nameToken {
    switch (this) {
      case EnumTokenType.DFY:
        return 'DFY';
      case EnumTokenType.BTC:
        return 'BTC';
      case EnumTokenType.BNB:
        return 'BNB';
      case EnumTokenType.NFT:
        return 'NFT';
    }
  }
}

extension OfferExtension on StatusOffer {
  String getTxt() {
    switch (this) {
      case StatusOffer.PROCESSING_CREATE:
        return S.current.process_create;
      case StatusOffer.FAILED_CREATE:
        return S.current.failed_create;
      case StatusOffer.OPEN:
        return S.current.open;
      case StatusOffer.PROCESSING_ACCEPT:
        return S.current.processing_accept;
      case StatusOffer.PROCESSING_REJECT:
        return S.current.processing_reject;
      case StatusOffer.PROCESSING_CANCEL:
        return S.current.processing_cancel;
      case StatusOffer.ACCEPTED:
        return S.current.accepted;
      case StatusOffer.REJECTED:
        return S.current.rejected;
      case StatusOffer.CANCELED:
        return S.current.canceled;
    }
  }
}

extension IntFromEnum on num {
  StatusOffer toEnum() {
    switch (this) {
      case PROCESSING_CREATE:
        return StatusOffer.PROCESSING_CREATE;
      case FAILED_CREATE:
        return StatusOffer.FAILED_CREATE;
      case OPEN:
        return StatusOffer.OPEN;
      case PROCESSING_ACCEPT:
        return StatusOffer.PROCESSING_ACCEPT;
      case PROCESSING_REJECT:
        return StatusOffer.PROCESSING_REJECT;
      case PROCESSING_CANCEL:
        return StatusOffer.PROCESSING_CANCEL;
      case ACCEPTED:
        return StatusOffer.ACCEPTED;
      case REJECTED:
        return StatusOffer.REJECTED;
      case CANCELED:
        return StatusOffer.CANCELED;
      default:
        return StatusOffer.PROCESSING_CREATE;
    }
  }
}

extension EnumToColor on StatusOffer {
  Color getColor() {
    switch (this) {
      case StatusOffer.PROCESSING_CREATE:
        return const Color(0xff46BCFF);
      case StatusOffer.FAILED_CREATE:
        return const Color(0xffFF6C6C);
      case StatusOffer.OPEN:
        return const Color(0xff9997FF);
      case StatusOffer.PROCESSING_ACCEPT:
        return const Color(0xff39984E);
      case StatusOffer.PROCESSING_REJECT:
        return const Color(0xffFF6C6C);
      case StatusOffer.PROCESSING_CANCEL:
        return const Color(0xffFF6C6C);
      case StatusOffer.ACCEPTED:
        return const Color(0xff61C777);
      case StatusOffer.REJECTED:
        return const Color(0xffFF6C6C);
      case StatusOffer.CANCELED:
        return const Color(0xffE4AC1A);
    }
  }
}
