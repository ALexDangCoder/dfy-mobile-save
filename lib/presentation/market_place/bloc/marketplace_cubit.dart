import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/explore_category_model.dart';
import 'package:Dfy/domain/model/market_place/list_type_nft_collection_explore_model.dart';
import 'package:Dfy/domain/model/market_place/outstanding_collection_model.dart';
import 'package:Dfy/domain/repository/market_place/list_type_nft_collection_explore_repository.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'marketplace_state.dart';

class MarketplaceCubit extends BaseCubit<MarketplaceState> {
  MarketplaceCubit() : super(MarketplaceInitial());

  MarketPlaceRepository get _marketPlaceRepo => Get.find();

  List<NftMarket> nftsHotAution = [];
  List<NftMarket> nftsSale = [];

  //pawnNft
  List<NftMarket> nftsCollateral = [];
  List<NftMarket> nftsHardNft = [];
  List<NftMarket> nftsBuySellCreateCollectible = [];
  List<NftMarket> nftsFeaturedSoft = [];
  List<OutstandingCollection> outstandingCollection = [];
  List<ExploreCategory> exploreCategories = [];

  Future<void> getListNftCollectionExplore() async {
    emit(LoadingDataLoading());
    final Result<List<ListTypeNftCollectionExploreModel>> result =
    await _marketPlaceRepo.getListTypeNftCollectionExplore();
    result.when(
      success: (res) {
        getNftCollectionExplore(res);
        emit(LoadingDataSuccess());
      },
      error: (error) {
        emit(LoadingDataFail());
        //todo handle error
      },
    );
  }

  List<Map<String, dynamic>> listCollectionFtExploreFtNft = [];

  String getMarketType(String urlResponse) {
    String marketType = '';
    if (urlResponse.contains('status=1,') ||
        urlResponse.contains('status=2,') ||
        urlResponse.contains('status=3,')) {
      marketType = 'all';
    } else if (urlResponse.contains('status=1')) {
      marketType = 'sale';
    } else if (urlResponse.contains('status=2')) {
      marketType = 'auction';
    } else if (urlResponse.contains('status=3')) {
      marketType = 'pawn';
    } else {
      marketType = 'all';
    }
    return marketType;
  }

  /// not in market 0
  /// sell 1
  /// auction 2
  /// pawn 3

