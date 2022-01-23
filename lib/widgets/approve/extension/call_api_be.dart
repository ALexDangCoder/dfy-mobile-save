import 'package:Dfy/data/request/collection/create_hard_collection_request.dart';
import 'package:Dfy/data/request/collection/create_soft_collection_request.dart';
import 'package:Dfy/widgets/approve/bloc/approve_cubit.dart';

extension CallApiBE on ApproveCubit {
  Future<String> createCollection({
    required int type,
    required Map<String, dynamic> mapRawData,
    required String txhHash,
  }) async {
    if (type == 0) {
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
