import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/collection_market_model.dart';
import 'package:Dfy/presentation/my_account/create_nft/bloc/create_nft_cubit.dart';

extension CallApi on CreateNftCubit {
  ///get collection list (my acc)
  Future<void> getListCollection() async {
    final Result<List<CollectionMarketModel>> result =
    await collectionDetailRepository.getListCollection(
      addressWallet: '0x7Cf759534595a8059f25fc319f570A077c41F116',
    );
    result.when(
      success: (res) {
        final listDropDown = res.map((e) => e.toDropDownMap()).toList();
        listCollectionSubject.sink.add(listDropDown);
      },
      error: (_) {},
    );
  }
}