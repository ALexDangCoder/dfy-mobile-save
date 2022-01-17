import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/collection_market_model.dart';
import 'package:Dfy/domain/model/market_place/collection_model.dart';
import 'package:Dfy/domain/model/market_place/list_type_nft_collection_explore_model.dart';

mixin MarketPlaceRepository {
  Future<Result<List<ListTypeNftCollectionExploreModel>>>
      getListTypeNftCollectionExplore();

  Future<Result<List<CollectionModel>>> getListCollection({
    String? address,
    String? category,
    String? name,
    int? sort,
    int? page,
    int? size,
  });
  Future<Result<List<CollectionMarketModel>>> getListCollectionMarket({
    String? address,
    String? name,
    int? sort,
    int? page,
    int? size,
  });


}
