import 'package:Dfy/data/response/market_place/list_type_nft_res.dart';
import 'package:Dfy/data/response/nft/history_response.dart';
import 'package:Dfy/data/response/nft/nft_on_auction_response.dart';
import 'package:Dfy/data/response/nft/nft_on_sale_response.dart';
import 'package:Dfy/data/response/nft/owner_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/nft_service.dart';
import 'package:Dfy/domain/model/market_place/type_nft_model.dart';
import 'package:Dfy/domain/model/history_nft.dart';
import 'package:Dfy/domain/model/market_place/owner_nft.dart';
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

  @override
  Future<Result<List<HistoryNFT>>> getHistory(
      String collectionAddress, String nftTokenId) {
    return runCatchingAsync<HistoryResponse, List<HistoryNFT>>(
      () => _nftClient.getHistory(collectionAddress, nftTokenId),
      (response) => response.toDomain() ?? [],
    );
  }

  @override
  Future<Result<List<TypeNFTModel>>> getListTypeNFT() {
    return runCatchingAsync<ListTypeNFTResponse, List<TypeNFTModel>>(
      () => _nftClient.getListTypeNFT(),
      (response) => response.rows?.map((e) => e.toModel()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<OwnerNft>>> getOwner(
      String collectionAddress, String nftTokenId) {
    return runCatchingAsync<OwnerResponse, List<OwnerNft>>(
          () => _nftClient.getOwner(collectionAddress, nftTokenId),
          (response) => response.toDomain() ?? [],
    );
  }
}
