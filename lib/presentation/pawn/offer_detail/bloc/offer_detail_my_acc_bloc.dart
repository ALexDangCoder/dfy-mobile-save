import 'dart:ui';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/model/pawn/offer_detail_my_acc.dart';
import 'package:Dfy/domain/model/pawn/reputation_borrower.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import 'offer_detail_my_acc_state.dart';

class OfferDetailMyAccBloc extends BaseCubit<OfferDetailMyAccState> {
  final String id;

//offer
  static const int ACCEPT_OFFER = 7;
  static const int REJECT_OFFER = 8;
  static const int CANCEL_OFFER = 9;
  static const int OPEN_OFFER = 3;
  BehaviorSubject<String> rate = BehaviorSubject.seeded('0');
  String? hexStringAccept;
  String? hexStringReject;
  OfferDetailMyAcc? obj;
  OfferDetailMyAccBloc(this.id) : super(OfferDetailMyAccInitial()) {
    getOfferDetailMyAcc(id: id);
  }

  BorrowRepository get _pawnService => Get.find();
  final Web3Utils web3Client = Web3Utils();

  Future<void> getCancelCryptoOfferData({
    required String bcCollateralId,
    required String bcOfferId,
  }) async {
    try {
      showLoading();
      hexStringReject = await web3Client.getCancelCryptoOfferData(
        nftCollateralId: bcCollateralId,
        offerId: bcOfferId,
      );
    } catch (e) {
      throw AppException(S.current.error, e.toString());
    }
  }

  Future<void> getOfferDetailMyAcc({
    String? id,
  }) async {
    showLoading();
    final Result<OfferDetailMyAcc> response =
        await _pawnService.getOfferDetailMyAcc(
      id: id,
    );
    response.when(
      success: (response) {
        obj=response;
        emit(
          OfferDetailMyAccSuccess(
            CompleteType.SUCCESS,
            obj: response,
          ),
        );
      },
      error: (error) {
        emit(
          OfferDetailMyAccSuccess(
            CompleteType.ERROR,
            message: error.message,
          ),
        );
      },
    );
  }

  String getStatusOffer(int status) {
    switch (status) {
      case ACCEPT_OFFER:
        return S.current.accepted;
      case REJECT_OFFER:
        return S.current.reject_ed;
      case CANCEL_OFFER:
        return S.current.canceled;
      case OPEN_OFFER:
        return S.current.open;
      default:
        return S.current.pending;
    }
  }

  Color getColorOffer(int status) {
    switch (status) {
      case ACCEPT_OFFER:
        return AppTheme.getInstance().yellowColor();
      case REJECT_OFFER:
        return AppTheme.getInstance().redColor();
      case CANCEL_OFFER:
        return AppTheme.getInstance().redColor();
      case OPEN_OFFER:
        return AppTheme.getInstance().greenMarketColors();
      default:
        return AppTheme.getInstance().orangeMarketColors();
    }
  }

  bool getCheckStatusBtn(int status) {
    switch (status) {
      case ACCEPT_OFFER:
        return false;
      case REJECT_OFFER:
        return false;
      default:
        return true;
    }
  }

  Future<void> getReputation(String addressWallet) async {
    final Result<List<ReputationBorrower>> response =
        await _pawnService.getListReputation(
      addressWallet: addressWallet,
    );
    response.when(
      success: (response) {
        if (response.isNotEmpty) {
          rate.add(response.first.reputationBorrower.toString());
        }
      },
      error: (error) {},
    );
  }
}
