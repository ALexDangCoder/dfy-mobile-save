import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/market_place/explore_category_model.dart';
import 'package:Dfy/domain/model/market_place/list_type_nft_collection_explore_model.dart';
import 'package:Dfy/domain/model/market_place/outstanding_collection_model.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/repository/market_place/list_type_nft_collection_explore_repository.dart';
import 'package:Dfy/presentation/market_place/ui/components_list_nft_categories/list_explore_category.dart';
import 'package:Dfy/presentation/market_place/ui/components_list_nft_categories/list_nft_home.dart';
import 'package:Dfy/presentation/market_place/ui/components_list_nft_categories/list_outstanding_collection.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'marketplace_state.dart';

class MarketplaceCubit extends BaseCubit<MarketplaceState> {
  MarketplaceCubit() : super(MarketplaceInitial());

  MarketPlaceRepository get _marketPlaceRepo => Get.find();

  // void clearAllBeforePullToRefresh() {
  //   nftsHotAution.clear();
  //   nftsSale.clear();
  //   nftsCollateral.clear();
  //   nftsHardNft.clear();
  //   nftsBuySellCreateCollectible.clear();
  //   nftsFeaturedSoft.clear();
  //   outstandingCollection.clear();
  //   exploreCategories.clear();
  //   nftsFeaturedNfts.clear();
  //   listCollectionFtExploreFtNft.clear();
  // }

  void clearAllBeforePullToRefresh() {
    listWidgetHome.clear();
    nftsHotAution.clear();
    nftsSale.clear();
    nftsCollateral.clear();
    nftsHardNft.clear();
    outstandingCollection.clear();
    exploreCategories.clear();
    nftsFeaturedNfts.clear();
    listCollectionFtExploreFtNft.clear();
  }

  final List<Widget> listWidgetHome = [];

  ///start category
  void handleWidgetDuplicated(MarketplaceCubit cubit) {
    List<String> checkDuplicated = [];
    for (int i = 0; i < cubit.listCollectionFtExploreFtNft.length; i++) {
      if (checkDuplicated
          .contains(cubit.listCollectionFtExploreFtNft[i]['name'])) {
        continue;
      } else {
        checkDuplicated.add(cubit.listCollectionFtExploreFtNft[i]['name']);
        if (cubit.listCollectionFtExploreFtNft[i]['type'] ==
            MarketplaceCubit.NFT) {
          listWidgetHome.add(Column(
            children: [
              ListNftHome(
                cubit: cubit,
                isLoading: false,
                isLoadFail: false,
                marketType: cubit.listCollectionFtExploreFtNft[i]
                ['market_type'],
                listNft: cubit.listCollectionFtExploreFtNft[i]['nfts'],
                title: cubit.listCollectionFtExploreFtNft[i]['name'],
              ),
              spaceH32,
            ],
          ));
        } else if (cubit.listCollectionFtExploreFtNft[i]['type'] ==
            MarketplaceCubit.COLLECTION) {
          listWidgetHome.add(Column(
            children: [
              ListOutstandingCollection(
                cubit: cubit,
                isLoading: false,
                isLoadFail: false,
              ),
              spaceH32,
            ],
          ));
        } else if (cubit.listCollectionFtExploreFtNft[i]['type'] ==
            MarketplaceCubit.CATEGORY) {
          listWidgetHome.add(Column(
            children: [
              ListExploreCategory(
                cubit: cubit,
                isLoading: false,
                isLoadFail: false,
              ),
              SizedBox(
                height: 32.h,
              ),
            ],
          ));
        } else if (cubit.listCollectionFtExploreFtNft[i]['type'] ==
            MarketplaceCubit.PAWN) {
          listWidgetHome.add(Column(
            children: [
              ListNftHome(
                cubit: cubit,
                isLoading: false,
                isLoadFail: false,
                marketType: cubit.listCollectionFtExploreFtNft[i]
                ['market_type'],
                listNft: cubit.listCollectionFtExploreFtNft[i]['nfts'],
                title: cubit.listCollectionFtExploreFtNft[i]['name'],
              ),
              spaceH32,
            ],
          ));
        } else {
          listWidgetHome.add(Column(
            children: [
              ListNftHome(
                cubit: cubit,
                isLoading: false,
                isLoadFail: false,
                marketType: cubit.listCollectionFtExploreFtNft[i]
                ['market_type'],
                listNft: cubit.listCollectionFtExploreFtNft[i]['nfts'],
                title: cubit.listCollectionFtExploreFtNft[i]['name'],
              ),
              spaceH32,
            ],
          ));
        }
      }
    }
  }
  ///end

