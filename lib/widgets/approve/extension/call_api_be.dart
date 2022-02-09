import 'package:Dfy/data/request/buy_nft_request.dart';
import 'package:Dfy/data/request/send_offer_request.dart';
import 'package:Dfy/widgets/approve/bloc/approve_cubit.dart';

extension CallApiBE on ApproveCubit {


  Future<void> buyNftRequest(BuyNftRequest buyNftRequest) async {
    showLoading();
    final result = await nftRepo.buyNftRequest(buyNftRequest);
    result.when(
      success: (res) {
        showContent();
      },
      error: (error) {},
    );
  }





  Future<void> sendOffer({
    required SendOfferRequest offerRequest,
  }) async {
    final result = await nftRepo.sendOffer(offerRequest);
    result.when(
      success: (res) {},
      error: (err) {},
    );
  }

}
