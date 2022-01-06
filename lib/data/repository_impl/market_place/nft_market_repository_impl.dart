import 'package:Dfy/data/response/nft_market/list_nft_collection_respone.dart';
import 'package:Dfy/data/response/nft_market/list_response_from_api.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/market_place/nft_market_services.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/domain/repository/market_place/nft_market_repo.dart';

class NftMarketRepositoryImpl implements NftMarketRepository {

  final NftMarketClient _client;

  NftMarketRepositoryImpl(this._client);
  @override
  Future<Result<List<NftMarket>>> getListNft({
    String? name,
    String? status,
    String? nftType,
    String? collectionId,
  }) {
    return runCatchingAsync<ListNftResponseFromApi, List<NftMarket>>(
          () => _client.getListNft(status,nftType,name,collectionId),
          (response) => response.toDomain() ?? [],
    );
  }



  @override
  Future<Result<List<NftMarket>>> getListNftCollection({String? collection_id,
     int? page,
    int? size,}) {
      return runCatchingAsync<ListNftCollectionResponse, List<NftMarket>>(
            () => _client.getListNftCollection(collection_id,page,size),
            (response) => response.toDomain() ?? [],);
  }


}