  Future<void> getListNftCollectionExplore({required MarketplaceCubit cubit}) async {
    emit(LoadingDataLoading());
    getTokenInf();
    final Result<List<ListTypeNftCollectionExploreModel>> result =
        await _marketPlaceRepo.getListTypeNftCollectionExplore();
    result.when(
      success: (res) {
        getNftCollectionExplore(res);
        handleWidgetDuplicated(cubit);
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

  List<TokenInf> listTokenSupport = [];

  void getTokenInf() {
    final String listToken = PrefsService.getListTokenSupport();
    listTokenSupport = TokenInf.decode(listToken);
  }

  String getUrl(String tokenAddress) {
    for (final token in listTokenSupport) {
      if (tokenAddress.toLowerCase() == token.address?.toLowerCase()) {
        return token.iconUrl ?? '';
      }
    }
    return '';
  }

  static const int NFT = 0;
  static const int AUCTION = 1;
  static const int COLLECTION = 2;
  static const int CATEGORY = 3;
  static const int PAWN = 4;




  List<NftMarket> nftsHotAution = [];
  List<NftMarket> nftsSale = [];

  //pawnNft
  List<NftMarket> nftsCollateral = [];
  List<NftMarket> nftsHardNft = [];
  List<NftMarket> nftsBuySellCreateCollectible = [];
  List<OutstandingCollection> outstandingCollection = [];
  List<ExploreCategory> exploreCategories = [];
  List<NftMarket> nftsFeaturedNfts = [];

  int countDuplicated = 0;

  void getNftCollectionExplore(
    List<ListTypeNftCollectionExploreModel> response,
  ) {
    for (final e in response) {
      if (e.type == PAWN) {
        e.items?.forEach(
          (element) => nftsCollateral.add(
            NftMarket(
                urlToken: getUrl(element.token ?? ''),
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
                typeNFT:
                    element.type == 0 ? TypeNFT.SOFT_NFT : TypeNFT.HARD_NFT,
                typeImage: (element.fileType ?? '').contains('image')
                    ? TypeImage.IMAGE
                    : TypeImage.VIDEO,
                numberOfCopies: element.numberOfCopies,
                totalCopies: element.totalCopies ?? 0,
                cover: ApiConstants.BASE_URL_IMAGE + (element.coverCid ?? '')),
          ),
        );
        listCollectionFtExploreFtNft.add({
          'type': e.type,
          'name': e.name,
          'position': e.position,
          'nfts': nftsCollateral,
          'market_type': getMarketType(e.url ?? '') //todo,
        });
      } else if (e.type == AUCTION) {
        e.items?.forEach(
          (element) => nftsHotAution.add(
            NftMarket(
              urlToken: getUrl(element.token ?? ''),
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
              typeNFT: element.type == 0 ? TypeNFT.SOFT_NFT : TypeNFT.HARD_NFT,
              typeImage: (element.fileType ?? '').contains('image')
                  ? TypeImage.IMAGE
                  : TypeImage.VIDEO,
              numberOfCopies: element.numberOfCopies,
              totalCopies: element.totalCopies ?? 0,
              cover: ApiConstants.BASE_URL_IMAGE + (element.coverCid ?? ''),
            ),
          ),
        );
        listCollectionFtExploreFtNft.add({
          'type': e.type,
          'name': e.name,
          'position': e.position,
          'nfts': nftsHotAution,
          'market_type': getMarketType(e.url ?? '')
        });
      } else if (e.type == COLLECTION) {
        e.items?.forEach(
          (e) => outstandingCollection.add(
            OutstandingCollection(
              collectionAddress: e.collectionAddress,
              collectionType: e.collectionType,
              id: e.id,
              name: e.name,
              itemId: e.itemId,
              avatarCid: ApiConstants.BASE_URL_IMAGE + (e.avatarCid ?? ''),
              coverCid: ApiConstants.BASE_URL_IMAGE + (e.featureCid ?? ''),
              nftOwnerCount: e.nftOwnerCount,
              totalNft: e.totalNft,
            ),
          ),
        );
        listCollectionFtExploreFtNft.add({
          'type': e.type,
          'name': e.name,
          'position': e.position,
          'collection': outstandingCollection,
        });
      } else if (e.type == NFT) {
        countDuplicated += 1;
        final List<NftMarket> nftsJustNft = [];
        e.items?.forEach(
          (element) => nftsJustNft.add(
            NftMarket(
              urlToken: getUrl(element.token ?? ''),
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
              typeNFT: element.type == 0 ? TypeNFT.SOFT_NFT : TypeNFT.HARD_NFT,
              typeImage: (element.fileType ?? '').contains('image')
                  ? TypeImage.IMAGE
                  : TypeImage.VIDEO,
              numberOfCopies: element.numberOfCopies,
              totalCopies: element.totalCopies ?? 0,
              cover: ApiConstants.BASE_URL_IMAGE + (element.coverCid ?? ''),
            ),
          ),
        );
        listCollectionFtExploreFtNft.add({
          'type': e.type,
          'name': e.name,
          'position': e.position,
          'nfts': nftsJustNft,
          'market_type': getMarketType(e.url ?? '') //todo,
        });
      } //this else is explore categories
      else {
        e.items?.forEach(
          (e) => exploreCategories.add(
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
          'type': e.type,
          'name': e.name,
          'position': e.position,
          'explore': exploreCategories,
        });
      }
    }

    ///sort list map by position to show in UI
    // listCollectionFtExploreFtNft
    //     .sort((a, b) => a["position"].compareTo(b["position"]));
  }

  // final listWidget = <String>[];
  //
  // void test() {
  //   List<String> checkDuplicated = [];
  //   for (var i = 0; i < listCollectionFtExploreFtNft.length; i++) {
  //     if(checkDuplicated.contains(listCollectionFtExploreFtNft[i]['name'])) {
  //       continue;
  //     } else {
  //       checkDuplicated.add(listCollectionFtExploreFtNft[i]['name']);
  //       listWidget.add(listCollectionFtExploreFtNft[i]['name']);
  //     }
  //   }
  //   print('nnono');
  //   print(listWidget);
  // }
}
