import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/nft_collection_explore_model.dart';

mixin NftCollectionExploreRepository {
  Future<Result<List<NftCollectionExploreModel>>> getNftCollectionExplore();
}
