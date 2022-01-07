import 'package:Dfy/data/response/market_place/list_type_nft_res.dart';
import 'package:Dfy/data/response/nft/nft_on_auction_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/account_service.dart';
import 'package:Dfy/data/services/nft_service.dart';
import 'package:Dfy/domain/model/market_place/type_nft_model.dart';
import 'package:Dfy/domain/model/nft_auction.dart';
import 'package:Dfy/domain/repository/nft_repository.dart';

class NFTRepositoryImpl implements NFTRepository {
  final NFTClient _nftClient;

  NFTRepositoryImpl(
    this._nftClient,
  );

  @override
  Future<Result<NFTOnAuction>> getDetailNFTAuction(String marketId) {
    return runCatchingAsync<AuctionResponse, NFTOnAuction>(
      () => _nftClient.getDetailNFTAuction(marketId),
      (response) => response.item?.toDomain() ?? NFTOnAuction.init(),
    );
  }

  @override
  Future<Result<List<TypeNFTModel>>> getListTypeNFT() {
    return runCatchingAsync<ListTypeNFTResponse, List<TypeNFTModel>>(
      () => _nftClient.getListTypeNFT(),
      (response) => response.rows?.map((e) => e.toModel()).toList() ?? [],
    );
  }
}
