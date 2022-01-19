import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';

mixin NftMarketRepository {
  Future<Result<List<NftMarket>>> getListNft({
    String? name,
    String? status,
    String? nftType,
    String? collectionId,
    String? page,
  });

  Future<Result<List<NftMarket>>> getListNftMyAcc({
    String? name,
    String? status,
    String? nftType,
    String? collectionId,
    String? page,
    String? walletAddress,
  });

}
