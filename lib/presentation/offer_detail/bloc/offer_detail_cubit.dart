import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/offer_detail.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/repository/nft_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/offer_detail/bloc/offer_detail_state.dart';
import 'package:Dfy/utils/enum_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class OfferDetailCubit extends BaseCubit<SendOfferState> {
  OfferDetailCubit() : super(SendOfferInitial());
  final _offerDetailSubject =
      BehaviorSubject<OfferDetailModel>.seeded(OfferDetailModel());

  Stream<OfferDetailModel> get offerStream => _offerDetailSubject.stream;

  Sink<OfferDetailModel> get offerSink => _offerDetailSubject.sink;

  NFTRepository get _nftRepo => Get.find();
  ColorText colorText = ColorText.empty();
  List<TokenInf> listTokenSupport = [];

  void getTokenInf() {
    final String listToken = PrefsService.getListTokenSupport();
    listTokenSupport = TokenInf.decode(listToken);
  }

  Future<void> getOfferDetail(int id) async {
    showLoading();
    final result = await _nftRepo.getDetailOffer(id);
    result.when(
      success: (res) {
        showContent();
        getTokenInf();
        for (final value in listTokenSupport) {
          final symbolToken = res.repaymentToken ?? '';
          final symbol = value.symbol ?? '';
          if (symbolToken.toLowerCase() == symbol.toLowerCase()) {
            res.repaymentAsset = value.address;
          }
        }
        colorText = ColorText(
          res.status?.toEnum().getTxt(),
          res.status?.toEnum().getColor(),
        );
        offerSink.add(res);
      },
      error: (error) {},
    );
  }

  Future<String> getAcceptOfferData(
    String idCollateral,
    String idOffer,
    BuildContext context,
  ) async {
    String hexString = '';
    try {
      hexString = await Web3Utils().getAcceptOfferData(
        nftCollateralId: idCollateral,
        offerId: idOffer,
        context: context,
      );
    } catch (e) {
      throw AppException(S.current.error, e.toString());
    }

    return hexString;
  }

  Future<String> getCancelOfferData(
    String idCollateral,
    String idOffer,
    BuildContext context,
  ) async {
    String hexString = '';
    try {
      hexString = await Web3Utils().getCancelOfferData(
        nftCollateralId: idCollateral,
        offerId: idOffer,
        context: context,
      );
    } catch (e) {
      throw AppException(S.current.error, e.toString());
    }

    return hexString;
  }

  Future<void> acceptOffer(int idOffer) async {
    await _nftRepo.acceptOffer(idOffer);
  }

  Future<void> rejectOffer(int idOffer) async {
    await _nftRepo.rejectOffer(idOffer);
  }
}
