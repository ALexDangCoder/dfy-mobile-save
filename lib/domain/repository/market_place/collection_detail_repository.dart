import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/activity_collection_model.dart';
import 'package:Dfy/domain/model/market_place/collection_detail.dart';
import 'package:Dfy/domain/model/market_place/collection_detail_filter_model.dart';
import 'package:Dfy/domain/model/market_place/collection_market_model.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';

mixin CollectionDetailRepository {
  Future<Result<CollectionDetailModel>> getCollectionDetail(
    String id,
  );

  Future<Result<List<ActivityCollectionModel>>> getCollectionListActivity(
    String collectionAddress,
    String type,
    int page,
    int size,
  );

  Future<Result<List<CollectionFilterDetailModel>>>
      getListFilterCollectionDetail({
    String? collectionAddress,
  });

  Future<Result<List<NftMarket>>> getListNftCollection({
    String? collectionAddress,
    int? page,
    int? size,
    String? nameNft,
    List<int>? listMarketType,
  });

  Future<Result<List<CollectionMarketModel>>> getListCollection({
    String? addressWallet,
    String? name,
    int? collectionType,
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
