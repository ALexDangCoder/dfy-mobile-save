import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/search_marketplace/list_search_collection_nft_model.dart';

mixin SearchMarketRepository {
  Future<Result<List<ListSearchCollectionFtNftModel>>>
      getCollectionFeatNftSearch({String name});
}
