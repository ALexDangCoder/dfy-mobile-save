import 'package:Dfy/data/response/nft/nft_on_auction_response.dart';
import 'package:Dfy/data/response/nft/nft_on_sale_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/nft_service.dart';
import 'package:Dfy/domain/model/nft_auction.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
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
      (response) => response.item?.toAuction() ?? NFTOnAuction.init(),
    );
  }

  @override
  Future<Result<NftMarket>> getDetailNftOnSale(String marketId) {
    return runCatchingAsync<OnSaleResponse, NftMarket>(
          () => _nftClient.getDetailNftOnSale(marketId),
          (response) => response.item!.toOnSale(),
    );
  }
}
