import 'dart:async';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/category_model.dart';
import 'package:Dfy/domain/model/market_place/collection_model.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/domain/repository/market_place/category_repository.dart';
import 'package:Dfy/domain/repository/market_place/list_type_nft_collection_explore_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/collection_list/bloc/collection_state.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../../main.dart';

class CollectionBloc extends BaseCubit<CollectionState> {
  CollectionBloc() : super(CollectionState()) {
    getCollection();
    getListCategory();
  }

  //getlistcollection
  BehaviorSubject<List<CollectionModel>> list = BehaviorSubject();

  //filter collection
  BehaviorSubject<bool> isHardNft = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isSoftNft = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isArt = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isGame = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isCollectibles = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isUltilities = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isOthersCategory = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isCars = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isSports = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isAll = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isAllCategory = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isAllCategoryMyAcc = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isChooseAcc = BehaviorSubject.seeded(false);

  BehaviorSubject<bool> isMusic = BehaviorSubject.seeded(false);
  BehaviorSubject<String> textSearch = BehaviorSubject.seeded('');
  BehaviorSubject<String> textAddressFilter =
      BehaviorSubject.seeded(S.current.all);
  BehaviorSubject<String> textSearchCategory = BehaviorSubject.seeded('');
  BehaviorSubject<List<Category>> listCategoryStream =
      BehaviorSubject.seeded([]);

  List<bool> isListCategory = [false, false, false, false];

  MarketPlaceRepository get _marketPlaceRepository => Get.find();
  List<CollectionModel> arg = [];

  List<String> listAcc = [
    S.current.all,
  ];

  List<Category> listCategory = [];

  CategoryRepository get _categoryRepository => Get.find();

  Timer? debounceTime;

  void searchCollection(String value) {
    if (debounceTime != null) {
      if (debounceTime!.isActive) {
        debounceTime!.cancel();
      }
    }
    debounceTime = Timer(const Duration(milliseconds: 800), () {
      if (textSearch.value.isEmpty) {
        getCollection();
       }
      else {
        getCollection(name: textSearch.value);
      }
    });
  }

  /// get list category
  Future<void> getListCategory() async {
    final Result<List<Category>> result =
        await _categoryRepository.getListCategory();
    result.when(
      success: (res) {
        listCategory.addAll(res);
        listCategoryStream.add(listCategory);
      },
      error: (error) {},
    );
  }

  void reset() {
    isAllCategory.sink.add(false);
    isAll.sink.add(false);
    isHardNft.sink.add(false);
    isSoftNft.sink.add(false);
    isArt.sink.add(false);
    isGame.sink.add(false);
    isCollectibles.sink.add(false);
    isUltilities.sink.add(false);
    isOthersCategory.sink.add(false);
    isCars.sink.add(false);
    isSports.sink.add(false);
    isMusic.sink.add(false);
  }

  void resetFilterMyAcc() {
    allCollection(false);
    isAll.sink.add(false);
    allCategoryMyAcc(false);
    isAllCategoryMyAcc.sink.add(false);
    funOnTapSearchCategory();
    textAddressFilter.add(S.current.all);
  }

  void allCollection(bool value) {
    isHardNft.sink.add(value);
    isSoftNft.sink.add(value);
  }

  void allCategory(bool value) {
    isArt.sink.add(value);
    isGame.sink.add(value);
    isCollectibles.sink.add(value);
    isUltilities.sink.add(value);
    isOthersCategory.sink.add(value);
    isCars.sink.add(value);
    isSports.sink.add(value);
    isMusic.sink.add(value);
  }

  void allCategoryMyAcc(bool value) {
    isListCategory.addAll([
      value,
      value,
      value,
      value,
    ]);
  }

  void funOnSearch(String value) {
    textSearch.sink.add(value);
    searchCollection(value);
  }

  void funOnTapSearch() {
    textSearch.sink.add('');
    searchCollection('');
  }

  void funOnSearchCategory(String value) {
    textSearchCategory.sink.add(value);
    final List<Category> search = [];
    for (final element in listCategory) {
      if (element.name!.toLowerCase().contains(value.toLowerCase())) {
        search.add(element);
      }
    }
    if (value.isEmpty) {
      listCategoryStream.add(listCategory);
      isListCategory.addAll([
        false,
        false,
        false,
        false,
      ]);
    } else {
      listCategoryStream.add(search);
    }
  }

  void funOnTapSearchCategory() {
    textSearchCategory.sink.add('');
    listCategoryStream.add(listCategory);
  }

  Future<void> getCollection({String? name = ''}) async {
    emit(LoadingData());
    final Result<List<CollectionModel>> result =
        await _marketPlaceRepository.getListCollection(name: name);
    result.when(
      success: (res) {
        emit(LoadingDataSuccess());
        arg = res.toList();
        list.sink.add(arg);
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
          listAcc.add(element.address?.formatAddressWalletConfirm() ?? '');
        }
        break;
      default:
        break;
    }
  }

  void dispone() {
    isHardNft.close();
    isSoftNft.close();
    isArt.close();
    isGame.close();
    isCollectibles.close();
    isUltilities.close();
    isOthersCategory.close();
    isCars.close();
    isSports.close();
    isMusic.close();
    list.close();
  }
}
