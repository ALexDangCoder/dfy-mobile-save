import 'dart:async';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/collection_market_model.dart';
import 'package:Dfy/domain/model/market_place/fillterCollectionModel.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/domain/repository/market_place/collection_detail_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/collection_list/bloc/collection_state.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../../main.dart';

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

  BehaviorSubject<List<CollectionMarketModel>> list =
      BehaviorSubject.seeded([]);
  BehaviorSubject<bool> isHighestTradingVolume = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isLowestTradingVolume = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isNewest = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isOldest = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isOwnerFromHighToLow = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isOwnerFromLowToHigh = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isItemFromHighToLow = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isItemFromLowToHigh = BehaviorSubject.seeded(false);

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

  CollectionDetailRepository get _collectionDetailRepository => Get.find();
  List<CollectionMarketModel> arg = [];

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
    getCollection(
      sortFilter: sortFilter,
      name: textSearch.value.trim(),
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
      addressWallet = null;
    } else {
      addressWallet = textAddressFilter.value;
    }
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
    textAddressFilter.add(S.current.all);
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
    if (typeScreen==PageRouter.MY_ACC) {
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
          list.sink.add([...currentList, ...res]);
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
    if (typeScreen==PageRouter.MY_ACC) {
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
          emit(LoadingDataSuccess());
          arg = res.toList();
          list.sink.add(arg);
        }
      },
      error: (error) {
        emit(LoadingDataFail());
      },
    );
  }

  Future<void> getListWallets() async {
    try {
      final data = {};
      await trustWalletChannel.invokeMethod('getListWallets', data);
    } on PlatformException {
      //nothing
    }
  }

  List<Wallet> listWallet = [];

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'getListWalletsCallback':
        final List<dynamic> data = methodCall.arguments;
        for (final element in data) {
          listWallet.add(Wallet.fromJson(element));
        }
        for (final element in listWallet) {
          listAcc.add(element.address ?? '');
        }
        break;
      default:
        break;
    }
  }

  void dispone() {
    isHardCollection.close();
    isSoftCollection.close();
    list.close();
  }
}
