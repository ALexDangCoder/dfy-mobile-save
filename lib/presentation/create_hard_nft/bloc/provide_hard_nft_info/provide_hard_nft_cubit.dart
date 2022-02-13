import 'dart:core';
import 'dart:developer';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/config/base/base_state.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/city_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/condition_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/country_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/hard_nft_type_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/phone_code_model.dart';
import 'package:Dfy/domain/model/market_place/collection_market_model.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/repository/hard_nft_my_account/step1/step1_repository.dart';
import 'package:Dfy/domain/repository/market_place/collection_detail_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
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

  final regexAmount = RegExp(r'^\d+((.)|(.\d{0,5})?)$');

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

  ///List path image
  List<String> listPathImage = [];
  List<String> listPathDocument = [];
  String currentImagePath = '';
  int currentIndexImage = 0;
  List<HardNftTypeModel> listHardNftType = [];

  List<bool> listChangeColorFtChoose = [
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  BehaviorSubject<List<bool>> listChangeColorFtChooseBHVSJ =
      BehaviorSubject.seeded([
    false,
    false,
    false,
    false,
    false,
    false,
  ]);

  ///id is index
  void chooseTypeNft({required int index}) {
    bool result = false;
    if (listChangeColorFtChoose[index]) {
      result = false;
    } else {
      result = true;
    }
    listChangeColorFtChoose = List.filled(6, false);
    listChangeColorFtChoose[index] = result;
    listChangeColorFtChooseBHVSJ.sink.add(listChangeColorFtChoose);
  }


  BehaviorSubject<List<HardNftTypeModel>> listHardNftTypeBHVSJ =
      BehaviorSubject();
  BehaviorSubject<List<Map<String, dynamic>>> countriesBHVSJ =
      BehaviorSubject();
  BehaviorSubject<List<Map<String, dynamic>>> phonesCodeBHVSJ =
      BehaviorSubject();
  BehaviorSubject<List<Map<String, dynamic>>> citiesBHVSJ = BehaviorSubject();
  BehaviorSubject<List<Map<String, dynamic>>> conditionBHVSJ =
      BehaviorSubject();
  BehaviorSubject<List<Map<String, dynamic>>> collectionsBHVSJ =
      BehaviorSubject();

  ///Control upload Image, Document
  BehaviorSubject<List<String>> listImagePathSubject = BehaviorSubject();
  BehaviorSubject<String> currentImagePathSubject = BehaviorSubject();
  BehaviorSubject<List<String>> listDocumentPathSubject = BehaviorSubject();

  ///add Button subject
  BehaviorSubject<bool> enableButtonUploadImageSubject = BehaviorSubject();
  BehaviorSubject<bool> enableButtonUploadDocumentSubject = BehaviorSubject();

  final regexEmail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  void getAllApiExceptCity() {
    getTokenInf();
    getCountriesApi();
    getPhonesApi();
    getConditionsApi();
    getListHardNftTypeApi();
  }

  String? validateAdditionInfo(String value) {
    if (value.length > 255) {
      return S.current.validate_addition_info;
    } else {
      return null;
    }
  }

  String? validateAddress(String value) {
    if (value.isEmpty) {
      return S.current.address_required;
    } else {
      return null;
    }
  }

  String? validateHardNftName(String value) {
    if (value.isEmpty) {
      return S.current.name_required;
    }
    if (value.length > 255) {
      return S.current.maximum_255;
    } else {
      return null;
    }
  }

  String validateAmountToken(String value) {
    if (value.isEmpty) {
      return S.current.amount_required;
    } else if (!regexAmount.hasMatch(value)) {
      return S.current.invalid_amount;
    } else {
      return '';
    }
  }

  String validateFormAddProperty(String value) {
    if (value.length > 30) {
      return S.current.maximum_30;
    } else {
      return '';
    }
  }

  String? validateMobile(String value) {
    const String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    final RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return S.current.phone_required;
    } else if (!regExp.hasMatch(value)) {
      return S.current.invalid_phone;
    }
    return null;
  }

  String validateEmail(String value) {
    if (!regexEmail.hasMatch(value)) {
      return S.current.invalid_email;
    } else {
      return '';
    }
  }

  BehaviorSubject<bool> changeColorWhenSelect = BehaviorSubject.seeded(false);

  Future<void> getListHardNftTypeApi() async {
    final Result<List<HardNftTypeModel>> resultHardNftTypes =
        await _step1Repository.getHardNftTypes();
    resultHardNftTypes.when(
      success: (response) {
        for (final element in response) {
          listHardNftType.add(element);
        }
        listHardNftTypeBHVSJ.sink.add(listHardNftType);
      },
      error: (error) {
        listHardNftTypeBHVSJ.sink.add([]);
      },
    );
  }

  Future<void> getPhonesApi() async {
    final Result<List<PhoneCodeModel>> resultPhone =
        await _step1Repository.getPhoneCode();
    resultPhone.when(
      success: (res) {
        final temp = res.map((e) => e.code.toString()).toList().toSet();
        final listCode = temp.toList();
        final listId = listCode
            .map((e) => res.where((element) => element.code == e))
            .toList();
        for (final e in listCode) {
          phonesCode.add({
            'value': listId[listCode.indexOf(e)],
            'label': e,
          });
        }
        // for (final e in res) {
        //   phonesCode.add({
        //     'value': e.code ?? '',
        //     'label': e.id.toString(),
        //   });
        // }
        phonesCodeBHVSJ.sink.add(phonesCode);
        // phonesCodeBHVSJ.sink.add([]);
      },
      error: (error) {
        phonesCodeBHVSJ.sink.add([]);
      },
    );
  }

  List<TokenInf> listTokenSupport = [];

  List<Map<String, dynamic>> tokensMap = [];

  void getTokenInf() {
    final String listToken = PrefsService.getListTokenSupport();
    listTokenSupport = TokenInf.decode(listToken);
    for (final element in listTokenSupport) {
      tokensMap.add(
        {
          'label': element.symbol,
          'icon': SizedBox(
            width: 20.w,
            height: 20.h,
            child: Image.asset(
              ImageAssets.getSymbolAsset(
                element.symbol ?? DFY,
              ),
            ),
          ),
        },
      );
      if (tokensMap.isEmpty) {
        tokensMap.add(
          {
            'label': DFY,
            'icon': SizedBox(
              width: 20.w,
              height: 20.h,
              child: Image.asset(
                ImageAssets.getSymbolAsset(
                  element.symbol ?? DFY,
                ),
              ),
            ),
          },
        );
      }
    }
  }

  Future<void> getCountriesApi() async {
    //emit(Step1LoadingCountry());
    final Result<List<CountryModel>> resultCountries =
        await _step1Repository.getCountries();
    resultCountries.when(
      success: (res) {
        res.forEach(
          (e) =>
              countries.add({'value': e.id.toString(), 'label': e.name ?? ''}),
        );
        countriesBHVSJ.sink.add(countries);
      },
      error: (error) {
        countriesBHVSJ.sink.add([]);
      },
    );
  }

  Future<void> getConditionsApi() async {
    final Result<List<ConditionModel>> resultConditions =
        await _step1Repository.getConditions();

    resultConditions.when(
      success: (res) {
        for (final element in res) {
          conditions.add({
            'value': element.id.toString(),
            'label': element.name ?? '',
          });
        }
        conditionBHVSJ.sink.add(conditions);
      },
      error: (error) {
        conditionBHVSJ.sink.add([]);
      },
    );
  }

  String getAddressWallet() {
    return PrefsService.getCurrentBEWallet();
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

  void navigatorToConfirmInfo() {
    emit(ProvideHardNftConfirmInfo());
  }

  List<Map<String, dynamic>> loadingDataDropDown = [
    {'label': 'loading'},
  ];

  List<Map<String, dynamic>> errorData = [
    {'label': 'error'},
  ];

  bool checkMapListContainsObj({
    required List<Map<String, dynamic>> mapList,
    required String valueNeedCheck,
  }) {
    for (final map in mapList) {
      if (map.containsKey('label')) {
        if (map['label'] == valueNeedCheck) {
          return true;
        }
      }
    }
    return false;
  }

  Future<void> getCitiesApi(dynamic id) async {
    cities.clear();
    cities.add({'label': 'loading'});
    citiesBHVSJ.sink.add(cities);
    final Result<List<CityModel>> resultCities =
        await _step1Repository.getCities(id.toString());
    cities.clear();
    resultCities.when(
      success: (response) {
        for (final element in response) {
          cities.add({
            'value': element.id,
            'label': element.name,
          });
        }
        if (cities.isNotEmpty) {
          citiesBHVSJ.sink.add(cities);
        } else {
          cities.add({'label': 'none'});
          citiesBHVSJ.sink.add(cities);
        }
      },
      error: (error) {
        cities.add({'label': 'error'});
        citiesBHVSJ.sink.add(cities);
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

  List<DocumentModel> documents = [
    DocumentModel('Giay phep kinh doanh', 'pdf'),
    DocumentModel('Giay phep Su dung', 'doc'),
  ];

  Step1PassingModel fakeData = Step1PassingModel(
    hardNftName: 'Sapphire ring',
    imageToken: ImageAssets.ic_dfy,
    nameContact: 'Nguyen Duc Hoa',
    emailContact: 'john_hoahihung@gmail.com',
    phoneContact: '(+84) 0123456789',
    addressContact: 'So 9, ngo 4 Duy Tan, Cau Giay',
    wallet:
        'Wallet 0xcd...1029 will receive NFT after being minted by Evaluator. ',
    collection: 'Hard NFT will be created in collection Collection of HoaND',
    properties: [
      PropertyModel(value: 'oo', property: 'ee'),
    ],
    informationNft:
        'Habitasse molestie ullamcorper consequat lectus. Dignissim ut ut neque, et venenatis. Suspendisse morbi ac dignissim in est.',
    amountToken: 500000,
    symbolToken: 'DFY',
    nameNftType: 'Jewelry',
    conditionNft: 'Brand new',
    documents: [
      DocumentModel('giay phep', 'ok'),
    ],
  );
}

class DocumentModel {
  final String title;
  final String typeFile;

  DocumentModel(this.title, this.typeFile);
}

class Step1PassingModel {
  final String hardNftName;
  final String nameContact;
  final String emailContact;
  final String phoneContact;
  final String addressContact;
  final String wallet;
  final String collection;
  final List<PropertyModel> properties;
  final String informationNft;
  final double amountToken;
  final String symbolToken;
  final String nameNftType;
  final String conditionNft;
  final String imageToken;
  final List<DocumentModel> documents;

  Step1PassingModel({
    required this.hardNftName,
    required this.imageToken,
    required this.nameContact,
    required this.emailContact,
    required this.phoneContact,
    required this.addressContact,
    required this.wallet,
    required this.collection,
    required this.properties,
    required this.informationNft,
    required this.amountToken,
    required this.symbolToken,
    required this.nameNftType,
    required this.conditionNft,
    required this.documents,
  });
}
