import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/list_type_nft_collection_explore_model.dart';

mixin MarketPlaceRepository {
  Future<Result<List<ListTypeNftCollectionExploreModel>>>
      getListTypeNftCollectionExplore();



}
