import 'package:Dfy/data/response/activity_collection/activity_collection.dart';
import 'package:Dfy/data/response/collection/collection_list_res.dart';
import 'package:Dfy/data/response/collection/collection_res.dart';
import 'package:Dfy/data/response/collection/list_collection_res_market.dart';
import 'package:Dfy/data/response/collection_detail/collection_detail_filter_response.dart';
import 'package:Dfy/data/response/collection_detail/collection_detail_response.dart';
import 'package:Dfy/data/response/nft_market/list_nft_collection_respone.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/market_place/collection_detail_service.dart';
import 'package:Dfy/domain/model/market_place/activity_collection_model.dart';
import 'package:Dfy/domain/model/market_place/collection_detail.dart';
import 'package:Dfy/domain/model/market_place/collection_detail_filter_model.dart';
import 'package:Dfy/domain/model/market_place/collection_market_model.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/domain/repository/market_place/collection_detail_repository.dart';

class CollectionDetailImpl implements CollectionDetailRepository {
  final CollectionDetailService _client;

  CollectionDetailImpl(this._client);

  @override
  Future<Result<CollectionDetailModel>> getCollectionDetail(
    String collectionAddress,
  ) {
    return runCatchingAsync<CollectionDetailResponse, CollectionDetailModel>(
      () => _client.getCollection(collectionAddress),
      (response) => response.item?.toDomain() ?? CollectionDetailModel(),
    );
  }

  @override
  Future<Result<List<ActivityCollectionModel>>> getCollectionListActivity(
    String collectionAddress,
    String type,
    int page,
    int size,
  ) {
    return runCatchingAsync<ActivityCollectionResponse,
        List<ActivityCollectionModel>>(
      () => _client.getListActivityCollection(
        collectionAddress,
        type,
        page,
        size,
      ),
      (response) => response.rows?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<CollectionFilterDetailModel>>>
      getListFilterCollectionDetail({String? collectionAddress}) {
    return runCatchingAsync<CollectionDetailFilterResponse,
        List<CollectionFilterDetailModel>>(
      () => _client.getListFilterCollectionDetail(collectionAddress),
      (response) => response.rows?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<NftMarket>>> getListNftCollection({
    String? collectionAddress,
    int? page,
    int? size,
    String? nameNft,
    List<int>? listMarketType,
    bool? owner,
  }) {
    return runCatchingAsync<ListNftCollectionResponse, List<NftMarket>>(
      () => _client.getListNftCollection(
        collectionAddress,
        page,
        size,
        nameNft,
        listMarketType,
        owner,
      ),
      (response) => response.toDomain() ?? [],
    );
  }

  @override
  Future<Result<List<NftMarket>>> getListNftCollectionMyAcc({
    String? collectionAddress,
    int? page,
    int? size,
    String? nameNft,
    List<int>? listMarketType,
    bool? owner,
  }) {
    return runCatchingAsync<ListNftCollectionResponse, List<NftMarket>>(
          () => _client.getListNftCollectionMyAcc(
        collectionAddress,
        page,
        size,
        nameNft,
        listMarketType,
        owner,
      ),
          (response) => response.toDomain() ?? [],
    );
  }

  @override
  Future<Result<List<CollectionMarketModel>>> getListCollection({
    String? addressWallet,
    String? name,
    int? collectionType,
    int? sort,
    int? page,
    int? size,
  }) {
    return runCatchingAsync<ListCollectionResponse,
        List<CollectionMarketModel>>(
      () => _client.getListCollection(
        addressWallet,
        name,
        collectionType,
        sort,
        page,
        size,
      ),
      (response) => response.rows?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<CollectionMarketModel>>> getListCollectionMarket({
    String? address,
    String? name,
    int? sort,
    int? page,
    int? size,
  }) {
    return runCatchingAsync<ListCollectionResponseMarket,
        List<CollectionMarketModel>>(
      () => _client.getListCollectionMarket(
        address,
        name,
        sort,
        page,
        size,
      ),
      (response) => response.rows?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<CollectionMarketModel>>> getAllCollection({
    int size = 999,
  }) {
    return runCatchingAsync<CollectionListRes, List<CollectionMarketModel>>(
      () => _client.getAllCollection(size),
      (response) => response.rows?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}
