import 'package:Dfy/data/request/collection/create_hard_collection_request.dart';
import 'package:Dfy/data/request/collection/create_soft_collection_request.dart';
import 'package:Dfy/domain/repository/market_place/confirm_repository.dart';
import 'package:Dfy/presentation/my_account/create_collection/bloc/create_collection_cubit.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:get/get.dart';

extension CallApiCreateCollection on CreateCollectionCubit{
  Future<String> createCollection({
    required String txhHash,
  }) async {
    final ConfirmRepository confirmRepository = Get.find();
    final mapRawData = getMapCreateCollection();
    if (collectionType == SOFT_COLLECTION) {
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
      mapRawData['collection_address'] = walletAddress;
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
}