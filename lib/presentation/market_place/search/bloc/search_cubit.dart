import 'dart:async';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/collection.dart';
import 'package:Dfy/domain/model/nft_item.dart';
import 'package:Dfy/domain/model/search_marketplace/list_search_collection_nft_model.dart';
import 'package:Dfy/domain/model/search_marketplace/search_collection_nft_model.dart';
import 'package:Dfy/domain/repository/search_market/search_market_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'search_state.dart';

class SearchCubit extends BaseCubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  SearchMarketRepository get _searchMarketRepo => Get.find();

  final BehaviorSubject<bool> _isVisible = BehaviorSubject<bool>();
  final BehaviorSubject<String> txtWarningSearch = BehaviorSubject<String>();

  Stream<bool> get isVisible => _isVisible.stream;

  void show() {
    _isVisible.sink.add(true);
  }

  void hide() {
    _isVisible.sink.add(false);
  }

  void validateTextSearch(String value) {
    if (value.length > 255) {
      txtWarningSearch.sink.add(S.current.maximum_255);
    } else {
      txtWarningSearch.sink.add('');
    }
  }

  Future<void> getCollectionFeatNftBySearch({required String query}) async {
    emit(SearchLoading());
    clearCollectionsFtNftsAfterSearch();
    final Result<List<ListSearchCollectionFtNftModel>> result =
    await _searchMarketRepo.getCollectionFeatNftSearch(
      name: query.trim(),
    );
    result.when(
      success: (res) {
        responseToCollectionFtNftModel(res);
      },
      error: (error) {
        //todo handle error
        emit(SearchError());
      },
    );
  }

  List<SearchCollectionNftModel> collectionsSearch = [];
  List<SearchCollectionNftModel> nftsSearch = [];
  List<Collection> collections = [];
  List<NftItem> listNFT = [];

  void responseToCollectionFtNftModel(
      List<ListSearchCollectionFtNftModel> response,) {
    for (final element in response) {
      if (element.name == 'Collection') {
        collectionsSearch = element.items ?? [];
        for (final element in collectionsSearch) {
          collections.add(
            Collection(
              collectionAddress: element.collectionAddress ?? '',
              id: element.id ?? '',
              items: int.parse(element.info ?? '0'),
              title: element.name ?? 'name',
              background:
              ApiConstants.BASE_URL_IMAGE + (element.coverCid ?? ''),
              avatar: ApiConstants.BASE_URL_IMAGE + (element.imageCid ?? ''),
            ),
          );
        }
      } else {
        nftsSearch = element.items ?? [];
        for (final element in nftsSearch) {
          listNFT.add(
            NftItem(
              typeImage: (element.fileType ?? '').contains('image')
                  ? TypeImage.IMAGE
                  : TypeImage.VIDEO,
              marketId: element.id,
              price: 0,
              name: element.name ?? 'name',
              image: ApiConstants.BASE_URL_IMAGE + (element.imageCid ?? 'url'),
              marketType: element.marketType == 'Auction'
                  ? MarketType.AUCTION
                  : (element.marketType == 'Sell'
                  ? MarketType.SALE
                  : MarketType.PAWN),
              pawnId: element.pawnId,
              typeNFT:
              (element.type == 0) ? TypeNFT.SOFT_NFT : TypeNFT.HARD_NFT,
              nftId: element.nftId,
              coverCidIfVid: element.coverCid,
            ),
          );
        }
      }
    }
    if (collectionsSearch.isEmpty && nftsSearch.isEmpty) {
      emit(SearchError());
    } else {
      emit(SearchSuccess());
    }
  }

  void clearCollectionsFtNftsAfterSearch() {
    collections.clear();
    listNFT.clear();
  }

  void search(String value) {
    emit(SearchLoading());
    Timer(const Duration(milliseconds: 500), () {
      emit(SearchSuccess());
    });
  }

  final BehaviorSubject<int> _lengthStream = BehaviorSubject<int>.seeded(3);

  Stream<int> get lengthStream => _lengthStream.stream;

  void showAllResult(int items) {
    _lengthStream.sink.add(items);
  }

  void dispose() {
    _lengthStream.close();
  }

}