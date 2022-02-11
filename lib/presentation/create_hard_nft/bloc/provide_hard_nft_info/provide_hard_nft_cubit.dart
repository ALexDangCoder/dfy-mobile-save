import 'dart:core';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/config/base/base_state.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/city_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/condition_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/country_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/phone_code_model.dart';
import 'package:Dfy/domain/model/market_place/collection_market_model.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/repository/hard_nft_my_account/step1/step1_repository.dart';
import 'package:Dfy/domain/repository/market_place/collection_detail_repository.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

part 'provide_hard_nft_state.dart';

enum DropDownBtnType {
  CONDITION,
  COUNTRY,
  CITY,
}

class PropertyModel {
  String value;
  String property;

  PropertyModel({required this.value, required this.property});
}

class ProvideHardNftCubit extends BaseCubit<ProvideHardNftState> {
  ProvideHardNftCubit() : super(ProvideHardNftInitial());

  BehaviorSubject<bool> visibleDropDownCountry = BehaviorSubject();

  // BehaviorSubject<bool> showItemProperties = BehaviorSubject();
  BehaviorSubject<List<PropertyModel>> showItemProperties = BehaviorSubject();

  ///Di
  Step1Repository get _step1Repository => Get.find();

  CollectionDetailRepository get _collectionDetailRepository => Get.find();

  ///api
  ///convert to map to use in cool dropdown
  List<Map<String, dynamic>> phonesCode = [];
  List<Map<String, dynamic>> countries = [];
  List<Map<String, dynamic>> cities = [];
  List<Map<String, dynamic>> conditions = [];
  List<PropertyModel> properties = [];

  BehaviorSubject<List<Map<String, dynamic>>> countriesBHVSJ =
      BehaviorSubject();
  BehaviorSubject<List<Map<String, dynamic>>> phonesCodeBHVSJ =
      BehaviorSubject();
  BehaviorSubject<List<Map<String, dynamic>>> citiesBHVSJ = BehaviorSubject();
  BehaviorSubject<List<Map<String, dynamic>>> conditionBHVSJ =
      BehaviorSubject();
  BehaviorSubject<List<Map<String, dynamic>>> collectionsBHVSJ =
      BehaviorSubject();

  Future<void> getPhonesApi() async {
    final Result<List<PhoneCodeModel>> resultPhone =
        await _step1Repository.getPhoneCode();
    resultPhone.when(
      success: (res) {
        res.forEach(
          (e) => phonesCode.add({
            'value': e.code ?? '',
            'label': e.id.toString(),
          }),
        );
        phonesCodeBHVSJ.sink.add(phonesCode);
        // phonesCodeBHVSJ.sink.add([]);
      },
      error: (error) {
        //todo
      },
    );
  }
  List<TokenInf> listTokenSupport = [];

  void getTokenInf() {
    final String listToken = PrefsService.getListTokenSupport();
    listTokenSupport = TokenInf.decode(listToken);
  }


  Future<void> getCountriesApi() async {
    //emit(Step1LoadingCountry());
    final Result<List<CountryModel>> resultCountries =
        await _step1Repository.getCountries();
    resultCountries.when(
      success: (res) {
        res.forEach(
          (e) => countries
              .add({'value': e.id.toString(), 'label': e.name ?? ''}),
        );
        countriesBHVSJ.sink.add(countries);
      },
      error: (error) {
        //todo
      },
    );
  }

  Future<void> getConditionsApi() async {
    final Result<List<ConditionModel>> resultConditions =
        await _step1Repository.getConditions();

    resultConditions.when(
      success: (res) {
        res.forEach((element) {
          conditions.add({
            'value': element.id.toString() ,
            'label': element.name ?? '',
          });
        });
        conditionBHVSJ.sink.add(conditions);
      },
      error: (error) {
        conditionBHVSJ.sink.add([]);
      },
    );
  }

  List<Map<String, dynamic>> loadingDropDown = [
    {'label': 'Đang Tải'},
  ];

  List<Map<String, dynamic>> error = [
    {'label': 'Không có dữ liệu'},
  ];

  String getAddressWallet() {
    return PrefsService.getCurrentBEWallet();
  }

  Future<void> getCollectionAfterConnectWallet() async {
    print(getAddressWallet);
    final resultCollection =
        await _collectionDetailRepository.getListCollection(
      addressWallet: getAddressWallet(),
    );
    resultCollection.when(
      success: (res) {
        print(res);
      },
      error: (error) {
        print(error);
      },
    );
  }

  Future<void> getListCollection() async {
    List<CollectionMarketModel> listHardCl = [];

    final Result<List<CollectionMarketModel>> result =
        await _collectionDetailRepository.getListCollection(
      addressWallet: getAddressWallet(),
    );
    result.when(
      success: (res) {
        listHardCl = res
            .where(
              (element) =>
                  (element.type == HARD_COLLECTION) &&
                  ((element.addressCollection ?? '').isNotEmpty),
            )
            .toList();
        final listDropDown = listHardCl.map((e) => e.toDropDownMap()).toList();
        collectionsBHVSJ.sink.add(listDropDown);
      },
      error: (_) {},
    );
  }

  Future<void> getCitiesApi(dynamic id) async {
    cities.clear();
    citiesBHVSJ.sink.add(loadingDropDown);
    final Result<List<CityModel>> resultCities =
        await _step1Repository.getCities(id.toString());
    cities.clear();
    resultCities.when(
      success: (response) {
        response.forEach((element) {
          cities.add({
            'value': element.id,
            'label': element.name,
          });
        });
        if (cities.isEmpty) {
          citiesBHVSJ.sink.add(error);
        } else {
          citiesBHVSJ.sink.add(cities);
        }
      },
      error: (error) {
        //todo handle error
        citiesBHVSJ.sink.add([]);
      },
    );
  }

  void checkPropertiesWhenSave() {
    properties.forEach(
      (element) {
        properties.removeWhere(
          (element) => element.property.isEmpty || element.value.isEmpty,
        );
      },
    );
    if (properties.isEmpty) {
      showItemProperties.sink.add([]);
    } else {
      showItemProperties.sink.add(properties);
    }
  }

  void showHideDropDownBtn({
    DropDownBtnType? typeDropDown,
    bool? value,
  }) {
    if (typeDropDown != null) {
      switch (typeDropDown) {
        case DropDownBtnType.CITY:
          break;
        case DropDownBtnType.COUNTRY:
          visibleDropDownCountry.sink.add(value ?? true);
          break;
        default:
          break;
      }
    } else {
      visibleDropDownCountry.sink.add(false);
    }
  }
}
