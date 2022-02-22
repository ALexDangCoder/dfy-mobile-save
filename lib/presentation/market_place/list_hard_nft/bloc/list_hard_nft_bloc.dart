import 'dart:async';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/domain/repository/market_place/nft_market_repo.dart';
import 'package:Dfy/presentation/market_place/list_hard_nft/bloc/list_hard_nft_state.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class ListHardNftBloc extends BaseCubit<ListHardNftState> {
  BehaviorSubject<bool> isCanLoadMore = BehaviorSubject.seeded(false);
  BehaviorSubject<String> textSearch = BehaviorSubject.seeded('');
  BehaviorSubject<List<NftMarket>> listNft = BehaviorSubject.seeded([]);
  BehaviorSubject<List<bool>> listFilterStream = BehaviorSubject.seeded([
    false,
    false,
    false,
    false,
  ]);
  List<NftMarket> listRes = [];
  List<bool> listFilter = [
    false,
    false,
    false,
    false,
  ];
  int nextPage = 1;
  static const int SALE_FILTER = 0;
  static const int PAWN_FILTER = 1;
  static const int AUCTION_FILTER = 2;
  static const int NOT_ON_MARKET_FILTER = 3;
  Timer? debounceTime;
  String? status;

  ListHardNftBloc() : super(ListHardNftState());

  NftMarketRepository get _nftRepo => Get.find();

  void funFilterNft() {
    getListNft(
      status: checkStatusFilter(),
      name: textSearch.value.trim(),
    );
  }

  String checkStatusFilter() {
    for (int i = 0; i < listFilterStream.value.length; i++) {
      if (listFilterStream.value[i]) {
        if (i == SALE_FILTER) {
          return status = SALE.toString();
        } else if (i == PAWN_FILTER) {
          return status = PAWN.toString();
        } else if (i == AUCTION_FILTER) {
          return status = AUCTION.toString();
        } else {
          return status = NOT_ON_MARKET.toString();
        }
      }
    }
    return '';
  }

  void funOnSearch(String value) {
    textSearch.sink.add(value);
    searchCollection(value);
  }

  void funOnTapSearch() {
    textSearch.sink.add('');
    searchCollection('');
  }

  void searchCollection(String value) {
    if (debounceTime != null) {
      if (debounceTime!.isActive) {
        debounceTime!.cancel();
      }
    }
    debounceTime = Timer(const Duration(milliseconds: 800), () {
      if (textSearch.value.isEmpty) {
        getListNft(
          status: checkStatusFilter(),
        );
      } else {
        getListNft(
          name: textSearch.value.trim(),
          status: checkStatusFilter(),
        );
      }
    });
  }

  void resetFilterNFTMyAcc() {
    listFilter = List.filled(4, false);
    listFilterStream.sink.add(listFilter);
    status = '';
  }

  void chooseFilter({required int index}) {
    listFilter = List.filled(4, false);
    listFilter[index] = true;
    listFilterStream.sink.add(listFilter);
  }

  Future<void> getListNft({
    String? limit = '12',
    String? name = '',
    String? size = '12',
    String? status = '',
    bool isLoad = true,
  }) async {
    nextPage = 1;
    isCanLoadMore.add(isLoad);
    emit(LoadingData());
    final result = await _nftRepo.getListHardNft(
      name: textSearch.value,
      limit: limit,
      size: size,
      page: nextPage.toString(),
      status: checkStatusFilter(),
    );
    emit(LoadingData());
    result.when(
      success: (res) {
        emit(LoadingData());
        if (res.isNotEmpty) {
          listRes.clear();
          listRes.addAll(res);
          emit(LoadingDataSuccess());
          if (res.length != 12) {
            isCanLoadMore.add(false);
          }
          listNft.sink.add(res);
        } else {
          emit(LoadingDataErorr());
        }
      },
      error: (error) {
        if (error.code == CODE_ERROR_AUTH) {
          getListNft();
        }
        emit(LoadingDataFail());
      },
    );
  }

  Future<void> getListNftReload({
    String? limit = '12',
    String? name = '',
    String? size = '12',
    bool isLoad = true,
  }) async {
    if (nextPage == 1) {
      nextPage = 2;
    }
    final result = await _nftRepo.getListHardNft(
      name: textSearch.value,
      limit: limit,
      size: size,
      page: nextPage.toString(),
      status: checkStatusFilter(),
    );
    result.when(
      success: (res) {
        if (res.isNotEmpty) {
          listRes.clear();
          listRes.addAll(res);
          if (res.length != 12) {
            isCanLoadMore.add(false);
          }
          listNft.sink.add([...listNft.value, ...res]);
        } else {
          isCanLoadMore.add(false);
        }
        nextPage++;
      },
      error: (error) {
        if (error.code == CODE_ERROR_AUTH) {
          getListNft();
        }
        emit(LoadingDataFail());
      },
    );
  }
}