  void getNftCollectionExplore(
      List<ListTypeNftCollectionExploreModel> response,) {
    for (final e in response) {
      if (e.name == 'Buy, sell, and create collectible NFTs') {
        e.items?.forEach(
              (element) =>
              nftsBuySellCreateCollectible.add(
                NftMarket(
                  marketId: element.id,
                  nftId: element.nftId ?? '',
                  tokenBuyOut: element.token ?? '',
                  name: element.name ?? '',
                  image: ApiConstants.BASE_URL_IMAGE + (element.fileCid ?? ''),
                  price: element.price ?? 0,
                  marketType: element.marketType == 1
                      ? MarketType.SALE
                      : (element.marketType == 2
                      ? MarketType.AUCTION
                      : MarketType.PAWN),
                  typeNFT: element.type == 0 ? TypeNFT.SOFT_NFT : TypeNFT
                      .HARD_NFT,
                  typeImage: (element.fileType == 'image/jpeg' ||
                      element.fileType == 'image/gif')
                      ? TypeImage.IMAGE
                      : TypeImage.VIDEO,
                  numberOfCopies: element.numberOfCopies,
                  totalCopies: element.totalCopies ?? 0,
                ),
              ),
        );
        listCollectionFtExploreFtNft.add({
          'name': e.name,
          'position': e.position,
          'nfts': nftsBuySellCreateCollectible,
          'market_type': getMarketType(e.url!) //todo,
        });
      } else if (e.name == 'Featured Soft NFTs') {
        //hard nft chưa có
        e.items?.forEach(
              (element) =>
              nftsFeaturedSoft.add(
                NftMarket(
                  marketId: element.id,
                  nftId: element.nftId ?? '',
                  tokenBuyOut: element.token ?? '',
                  name: element.name ?? '',
                  image: ApiConstants.BASE_URL_IMAGE + (element.fileCid ?? ''),
                  price: element.price ?? 0,
                  marketType: element.marketType == 1
                      ? MarketType.SALE
                      : (element.marketType == 2
                      ? MarketType.AUCTION
                      : MarketType.PAWN),
                  typeNFT: element.type == 0 ? TypeNFT.SOFT_NFT : TypeNFT
                      .HARD_NFT,
                  typeImage: (element.fileType == 'image/jpeg' ||
                      element.fileType == 'image/gif')
                      ? TypeImage.IMAGE
                      : TypeImage.VIDEO,
                  numberOfCopies: element.numberOfCopies,
                  totalCopies: element.totalCopies ?? 0,
                ),
              ),
        );
        listCollectionFtExploreFtNft.add({
          'name': e.name,
          'position': e.position,
          'nfts': nftsFeaturedSoft,
          'market_type': getMarketType(e.url!)
        });
      } else if (e.name == 'Hot auction') {
        e.items?.forEach(
              (element) =>
              nftsHotAution.add(
                NftMarket(
                  marketId: element.id,
                  nftId: element.nftId ?? '',
                  tokenBuyOut: element.token ?? '',
                  name: element.name ?? '',
                  image: ApiConstants.BASE_URL_IMAGE + (element.fileCid ?? ''),
                  price: element.price ?? 0,
                  marketType: element.marketType == 1
                      ? MarketType.SALE
                      : (element.marketType == 2
                      ? MarketType.AUCTION
                      : MarketType.PAWN),
                  typeNFT: element.type == 0 ? TypeNFT.SOFT_NFT : TypeNFT
                      .HARD_NFT,
                  typeImage: (element.fileType == 'image/jpeg' ||
                      element.fileType == 'image/gif')
                      ? TypeImage.IMAGE
                      : TypeImage.VIDEO,
                  numberOfCopies: element.numberOfCopies,
                  totalCopies: element.totalCopies ?? 0,
                ),
              ),
        );
        listCollectionFtExploreFtNft.add({
          'name': e.name,
          'position': e.position,
          'nfts': nftsHotAution,
          'market_type': getMarketType(e.url!)
        });
      } else if (e.name == 'Outstanding collection') {
        e.items?.forEach(
              (e) =>
              outstandingCollection.add(
                OutstandingCollection(
                  id: e.id,
                  name: e.name,
                  itemId: e.itemId,
                  avatarCid: ApiConstants.BASE_URL_IMAGE + (e.avatarCid ?? ''),
                  coverCid: ApiConstants.BASE_URL_IMAGE + (e.coverCid ?? ''),
                  nftOwnerCount: e.nftOwnerCount,
                  totalNft: e.totalNft,
                ),
              ),
        );
        listCollectionFtExploreFtNft.add({
          'name': e.name,
          'position': e.position,
          'collection': outstandingCollection,
        });
      } else if (e.name == 'Sale items') {
        e.items?.forEach(
              (element) =>
              nftsSale.add(
                NftMarket(
                  marketId: element.id,
                  nftId: element.nftId ?? '',
                  tokenBuyOut: element.token ?? '',
                  name: element.name ?? '',
                  image: ApiConstants.BASE_URL_IMAGE + (element.fileCid ?? ''),
                  price: element.price ?? 0,
                  marketType: element.marketType == 1
                      ? MarketType.SALE
                      : (element.marketType == 2
                      ? MarketType.AUCTION
                      : MarketType.PAWN),
                  typeNFT: element.type == 0 ? TypeNFT.SOFT_NFT : TypeNFT
                      .HARD_NFT,
                  typeImage: (element.fileType == 'image/jpeg' ||
                      element.fileType == 'image/gif')
                      ? TypeImage.IMAGE
                      : TypeImage.VIDEO,
                  numberOfCopies: element.numberOfCopies,
                  totalCopies: element.totalCopies ?? 0,
                ),
              ),
        );
        listCollectionFtExploreFtNft.add({
          'name': e.name,
          'position': e.position,
          'nfts': nftsSale,
          'market_type': getMarketType(e.url!)
        });
      } else if (e.name == 'NFTs collateral') {
        e.items?.forEach(
              (element) =>
              nftsCollateral.add(
                NftMarket(
                  marketId: element.id,
                  nftId: element.nftId ?? '',
                  tokenBuyOut: element.token ?? '',
                  name: element.name ?? '',
                  image: ApiConstants.BASE_URL_IMAGE + (element.fileCid ?? ''),
                  price: element.price ?? 0,
                  marketType: element.marketType == 1
                      ? MarketType.SALE
                      : (element.marketType == 2
                      ? MarketType.AUCTION
                      : MarketType.PAWN),
                  typeNFT: element.type == 0 ? TypeNFT.SOFT_NFT : TypeNFT
                      .HARD_NFT,
                  typeImage: (element.fileType == 'image/jpeg' ||
                      element.fileType == 'image/gif')
                      ? TypeImage.IMAGE
                      : TypeImage.VIDEO,
                  numberOfCopies: element.numberOfCopies,
                  totalCopies: element.totalCopies ?? 0,
                ),
              ),
        );
        listCollectionFtExploreFtNft.add({
          'name': e.name,
          'position': e.position,
          'nfts': nftsCollateral,
          'market_type': getMarketType(e.url!)
        });
      } //this else is explore categories
      else {
        e.items?.forEach(
              (e) =>
              exploreCategories.add(
                ExploreCategory(
                  itemId: e.itemId,
                  id: e.id,
                  name: e.name,
                  bannerCid: ApiConstants.BASE_URL_IMAGE + (e.bannerCid ?? ''),
                  displayRow: e.displayRow,
                  displayCol: e.displayCol,
                  position: e.position,
                  avatarCid: ApiConstants.BASE_URL_IMAGE + (e.avatarCid ?? ''),
                ),
              ),
        );
        listCollectionFtExploreFtNft.add({
          'name': e.name,
          'position': e.position,
          'explore': exploreCategories,
        });
      }
    }

    ///sort list map by position to show in UI
    listCollectionFtExploreFtNft
        .sort((a, b) => a["position"].compareTo(b["position"]));
  }
}
