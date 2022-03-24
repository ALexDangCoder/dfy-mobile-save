import 'dart:ui';

import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/offer_sent_list/bloc/offer_sent_list_cubit.dart';

extension OfferSentCryptoExtension on OfferSentListCubit {
  static const int PROCESSING_CREATE = 1;
  static const int FAILED_CREATE = 2;
  static const int OPEN = 3;
  static const int PROCESSING_ACCEPT = 4;
  static const int PROCESSING_REJECT = 5;
  static const int PROCESSING_CANCEL = 6;
  static const int ACCEPTED = 7;
  static const int REJECTED = 8;
  static const int CANCELED = 9;

  static String categoryStatus(int status) {
    switch (status) {
      case PROCESSING_CREATE:
        return S.current.process_create;
      case PROCESSING_ACCEPT:
        return S.current.processing_accept;
      case PROCESSING_REJECT:
        return S.current.processing_reject;
      case PROCESSING_CANCEL:
        return S.current.processing_cancel;
      case FAILED_CREATE:
        return S.current.failed_create;
      case OPEN:
        return S.current.open;
      case ACCEPTED:
        return S.current.accepted;
      case REJECTED:
        return S.current.rejected;
      case CANCELED:
        return S.current.canceled;
      default:
        return S.current.processing;
    }
  }

  static Color getStatusColor(int status) {
    switch (status) {
      case OfferSentCryptoExtension.OPEN:
        return AppTheme.getInstance().blueColor();
      case OfferSentCryptoExtension.ACCEPTED:
        return AppTheme.getInstance().successTransactionColors();
      case OfferSentCryptoExtension.REJECTED:
      case OfferSentCryptoExtension.FAILED_CREATE:
        return AppTheme.getInstance().failTransactionColors();
      case OfferSentCryptoExtension.CANCELED:
        return AppTheme.getInstance().titleTabColor();
      case OfferSentCryptoExtension.PROCESSING_CREATE:
      case OfferSentCryptoExtension.PROCESSING_ACCEPT:
      case OfferSentCryptoExtension.PROCESSING_REJECT:
      case OfferSentCryptoExtension.PROCESSING_CANCEL:
        return orangeColor;
      default:
        return orangeColor;
    }
  }
}
