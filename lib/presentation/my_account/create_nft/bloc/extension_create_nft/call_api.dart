import 'package:Dfy/data/request/nft/create_soft_nft_request.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/market_place/collection_market_model.dart';
import 'package:Dfy/domain/repository/market_place/confirm_repository.dart';
import 'package:Dfy/presentation/my_account/create_nft/bloc/create_nft_cubit.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:get/get.dart';

extension CallApi on CreateNftCubit {
  ///get collection list (my acc)
  Future<void> getListCollection() async {
    walletAddress = PrefsService.getCurrentBEWallet();
    final Result<List<CollectionMarketModel>> result =
        await collectionDetailRepository.getListCollection(
      addressWallet: walletAddress,
    );
    result.when(
      success: (res) {
        softCollectionList = res
            .where(
              (element) =>
                  (element.type == SOFT_COLLECTION) &&
                  ((element.addressCollection ?? '').isNotEmpty),
            )
            .toList();
        final listDropDown =
            softCollectionList.map((e) => e.toDropDownMap()).toList();
        listCollectionSubject.sink.add(listDropDown);
      },
      error: (_) {},
    );
  }

  Future<void> createSoftNft({
    required String txhHash,
  }) async {
    final ConfirmRepository confirmRepository = Get.find();
    final dataMap = getMapCreateSoftNft();
    dataMap['txn_hash'] = txhHash;
    final CreateSoftNftRequest data = CreateSoftNftRequest.fromJson(dataMap);
    final result = await confirmRepository.createSoftNft(data: data);
    result.when(
      success: (suc) {},
      error: (err) {},
    );
  }
}
