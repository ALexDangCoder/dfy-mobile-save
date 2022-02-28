import 'package:Dfy/data/request/bid_nft_request.dart';
import 'package:Dfy/data/request/buy_nft_request.dart';
import 'package:Dfy/data/request/buy_out_request.dart';
import 'package:Dfy/data/request/send_offer_request.dart';
import 'package:Dfy/data/response/market_place/confirm_res.dart';
import 'package:Dfy/data/response/market_place/list_type_nft_res.dart';
import 'package:Dfy/data/response/nft/bidding_response.dart';
import 'package:Dfy/data/response/nft/data_detail_offer_response.dart';
import 'package:Dfy/data/response/nft/evaluation_response.dart';
import 'package:Dfy/data/response/nft/hard_nft_respone.dart';
import 'package:Dfy/data/response/nft/history_response.dart';
import 'package:Dfy/data/response/nft/nft_my_acc_detail_response.dart';
import 'package:Dfy/data/response/nft/nft_on_auction_response.dart';
import 'package:Dfy/data/response/nft/nft_on_pawn_response.dart';
import 'package:Dfy/data/response/nft/nft_on_sale_response.dart';
import 'package:Dfy/data/response/nft/offer_nft_response.dart';
import 'package:Dfy/data/response/nft/owner_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/nft_service.dart';
import 'package:Dfy/domain/model/bidding_nft.dart';
import 'package:Dfy/domain/model/evaluation_hard_nft.dart';
import 'package:Dfy/domain/model/history_nft.dart';
import 'package:Dfy/domain/model/market_place/confirm_model.dart';
import 'package:Dfy/domain/model/market_place/owner_nft.dart';
import 'package:Dfy/domain/model/market_place/type_nft_model.dart';
import 'package:Dfy/domain/model/nft_auction.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/domain/model/nft_on_pawn.dart';
import 'package:Dfy/domain/model/offer_detail.dart';
import 'package:Dfy/domain/model/offer_nft.dart';
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
      (response) => response.item!.toAuction(),
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
    String collectionAddress,
    String nftTokenId,
  ) {
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
    String collectionAddress,
    String nftTokenId,
  ) {
    return runCatchingAsync<OwnerResponse, List<OwnerNft>>(
      () => _nftClient.getOwner(collectionAddress, nftTokenId),
      (response) => response.toDomain() ?? [],
    );
  }

  @override
  Future<Result<List<BiddingNft>>> getBidding(String auctionId) {
    return runCatchingAsync<BiddingResponse, List<BiddingNft>>(
      () => _nftClient.getBidding(auctionId),
      (response) => response.toDomain() ?? [],
    );
  }

  @override
  Future<Result<String>> buyNftRequest(BuyNftRequest nftRequest) {
    return runCatchingAsync<String, String>(
      () => _nftClient.buyNftRequest(nftRequest),
      (response) => response.toString(),
    );
  }

  @override
  Future<Result<NftMarket>> getDetailHardNftOnSale(String nftId) {
    return runCatchingAsync<HardNftResponse, NftMarket>(
      () => _nftClient.getDetailHardNft(nftId),
      (response) => response.item?.toOnSale() ?? NftMarket.init(),
    );
  }

  @override
  Future<Result<NFTOnAuction>> getDetailHardNftOnAuction(String nftId) {
    return runCatchingAsync<HardNftResponse, NFTOnAuction>(
      () => _nftClient.getDetailHardNft(nftId),
      (response) => response.item?.toAuction() ?? NFTOnAuction.init(),
    );
  }

  @override
  Future<Result<NftOnPawn>> getDetailNftOnPawn(String pawnId) {
    return runCatchingAsync<OnPawnResponse, NftOnPawn>(
      () => _nftClient.getDetailNftOnPawn(pawnId),
      (response) => response.data!.toOnPawn(),
    );
  }

  @override
  Future<Result<List<OfferDetail>>> getOffer(String collateralId) {
    return runCatchingAsync<OfferResponse, List<OfferDetail>>(
      () => _nftClient.getOffer(collateralId),
      (response) => response.item?.toDomain() ?? [],
    );
  }

  @override
  Future<Result<String>> bidNftRequest(BidNftRequest bidNftRequest) {
    return runCatchingAsync<String, String>(
      () => _nftClient.bidNftRequest(bidNftRequest),
      (response) => response.toString(),
    );
  }

  @override
  Future<Result<Evaluation>> getEvaluation(String evaluationId) {
    return runCatchingAsync<EvaluationResponse, Evaluation>(
      () => _nftClient.getEvaluation(evaluationId),
      (response) => response.item!.toDomain(),
    );
  }

  @override
  Future<Result<NftMarket>> getDetailNftMyAccNotOnMarket(
      String nftId, String type) {
    return runCatchingAsync<NftMyAccResponse, NftMarket>(
      () => _nftClient.getDetailNftNotOnMarket(nftId, type),
      (response) => response.item!.toNotOnMarket(),
    );
  }

  @override
  Future<Result<ConfirmModel>> cancelSale({
    required String id,
    required String txnHash,
  }) {
    return runCatchingAsync<ConfirmResponse, ConfirmModel>(
      () => _nftClient.cancelSale(id, txnHash),
      (response) => response.toDomain(),
    );
  }

  @override
  Future<Result<ConfirmModel>> cancelAuction(
      {required String id, required String txnHash}) {
    return runCatchingAsync<ConfirmResponse, ConfirmModel>(
      () => _nftClient.cancelAuction(id, txnHash),
      (response) => response.toDomain(),
    );
  }

  @override
  Future<Result<OfferDetailModel>> getDetailOffer(int id) {
    return runCatchingAsync<DataOfferDetailResponse, OfferDetailModel>(
      () => _nftClient.getOfferDetail(id),
      (response) => response.data?.toModel() ?? OfferDetailModel(),
    );
  }

  @override
  Future<Result<String>> acceptOffer(
    int idOffer,
  ) {
    return runCatchingAsync<String, String>(
      () => _nftClient.acceptOffer(idOffer),
      (response) => response.toString(),
    );
  }

  @override
  Future<Result<String>> rejectOffer(int idOffer) {
    return runCatchingAsync<String, String>(
      () => _nftClient.rejectOffer(idOffer),
      (response) => response.toString(),
    );
  }

  @override
  Future<Result<String>> sendOffer(SendOfferRequest request) {
    return runCatchingAsync<String, String>(
      () => _nftClient.sendOffer(request),
      (response) => response.toString(),
    );
  }

  @override
  Future<Result<ConfirmModel>> cancelPawn(int id) {
    return runCatchingAsync<ConfirmResponse, ConfirmModel>(
      () => _nftClient.cancelPawn(id),
      (response) => response.toDomain(),
    );
  }

  @override
  Future<Result<NftMarket>> getDetailNft(
      String collectionAddress, String nftTokenId) {
    return runCatchingAsync<HardNftResponse, NftMarket>(
      () =>
          _nftClient.getDetailNft(collectionAddress, nftTokenId),
      (response) => response.item?.toOnSale() ?? NftMarket.init(),
    );
  }

  @override
  Future<Result<String>> buyOutRequest(BuyOutRequest buyOutRequest) {
    return runCatchingAsync<String, String>(
      () => _nftClient.buyOutRequest(buyOutRequest),
      (response) => response.toString(),
    );
  }
}
