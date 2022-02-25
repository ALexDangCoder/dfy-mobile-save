import 'dart:async';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/collection_market_model.dart';
import 'package:Dfy/domain/model/market_place/fillterCollectionModel.dart';
import 'package:Dfy/domain/model/market_place/wallet_address_model.dart';
import 'package:Dfy/domain/repository/market_place/collection_detail_repository.dart';
import 'package:Dfy/domain/repository/market_place/wallet_address_respository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/collection_list/bloc/collection_state.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class CollectionBloc extends BaseCubit<CollectionState> {
  PageRouter typeScreen;

  CollectionBloc(this.typeScreen) : super(CollectionState());

  static const int HIGHEST_TRADING_VOLUME = 0;
  static const int LOWEST_TRADING_VOLUME = 1;
  static const int NEWEST = 2;
  static const int OLDEST = 3;
  static const int OWNER_FROM_HIGH_TO_LOW = 4;
  static const int OWNER_FROM_LOW_TO_HIGH = 5;
  static const int ITEM_FROM_HIGH_TO_LOW = 6;
  static const int ITEM_FROM_LOW_TO_HIGH = 7;
  static const int SOFT_COLLECTION = 0;
  static const int HARD_COLLECTION = 1;

  //status filter
  String? statusAddress;
  bool? isStatusHardNFT;
  bool? isStatusSoftNft;

  //status filter market
  int? statusFilterMarket;

  void checkStatus() {
    textAddressFilter.add(statusAddress ?? '');
    isSoftCollection.add(isStatusSoftNft ?? false);
    isHardCollection.add(isStatusHardNFT ?? false);
  }

  void checkStatusFirst() {
    statusAddress = textAddressFilter.value;
    isStatusSoftNft = isSoftCollection.value;
    isStatusHardNFT = isHardCollection.value;
  }

  BehaviorSubject<List<CollectionMarketModel>> list =
      BehaviorSubject.seeded([]);

  BehaviorSubject<bool> isHardCollection = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isSoftCollection = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isChooseAcc = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isCanLoadMore = BehaviorSubject.seeded(false);

  BehaviorSubject<String> textSearch = BehaviorSubject.seeded('');
  BehaviorSubject<String> textAddressFilter =
      BehaviorSubject.seeded(S.current.all);
  BehaviorSubject<List<FilterCollectionModel>> listCategoryStream =
      BehaviorSubject.seeded([]);
  int nextPage = 1;
  bool checkWalletAddress = false;
  List<CollectionMarketModel> resList = [];

  CollectionDetailRepository get _collectionDetailRepository => Get.find();

  WalletAddressRepository get _walletAddressRepository => Get.find();

  List<String> listAcc = [
    S.current.all,
  ];
  BehaviorSubject<List<bool>> listCheckBoxFilterStream =
      BehaviorSubject.seeded([
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ]);

  List<bool> listCheckBoxFilter = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  Timer? debounceTime;
  int? sortFilter;
  int? collectionType;
  String? addressWallet;

  void funFilter() {
    statusFilterMarket = sortFilter;
    getCollection(
      sortFilter: sortFilter,
      name: textSearch.value.trim(),
    );
  }

  Future<void> getListWallet() async {
    final Result<List<WalletAddressModel>> result =
        await _walletAddressRepository.getListWalletAddress();
    result.when(
      success: (res) {
        if (res.isEmpty) {
          checkWalletAddress = false;
        } else {
          if (res.length < 2) {
            for (final element in res) {
              if (element.walletAddress?.isNotEmpty ?? false) {
                listAcc.add(element.walletAddress ?? '');
              }
            }
            checkWalletAddress = false;
          } else {
            for (final element in res) {
              if (element.walletAddress?.isNotEmpty ?? false) {
                listAcc.add(element.walletAddress ?? '');
              }
            }
            checkWalletAddress = true;
          }
        }
      },
      error: (error) {
        if (error.code == CODE_ERROR_AUTH) {
          getListWallet();
        }
      },
    );
  }

  String checkAddress(String address) {
    String data = '';
    if (address == S.current.all) {
      data = S.current.all;
    } else {
      if (address.length > 20) {
        data = address.formatAddressWalletConfirm();
      }
    }
    return data;
  }

  String checkNullAddressWallet(String address) {
    String addressWallet = '';
    if (address.length < 20) {
      addressWallet = address;
    } else {
      addressWallet = address.formatAddressWalletConfirm();
    }
    return addressWallet;
  }

  void chooseAddressFilter(String address) {
    textAddressFilter.sink.add(
      address,
    );
    isChooseAcc.sink.add(false);
  }

  void funFilterMyAcc() {
    if (!isHardCollection.value && isSoftCollection.value) {
      collectionType = SOFT_COLLECTION;
    } else if (isHardCollection.value && !isSoftCollection.value) {
      collectionType = HARD_COLLECTION;
    } else {
      collectionType = null;
    }
    addressWallet = textAddressFilter.value;
    if (addressWallet == S.current.all) {
      addressWallet = '';
      for (final String value in listAcc) {
        if (value != S.current.all) {
          if (value.isNotEmpty) {
            if (addressWallet?.isNotEmpty ?? false) {
              addressWallet = '$addressWallet,$value';
            } else {
              addressWallet = value;
            }
          }
        }
      }
    } else {
      addressWallet = textAddressFilter.value;
    }
    statusAddress = addressWallet;
    isStatusHardNFT = isHardCollection.value;
    isStatusSoftNft = isSoftCollection.value;
    getCollection();
  }

  void funChooseFilter(int index) {
    for (int i = 0; i < listCheckBoxFilter.length; i++) {
      listCheckBoxFilter[i] = false;
    }
    listCheckBoxFilter[index] = true;
    listCheckBoxFilterStream.add(listCheckBoxFilter);
    sortFilter = index + 1;
  }

  void checkStatusFilterMarket() {
    if (statusFilterMarket == null) {
      final List<bool> listFilter = [
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false
      ];
      listCheckBoxFilter.clear();
      listCheckBoxFilter.addAll(listFilter);
      listCheckBoxFilterStream.add(listFilter);
    } else {
      listCheckBoxFilter.clear();
      for (int i = 0; i < 8; i++) {
        if (((statusFilterMarket ?? 0) - 1) == i) {
          listCheckBoxFilter.add(true);
        } else {
          listCheckBoxFilter.add(false);
        }
      }
      listCheckBoxFilterStream.add(listCheckBoxFilter);
    }
  }

  void searchCollection(String value) {
    if (debounceTime != null) {
      if (debounceTime!.isActive) {
        debounceTime!.cancel();
      }
    }
    debounceTime = Timer(const Duration(milliseconds: 800), () {
      if (textSearch.value.isEmpty) {
        getCollection(
          sortFilter: sortFilter,
        );
      } else {
        getCollection(
          name: textSearch.value.trim(),
          sortFilter: sortFilter,
        );
      }
    });
  }

  void reset() {
    sortFilter = null;
    listCheckBoxFilterStream.add([
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
    ]);
    for (int i = 0; i < 8; i++) {
      listCheckBoxFilter[i] = false;
    }
  }

  void resetFilterMyAcc() {
    isHardCollection.add(false);
    isSoftCollection.add(false);
    if (checkWalletAddress) {
      textAddressFilter.add(S.current.all);
    }
  }

  void funOnSearch(String value) {
    textSearch.sink.add(value);
    searchCollection(value);
  }

  void funOnTapSearch() {
    textSearch.sink.add('');
    searchCollection('');
  }

  Future<void> getListCollection({
    String? name = '',
    int? sortFilter = 0,
    int? size = 20,
  }) async {
    if (nextPage == 1) {
      nextPage = 2;
    }
    late final Result<List<CollectionMarketModel>> result;
    if (typeScreen == PageRouter.MY_ACC) {
      result = await _collectionDetailRepository.getListCollection(
        name: name,
        sort: sortFilter,
        size: size,
        page: nextPage,
        addressWallet: addressWallet,
        collectionType: collectionType,
      );
    } else {
      result = await _collectionDetailRepository.getListCollectionMarket(
        name: name,
        sort: sortFilter,
        size: size,
        page: nextPage,
      );
    }
    result.when(
      success: (res) {
        final List<CollectionMarketModel> currentList = list.valueOrNull ?? [];
        if (res.isNotEmpty) {
          resList.clear();
          resList = res;
          final List<CollectionMarketModel> listCollection = [];
          for (final CollectionMarketModel value in res) {
            if (value.addressCollection?.isNotEmpty ?? false) {
              listCollection.add(value);
            }
          }
          if (res.length != 20) {
            isCanLoadMore.add(false);
          }
          list.sink.add([...currentList, ...listCollection]);
        } else {
          isCanLoadMore.add(false);
        }
        nextPage++;
      },
      error: (error) {
        emit(LoadingDataFail());
      },
    );
  }

  Future<void> getCollection({
    String? name = '',
    int? sortFilter = 0,
    int? size = 20,
    int? page = 0,
    bool isLoad = true,
  }) async {
    nextPage = 1;
    isCanLoadMore.add(isLoad);
    emit(LoadingData());
    late final Result<List<CollectionMarketModel>> result;
    if (typeScreen == PageRouter.MY_ACC) {
      if (collectionType?.isNaN ?? false) {
        result = await _collectionDetailRepository.getListCollection(
          name: name,
          size: size,
          page: page,
          addressWallet: addressWallet,
        );
      } else {
        result = await _collectionDetailRepository.getListCollection(
          name: name,
          size: size,
          page: page,
          addressWallet: addressWallet,
          collectionType: collectionType,
        );
      }
    } else {
      result = await _collectionDetailRepository.getListCollectionMarket(
        name: name,
        sort: sortFilter,
        size: size,
        page: page,
      );
    }

    result.when(
      success: (res) {
        if (res.isEmpty) {
          emit(LoadingDataErorr());
        } else {
          resList.clear();
          resList = res;
          emit(LoadingDataSuccess());
          final List<CollectionMarketModel> listCollection = [];
          for (final CollectionMarketModel value in res) {
            if (value.addressCollection?.isNotEmpty ?? false) {
              listCollection.add(value);
            }
          }
          if (res.length != 20) {
            isCanLoadMore.add(false);
          }
          list.sink.add(listCollection);
        }
      },
      error: (error) {
        emit(LoadingDataFail());
      },
    );
  }

  void dispone() {
    isHardCollection.close();
    isSoftCollection.close();
    isChooseAcc.close();
    isCanLoadMore.close();
    listCategoryStream.close();
    list.close();
    listCheckBoxFilterStream.close();
  }
}
