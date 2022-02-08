
import 'package:Dfy/data/request/bid_nft_request.dart';
import 'package:Dfy/data/request/buy_nft_request.dart';
import 'package:Dfy/data/request/collection/create_hard_collection_request.dart';
import 'package:Dfy/data/request/collection/create_soft_collection_request.dart';
import 'package:Dfy/data/request/nft/create_soft_nft_request.dart';
import 'package:Dfy/data/request/send_offer_request.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/widgets/approve/bloc/approve_cubit.dart';

extension CallApiBE on ApproveCubit {
  Future<String> createCollection({
    required int type,
    required Map<String, dynamic> mapRawData,
    required String txhHash,
  }) async {
    if (type == SOFT_COLLECTION) {
      mapRawData['txn_hash'] = txhHash;
      final CreateSoftCollectionRequest data =
          CreateSoftCollectionRequest.fromJson(mapRawData);
      final result = await confirmRepository.createSoftCollection(data: data);
      result.when(
        success: (suc) {},
        error: (err) {},
      );
    } else {
      mapRawData['bc_txn_hash'] = txhHash;
      mapRawData['collection_address'] = addressWallet;
      final CreateHardCollectionRequest data =
          CreateHardCollectionRequest.fromJson(mapRawData);
      final result = await confirmRepository.createHardCollection(data: data);
      result.when(
        success: (suc) {},
        error: (err) {},
      );
    }
    return '';
  }


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

  Future<void> createSoftNft({
    required Map<String, dynamic> mapRawData,
    required String txhHash,
  }) async {
    mapRawData['txn_hash'] = txhHash;
    final CreateSoftNftRequest data = CreateSoftNftRequest.fromJson(mapRawData);
    final result = await confirmRepository.createSoftNft(data: data);
    result.when(
      success: (suc) {},
      error: (err) {},
    );
  }

}
