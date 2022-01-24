import 'package:Dfy/data/request/collection/create_hard_collection_request.dart';
import 'package:Dfy/data/request/collection/create_soft_collection_request.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/data/request/put_on_market/put_on_sale_request.dart';
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
        success: (suc) {

        },
        error: (err) {

        },
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

  Future<bool> putOnSale ({ required String txHash})async {
    final Map<String, dynamic> mapRawData = {
      "nft_id" : putOnMarketModel?.nftId ?? '',
      "token" : putOnMarketModel?.tokenAddress ?? '',
      "txn_hash" : txHash,
      "nft_type" : putOnMarketModel?.nftType ?? 0,
      "number_of_copies" : putOnMarketModel?.numberOfCopies ?? 1,
      "price" : int.parse( putOnMarketModel?.price ?? ''),
    };
    final PutOnSaleRequest data =
    PutOnSaleRequest.fromJson(mapRawData);
    final result = await confirmRepository.putOnSale(data: data);
    bool res = false;
    result.when(
      success: (suc) {
        res= true;
      },
      error: (err) {
        res= false;
      },
    );
    return res;
  }

  Future<void> confirmCancelSaleWithBE({
    required String txnHash,
    required String marketId,
  }) async {
    final result = await nftRepo.cancelSale(
      id: marketId,
      txnHash: txnHash,
    );
    result.when(success: (res) {

    }, error: (err) {

    },);
  }

  Future<void> confirmCancelAuctionWithBE({
    required String txnHash,
    required String marketId,
  }) async {
    final result = await nftRepo.cancelAuction(
      id: marketId,
      txnHash: txnHash,
    );
    result.when(success: (res) {

    }, error: (err) {

    },);
  }
}
