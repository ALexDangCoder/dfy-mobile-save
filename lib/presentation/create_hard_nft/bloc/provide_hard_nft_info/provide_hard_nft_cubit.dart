import 'dart:core';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/config/base/base_state.dart';
import 'package:Dfy/data/request/create_hard_nft/create_hard_nft_assets_request.dart';
import 'package:Dfy/data/request/create_hard_nft/create_hard_nft_ipfs_request.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/city_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/condition_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/country_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/hard_nft_type_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/phone_code_model.dart';
import 'package:Dfy/domain/model/market_place/collection_market_model.dart';
import 'package:Dfy/domain/model/market_place/detail_asset_hard_nft.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/repository/hard_nft_my_account/step1/step1_repository.dart';
import 'package:Dfy/domain/repository/market_place/collection_detail_repository.dart';
import 'package:Dfy/domain/repository/market_place/create_hard_nft_repository.dart';
import 'package:Dfy/domain/repository/pinata/pinata_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/create_book_evalution/bloc/bloc_create_book_evaluation.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/upload_ipfs/pin_to_ipfs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  final regexAmount = RegExp(r'^\d+((.)|(.\d{0,5})?)$');

  BehaviorSubject<bool> visibleDropDownCountry = BehaviorSubject();

  // BehaviorSubject<bool> showItemProperties = BehaviorSubject();
  BehaviorSubject<List<PropertyModel>> showItemProperties = BehaviorSubject();

  ///Di
  Step1Repository get _step1Repository => Get.find();
  CreateHardNFTRepository get _createHardNFTRepository => Get.find();

  CollectionDetailRepository get _collectionDetailRepository => Get.find();

  final PinToIPFS _pinToIPFS = PinToIPFS();

  final List<DocumentFeatMediaListRequest> documentsRequest = [];
  final List<DocumentFeatMediaListRequest> mediasRequest = [];

  List<CollectionMarketModel> listHardCl = [];

  Future<void> postFileMediaFeatDocumentApi() async {
    final listCidMedia = [];
    final listCidDocument = [];
    for (final e in listPathImage) {
      final cid = await _pinToIPFS.pinFileToIPFS(pathFile: e);
      if (cid.isNotEmpty) {
        mediasRequest.add(
          DocumentFeatMediaListRequest(
            name: 'fakeImage',
            type: 'image/jpeg',
            cid: cid,
          ),
        );
        listCidMedia.add(cid);
      }
    }
    for (final e in listPathDocument) {
      final cid = await _pinToIPFS.pinFileToIPFS(pathFile: e);
      if (cid.isNotEmpty) {
        documentsRequest.add(
          DocumentFeatMediaListRequest(
            name: 'fakeDoc',
            type: 'application/pdf',
            cid: cid,
          ),
        );
        listCidDocument.add(cid);
      }
    }
    convertPropertiesToAdditionalInfo();
    final hardNftIpfs = CreateHardNftIpfsRequest(
      name: dataStep1.hardNftName,
      additional_info_list: listAddtional,
      additional_information: dataStep1.additionalInfo,
      contact_email: dataStep1.emailContact,
      contact_address: dataStep1.addressContact,
      contact_name: dataStep1.nameContact,
      expecting_price: dataStep1.amountToken,
      expecting_price_symbol: dataStep1.tokenInfo.symbol,
      contact_phone: dataStep1.phoneContact.trim().substring(1),
      document_list: documentsRequest,
      collection_address: dataStep1.addressCollection,
      asset_type_id: dataStep1.hardNftType.id,
      bc_txn_hash: '',
      condition_id: dataStep1.conditionNft.id,
      contact_city_id: dataStep1.city.id,
      contact_country_id: dataStep1.city.countryID.toString(),
      contact_phone_code_id: dataStep1.phoneCodeModel.id.toString(),
      media_list: mediasRequest,
    );
    final ipfsHash = await _pinToIPFS.pinJsonToIPFS(
      type: PinJsonType.HARD_NFT,
      hardNftRequest: hardNftIpfs,
    );
    final requestAsset = CreateHardNftAssetsRequest(
      additional_info_list: listAddtional,
      additional_information: dataStep1.additionalInfo,
      name: dataStep1.hardNftName,
      asset_type_id: dataStep1.hardNftType.id,
      condition_id: dataStep1.conditionNft.id,
      contact_address: dataStep1.addressContact,
      contact_city_id: dataStep1.city.id,
      contact_country_id: dataStep1.city.countryID.toString(),
      contact_email: dataStep1.emailContact,
      contact_name: dataStep1.nameContact,
      contact_phone: dataStep1.phoneContact.trim().substring(1),
      contact_phone_code_id: dataStep1.phoneCodeModel.id.toString(),
      document_list: documentsRequest,
      expecting_price: dataStep1.amountToken,
      expecting_price_symbol: dataStep1.tokenInfo.symbol,
      media_list: mediasRequest,
      bc_txn_hash: '',
      asset_cid: ipfsHash,
      collection_id: dataStep1.collectionID,
    );
    final resultAsset = await _step1Repository.getAssetAfterPost(requestAsset);
    resultAsset.when(
      success: (res) {
        if(res == null) {

        } else {
          assetId = res.id ?? '';
          getDetailAssetHardNFT(assetId: assetId);
        }
      },
      error: (error) {},
    );
  }

  String assetId = '';

  ///
  Future<void> getDetailAssetHardNFT({
    required String assetId,
  }) async {
    final Result<DetailAssetHardNft> result =
    await _createHardNFTRepository.getDetailAssetHardNFT(
      assetId,
    );
    result.when(
      success: (res) {
        if(res == null) {
        } else {
          assetCid = res.assetCid ?? '';
          beAssetId = assetId;
          expectingPrice = res.expectingPrice?.toString() ?? '';
          expectingPriceAddress = '0x20f1dE452e9057fe863b99d33CF82DBeE0C45B14';
          collectionStandard = res.collection?.collectionType?.standard ?? 0;
          collectionAsset = res.collection?.walletAddress ?? '';
        }
      },
      error: (error) {},
    );
  }

  String assetCid = '';
  String collectionAsset = '';
  String expectingPrice = '';
  String expectingPriceAddress = '';
  int? collectionStandard;
  String beAssetId = '';

  Future<String> getHexStringFromWeb3() async {
    final result = await Web3Utils().getCreateAssetRequestData(
      assetCID: assetCid,
      collectionAsset: collectionAsset,
      expectingPrice: dataStep1.amountToken.toString(),
      expectingPriceAddress: expectingPriceAddress,
      collectionStandard: collectionStandard ?? 0,
      beAssetId: beAssetId,
    );
    return result;
  }

  //todo phân loại file type khi upload
  void categoryDocumentsFtMediaByType() {}

  final List<AdditionalInfoListRequest> listAddtional = [];

  void convertPropertiesToAdditionalInfo() {
    for (final element in dataStep1.properties) {
      listAddtional.add(
        AdditionalInfoListRequest(
          trait_type: element.property,
          value: element.value,
        ),
      );
    }
  }

  bool inputFormValidate = false;

  ///api
  ///convert to map to use in cool dropdown
  List<Map<String, dynamic>> phonesCode = [];
  List<Map<String, dynamic>> countries = [];
  List<Map<String, dynamic>> cities = [];
  List<Map<String, dynamic>> conditions = [];
  List<PropertyModel> propertiesData = [];

  ///List path image
  List<String> listPathImage = [];
  List<String> listPathDocument = [];
  String currentImagePath = '';
  int currentIndexImage = 0;
  List<HardNftTypeModel> listHardNftType = [];

  List<bool> listChangeColorFtChoose = [
    true,
    false,
    false,
    false,
    false,
    false,
  ];

  BehaviorSubject<List<bool>> listChangeColorFtChooseBHVSJ =
      BehaviorSubject.seeded([
    true,
    false,
    false,
    false,
    false,
    false,
  ]);

  ///id is index
  void chooseTypeNft({required int index}) {
    listChangeColorFtChoose = List.filled(6, false);
    listChangeColorFtChoose[index] = true;
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

  ///value get by user submmit

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
    } else if (value.length > 255) {
      return S.current.maximum_255;
    } else {
      return null;
    }
  }

  String? validateAmountToken(String value) {
    if (value.isEmpty) {
      return S.current.amount_required;
    } else if (!regexAmount.hasMatch(value)) {
      return S.current.invalid_amount;
    } else {
      return null;
    }
  }

  String? validateFormAddProperty(String value) {
    if (value.length > 30) {
      return S.current.maximum_30;
    } else {
      return null;
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

  String? validateEmail(String value) {
    if (!regexEmail.hasMatch(value)) {
      return S.current.invalid_email;
    } else {
      return null;
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
        // final temp = res.map((e) => e.code.toString()).toList().toSet().toList();
        // final listId = temp
        //     .map((e) => res.where((element) => element.code == e))
        //     .toList();
        for (final e in res) {
          phonesCode.add({
            // 'value': listId[temp.indexOf(e)],
            'code': e.code,
            'id': e.id,
            'label': e.name,
          });
        }

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

  String checkConnectWL = '';

  bool checkConnectWallet() {
    if (checkConnectWL.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  String resultCurrentBeWallet() {
    return checkConnectWL = PrefsService.getCurrentBEWallet();
  }

  void getTokenInf() {
    final String listToken = PrefsService.getListTokenSupport();
    listTokenSupport = TokenInf.decode(listToken);
    for (final element in listTokenSupport) {
      if (element.symbol == 'USDT' ||
          element.symbol == 'BNB' ||
          element.symbol == 'DFY') {
        tokensMap.add(
          {
            'value': element.id,
            'label': element.symbol,
            'symbol': element.symbol ?? DFY,
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
    final Result<List<CountryModel>> resultCountries =
        await _step1Repository.getCountries();
    resultCountries.when(
      success: (res) {
        for (final e in res) {
          countries.add({'value': e.id.toString(), 'label': e.name ?? ''});
        }
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
        listDropDown.add(
          {
            'label': 'COLLECTION 721',
            'value': ADDRESS_COLLECTION_721,
            'id': ID_COLLECTION_721,
          },
        );
        listDropDown.add(
          {
            'label': 'COLLECTION 1155',
            'value': ADDRESS_COLLECTION_1155,
            'id': ID_COLLECTION_1155,
          },
        );
        collectionsBHVSJ.sink.add(listDropDown);
      },
      error: (_) {},
    );
  }

  String getCollectionID(String value) {
    final _collectionAddress = value;
    final collectionId = listHardCl
            .where((element) => element.addressCollection == _collectionAddress)
            .toList()
            .first
            .collectionId ??
        '';
    return collectionId;
  }

  void navigatorToConfirmInfo() {}

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

  void checkAllValidate() {
    if (inputFormValidate) {
      nextBtnBHVSJ.sink.add(true);
    } else {
      nextBtnBHVSJ.sink.add(false);
    }
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
            'latitude': element.latitude,
            'longitude': element.longitude,
            'countryID': element.countryID,
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
    for (final _ in propertiesData) {
      propertiesData.removeWhere(
        (element) => element.property.isEmpty || element.value.isEmpty,
      );
    }
    if (propertiesData.isEmpty) {
      showItemProperties.sink.add([]);
    } else {
      showItemProperties.sink.add(propertiesData);
    }
  }

  Map<String, bool> mapValidate = {
    'mediaFiles': true,
    'inputForm': false,
    'condition': false,
    'country': false,
    'city': false,
    'phone': false,
  };

  void validateAll() {
    print('validateeee ${mapValidate}');
    if (mapValidate.containsValue(false)) {
      nextBtnBHVSJ.sink.add(false);
    } else {
      nextBtnBHVSJ.sink.add(true);
    }
  }

  BehaviorSubject<bool> nextBtnBHVSJ = BehaviorSubject.seeded(false);

  bool validateAllDataBeforeSubmit() {
    if ((dataStep1.conditionNft.name ?? '').isEmpty ||
        dataStep1.amountToken == 0 ||
        dataStep1.nameContact.isEmpty ||
        dataStep1.phoneContact.isEmpty ||
        (dataStep1.country.name ?? '').isEmpty ||
        (dataStep1.city.name ?? '').isEmpty ||
        dataStep1.addressContact.isEmpty) {
      nextBtnBHVSJ.sink.add(true);
      return true;
    } else {
      nextBtnBHVSJ.sink.add(false);
      return false;
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

  void createModel() {
    dataStep1.mediaFiles = listPathImage;
    dataStep1.documents = listPathDocument;
  }

  List<DocumentModel> documents = [
    DocumentModel('Giay phep kinh doanh', 'pdf'),
    DocumentModel('Giay phep Su dung', 'doc'),
  ];

  Step1PassingModel dataStep1 = Step1PassingModel(
    hardNftName: '',
    tokenInfo: TokenInf(id: 1, symbol: 'DFY'),
    nameContact: '',
    emailContact: '',
    phoneContact: '',
    city: CityModel(),
    addressContact: '',
    phoneCodeModel: PhoneCodeModel(),
    country: CountryModel(),
    wallet: '',
    collection: '',
    properties: [],
    amountToken: 0,
    nameNftType: '',
    conditionNft: ConditionModel(),
    documents: [],
    additionalInfo: '',
    hardNftType: HardNftTypeModel(
      id: 0,
      name: S.current.jewelry,
    ),
    mediaFiles: [],
    addressCollection: '',
    collectionID: '',
  );
}

class DocumentModel {
  final String title;
  final String typeFile;

  DocumentModel(this.title, this.typeFile);
}

class Step1PassingModel {
  String addressCollection;
  String hardNftName;
  String collectionID;
  String nameContact;
  String emailContact;
  CountryModel country;
  String phoneContact;
  String addressContact;
  String wallet;
  String collection;
  String additionalInfo;
  List<PropertyModel> properties;
  double amountToken;
  TokenInf tokenInfo;
  String nameNftType;
  ConditionModel conditionNft;
  List<String> documents;
  List<String> mediaFiles;
  HardNftTypeModel hardNftType;
  PhoneCodeModel phoneCodeModel;
  CityModel city;

  Step1PassingModel({
    required this.hardNftName,
    required this.mediaFiles,
    required this.phoneCodeModel,
    required this.hardNftType,
    required this.collectionID,
    required this.addressCollection,
    required this.city,
    required this.nameContact,
    required this.country,
    required this.additionalInfo,
    required this.emailContact,
    required this.phoneContact,
    required this.addressContact,
    required this.wallet,
    required this.collection,
    required this.properties,
    required this.amountToken,
    required this.tokenInfo,
    required this.nameNftType,
    required this.conditionNft,
    required this.documents,
  });
}
