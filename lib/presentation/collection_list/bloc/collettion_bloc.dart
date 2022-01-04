import 'package:Dfy/data/result/result.dart';;
import 'package:Dfy/domain/model/market_place/collection_model.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/domain/repository/market_place/list_type_nft_collection_explore_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../../main.dart';

class CollectionBloc {
  CollectionBloc() {
    getCollection();
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
  BehaviorSubject<bool> isCategoryType1 = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isCategoryType2 = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isCategoryType3 = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isCategoryType4 = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isChooseAcc = BehaviorSubject.seeded(false);

  BehaviorSubject<bool> isMusic = BehaviorSubject.seeded(false);
  BehaviorSubject<String> textSearch = BehaviorSubject.seeded('');
  BehaviorSubject<String> textAddressFilter =
      BehaviorSubject.seeded(S.current.all);
  BehaviorSubject<String> textSearchCategory = BehaviorSubject.seeded('');

  MarketPlaceRepository get _marketPlaceRepository => Get.find();
  List<CollectionModel> arg = [];

  List<String> listAcc = [
    S.current.all,
  ];

  List<String> listCategory = [
    'ádfasdfsadfasdfsadfsadf',
    '11111111111111111111111ádfasdfsadfasdfsadfsadf',
    '2222222222222222ádfasdfsadfasdfsadfsadf',
    '3333333333333333333ádfasdfsadfasdfsadfsadf'
  ];

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
    isCategoryType1.sink.add(value);
    isCategoryType2.sink.add(value);
    isCategoryType3.sink.add(value);
    isCategoryType4.sink.add(value);
  }

  void funOnSearch(String value) {
    textSearch.sink.add(value);
  }

  void funOnTapSearch() {
    textSearch.sink.add('');
    // widget.bloc.search();
  }

  void funOnSearchCategory(String value) {
    textSearchCategory.sink.add(value);
  }

  void funOnTapSearchCategory() {
    textSearchCategory.sink.add('');
    // widget.bloc.search();
  }

  Future<void> getCollection() async {
    final Result<List<CollectionModel>> result =
        await _marketPlaceRepository.getListCollection();
    result.when(
      success: (res) {
        arg = res.toList();
        list.sink.add(arg);
      },
      error: (error) {},
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
        print('ádfasdf');
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
