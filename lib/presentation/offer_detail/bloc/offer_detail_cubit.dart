import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/domain/model/offer_detail.dart';
import 'package:Dfy/domain/repository/nft_repository.dart';
import 'package:Dfy/presentation/offer_detail/bloc/offer_detail_state.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:Dfy/utils/enum_ext.dart';

class OfferDetailCubit extends BaseCubit<SendOfferState> {
  OfferDetailCubit() : super(SendOfferInitial());
  final _offerDetailSubject =
      BehaviorSubject<OfferDetailModel>.seeded(OfferDetailModel());

  Stream<OfferDetailModel> get offerStream => _offerDetailSubject.stream;

  Sink<OfferDetailModel> get offerSink => _offerDetailSubject.sink;

  NFTRepository get _nftRepo => Get.find();
  ColorText colorText = ColorText.empty();
  Future<void> getOfferDetail(int id) async {
    showLoading();
    final result = await _nftRepo.getDetailOffer(id);
    result.when(
      success: (res) {
        showContent();
        colorText = ColorText(
          res.status?.toEnum().getTxt(),
          res.status?.toEnum().getColor(),
        );
        offerSink.add(res);
      },
      error: (error) {
        showError();
      },
    );
  }
}
