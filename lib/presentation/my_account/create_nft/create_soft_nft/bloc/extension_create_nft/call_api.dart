import 'package:Dfy/data/request/nft/create_soft_nft_request.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/collection_market_model.dart';
import 'package:Dfy/domain/repository/market_place/confirm_repository.dart';
import 'package:Dfy/presentation/my_account/create_nft/create_soft_nft/bloc/create_nft_cubit.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:get/get.dart';

extension CallApi on CreateNftCubit {
  ///get collection list (my acc)
  Future<void> getListCollection() async {
    final Result<List<CollectionMarketModel>> result =
        await collectionDetailRepository.getAllCollection();
    result.when(
      success: (res) {
        final tempList = res
            .where(
              (element) =>
                  (element.type == SOFT_COLLECTION) &&
                  ((element.addressCollection ?? '').isNotEmpty),
            )
            .toList();
        softCollectionList = checkDuplicate(tempList);
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

  List<CollectionMarketModel> checkDuplicate(
    List<CollectionMarketModel> list,
  ) {
    final List<String> tempList = [];
    String space = ' ';
    for (final e in list){
      if (tempList.contains(e.name)){
        e.name = (e.name ?? '') + space;
        space = '$space ';
      }
      tempList.add(e.name ?? '');
    }
    return list;
  }
}
