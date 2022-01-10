import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/model/market_place/category_model.dart';
import 'package:Dfy/domain/model/market_place/type_nft_model.dart';
import 'package:Dfy/domain/repository/market_place/category_repository.dart';
import 'package:Dfy/domain/repository/nft_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class CreateCollectionBloc {
  String createType = '';
  int collectionType = -1;

  String collectionName = '';
  String customUrl = '';
  String description = '';
  String faceBook = '';
  String twitter = '';
  String instagram = '';
  String telegram = '';
  int royalties = 0;

  List<Category> listCategory = [];

  List<TypeNFTModel> listNFT = [];
  List<TypeNFTModel> listHardNFT = [];
  List<TypeNFTModel> listSoftNFT = [];

  String categoryId = '';
  String avatarPath = '';
  String coverPhotoPath = '';
  String featurePhotoPath = '';

  File? avatar;
  File? coverPhoto;
  File? featurePhoto;

  ///Default value of validate field
  Map<String, bool> mapCheck = {
    'cover_photo': false,
    'avatar': false,
    'feature_photo': false,
    'collection_name': false,
    'custom_url': true,
    'description': true,
    'categories': false,
    'royalties': true,
    'facebook': true,
    'twitter': true,
    'instagram': true,
    'telegram': true,
  };

  NFTRepository get _nftRepo => Get.find();

  CategoryRepository get _categoryRepository => Get.find();

  //Stream
  ///Type NFT
  final BehaviorSubject<String> _typeNFTSubject = BehaviorSubject();

  Stream<String> get typeNFTStream => _typeNFTSubject.stream;

  ///CreateButton
  final BehaviorSubject<bool> _enableCreateSubject = BehaviorSubject();

  Stream<bool> get enableCreateStream => _enableCreateSubject.stream;

  ///Validate TextField
  BehaviorSubject<String> nameCollectionSubject = BehaviorSubject();
  BehaviorSubject<String> customURLSubject = BehaviorSubject();
  BehaviorSubject<String> descriptionSubject = BehaviorSubject();
  BehaviorSubject<String> categoriesSubject = BehaviorSubject();
  BehaviorSubject<String> royaltySubject = BehaviorSubject();
  BehaviorSubject<String> facebookSubject = BehaviorSubject();
  BehaviorSubject<String> twitterSubject = BehaviorSubject();
  BehaviorSubject<String> instagramSubject = BehaviorSubject();
  BehaviorSubject<String> telegramSubject = BehaviorSubject();

  ///Validate Image
  BehaviorSubject<String> avatarMessSubject = BehaviorSubject();
  BehaviorSubject<String> coverPhotoMessSubject = BehaviorSubject();
  BehaviorSubject<String> featurePhotoMessSubject = BehaviorSubject();

  ///SendImage
  BehaviorSubject<File> avatarSubject = BehaviorSubject();
  BehaviorSubject<File> coverPhotoSubject = BehaviorSubject();
  BehaviorSubject<File> featurePhotoSubject = BehaviorSubject();

  ///Image Upload progress
  BehaviorSubject<int> avatarUploadStatusSubject = BehaviorSubject();
  BehaviorSubject<int> coverPhotoUploadStatusSubject = BehaviorSubject();
  BehaviorSubject<int> featurePhotoUploadStatusSubject = BehaviorSubject();

  ///Send Category
  BehaviorSubject<List<Map<String, String>>> listCategorySubject =
      BehaviorSubject();

  ///Send TypeNFT
  BehaviorSubject<List<TypeNFTModel>> listHardNFTSubject = BehaviorSubject();
  BehaviorSubject<List<TypeNFTModel>> listSoftNFTSubject = BehaviorSubject();

  //func
  void changeSelectedItem(String type) {
    createType = type;
    _typeNFTSubject.sink.add(createType);
  }

  void validateCreate() {
    if (mapCheck['cover_photo'] == false ||
        mapCheck['avatar'] == false ||
        mapCheck['feature_photo'] == false ||
        mapCheck['collection_name'] == false ||
        mapCheck['custom_url'] == false ||
        mapCheck['description'] == false ||
        mapCheck['categories'] == false ||
        mapCheck['royalties'] == false ||
        mapCheck['facebook'] == false ||
        mapCheck['twitter'] == false ||
        mapCheck['instagram'] == false ||
        mapCheck['telegram'] == false) {
      _enableCreateSubject.sink.add(false);
    } else {
      _enableCreateSubject.sink.add(true);
    }
  }

  void validateCase({
    required String hintText,
    required String value,
    required String inputCase,
  }) {
    final mess = validateText(value: value, hintText: hintText);
    switch (inputCase) {
      case 'name':
        {
          validateName(mess, value);
          break;
        }
      case 'url':
        {
          validateURL(mess, value);
          break;
        }
      case 'des':
        {
          validateDes(mess, value);
          break;
        }
      case 'category':
        {
          validateCategory(mess);
          break;
        }
      case 'royalty':
        {
          validateRoyalty(mess);
          break;
        }
      case 'facebook':
        {
          validateFacebook(mess, value);
          break;
        }
      case 'twitter':
        {
          validateTwitter(mess, value);
          break;
        }
      case 'instagram':
        {
          validateInstagram(mess, value);
          break;
        }
      case 'telegram':
        {
          validateTelegram(mess, value);
          break;
        }
      default:
        {
          break;
        }
    }
    validateCreate();
  }

  String validateText({required String value, required String hintText}) {
    if (value.isEmpty &&
        hintText != 'Facebook' &&
        hintText != 'Twitter' &&
        hintText != 'Instagram' &&
        hintText != 'Telegram' &&
        hintText != S.current.royalties &&
        hintText != 'app.defiforyou/uk/marketplace/....' &&
        hintText != S.current.description) {
      return S.current.collection_name_require;
    } else if (hintText == S.current.royalties) {
      if (value.isEmpty) {
        royalties = 0;
        return '';
      } else {
        try {
          final int tempInt = int.parse(value);
          if (tempInt > 50) {
            return S.current.max_royalty;
          } else {
            royalties = tempInt;
            return '';
          }
        } catch (e) {
          return S.current.only_digits;
        }
      }
    } else if (value.length > 255) {
      return S.current.maximum_len;
    } else {
      return '';
    }
  }

  void validateName(String mess, String value) {
    nameCollectionSubject.sink.add(mess);
    if (mess.isEmpty) {
      collectionName = value;
      mapCheck['collection_name'] = true;
    } else {
      mapCheck['collection_name'] = false;
    }
  }

  void validateURL(String mess, String value) {
    customURLSubject.sink.add(mess);
    if (mess.isEmpty) {
      customUrl = value;
      mapCheck['custom_url'] = true;
    } else {
      mapCheck['custom_url'] = false;
    }
  }

  void validateDes(String mess, String value) {
    descriptionSubject.sink.add(mess);
    if (mess.isEmpty) {
      description = value;
      mapCheck['description'] = true;
    } else {
      mapCheck['description'] = false;
    }
  }

  void validateRoyalty(String mess) {
    royaltySubject.sink.add(mess);
    if (mess.isEmpty) {
      mapCheck['royalties'] = true;
    } else {
      mapCheck['royalties'] = false;
    }
  }

  void validateFacebook(String mess, String value) {
    facebookSubject.sink.add(mess);
    if (mess.isEmpty) {
      faceBook = value;
      mapCheck['facebook'] = true;
    } else {
      mapCheck['facebook'] = false;
    }
  }

  void validateTwitter(String mess, String value) {
    twitterSubject.sink.add(mess);
    if (mess.isEmpty) {
      twitter = value;
      mapCheck['twitter'] = true;
    } else {
      mapCheck['twitter'] = false;
    }
  }

  void validateInstagram(String mess, String value) {
    instagramSubject.sink.add(mess);
    if (mess.isEmpty) {
      instagram = value;
      mapCheck['instagram'] = true;
    } else {
      mapCheck['instagram'] = false;
    }
  }

  void validateTelegram(String mess, String value) {
    telegramSubject.sink.add(mess);
    if (mess.isEmpty) {
      telegram = value;
      mapCheck['telegram'] = true;
    } else {
      mapCheck['telegram'] = false;
    }
  }

  void validateCategory(String value) {
    if (value.isNotEmpty) {
      categoryId = value;
      mapCheck['categories'] = true;
    } else {
      categoriesSubject.sink.add(S.current.category_require);
      mapCheck['categories'] = false;
    }
  }

  ///validate custom URL
  Timer? debounceTime;
  RegExp reg = RegExp(r'^[a-z0-9_]+$');

  Future<void> validateCustomURL(String _customUrl) async {
    if (debounceTime != null) {
      if (debounceTime!.isActive) {
        debounceTime!.cancel();
      }
    }
    if (_customUrl.isNotEmpty) {
      if (_customUrl.length > 255) {
        customURLSubject.sink.add(S.current.maximum_len);
      } else if (reg.hasMatch(_customUrl)) {
        customURLSubject.sink.add('');
        debounceTime = Timer(
          const Duration(milliseconds: 500),
          () async {
            final appConstants = Get.find<AppConstants>();
            final String uri = appConstants.baseUrl +
                ApiConstants.GET_BOOL_CUSTOM_URL +
                _customUrl;
            final response = await http.get(
              Uri.parse(uri),
            );
            if (response.statusCode == 200) {
              if (response.body == 'true') {
                mapCheck['custom_url'] = true;
              } else {
                customURLSubject.sink.add('LOI ME MAY ROI');
                mapCheck['custom_url'] = false;
              }
            } else {
              throw Exception('Get response fail');
            }
          },
        );
      } else {
        customURLSubject.sink.add('NOT TRUE');
      }
    } else {
      mapCheck['custom_url'] = true;
      customURLSubject.sink.add('');
    }
  }

  void loadImage({
    required String type,
    required double imageSizeInMB,
    required String imagePath,
    required File image,
  }) {
    switch (type) {
      case 'avatar':
        {
          if (imageSizeInMB > 15) {
            mapCheck['avatar'] = false;
            avatarMessSubject.sink.add(S.current.maximum_size);
            break;
          } else {
            mapCheck['avatar'] = true;
            avatarMessSubject.sink.add('');
            avatarSubject.sink.add(image);
            avatarPath = imagePath;
            avatar = image;
            break;
          }
        }
      case 'cover_photo':
        {
          if (imageSizeInMB > 15) {
            mapCheck['cover_photo'] = false;
            coverPhotoMessSubject.sink.add(S.current.maximum_size);
            break;
          } else {
            mapCheck['cover_photo'] = true;
            coverPhotoMessSubject.sink.add('');
            coverPhotoSubject.sink.add(image);
            coverPhotoPath = imagePath;
            coverPhoto = image;
            break;
          }
        }
      case 'feature_photo':
        {
          if (imageSizeInMB > 15) {
            mapCheck['feature_photo'] = false;
            featurePhotoMessSubject.sink.add(S.current.maximum_size);
            break;
          } else {
            mapCheck['feature_photo'] = true;
            featurePhotoMessSubject.sink.add('');
            featurePhotoSubject.sink.add(image);
            featurePhotoPath = imagePath;
            featurePhoto = image;
            break;
          }
        }
      default:
        break;
    }
    validateCreate();
  }

  ///get List TypeNFT
  Future<void> getListTypeNFT() async {
    final Result<List<TypeNFTModel>> result = await _nftRepo.getListTypeNFT();
    result.when(
      success: (res) {
        listNFT = res;
        res.sort((a, b) => (a.standard ?? 0).compareTo(b.standard ?? 0));
        listSoftNFT = res.where((element) => element.type == 0).toList();
        listSoftNFTSubject.sink.add(listSoftNFT);
        listHardNFT = res.where((element) => element.type == 1).toList();
        listHardNFTSubject.sink.add(listHardNFT);
      },
      error: (error) {},
    );
  }

  void getStandardFromID(String id) {
    final st = listNFT.where((element) => element.id == id).first;
    collectionType = st.standard ?? 0;
  }

  /// get list category
  Future<void> getListCategory() async {
    List<Map<String, String>> menuItems = [];
    final Result<List<Category>> result =
        await _categoryRepository.getListCategory();
    result.when(
      success: (res) {
        listCategory = res;
        menuItems = res
            .map(
              (e) => {'label': e.name ?? '', 'value': e.id ?? ''},
            )
            .toList();
      },
      error: (error) {},
    );
    listCategorySubject.sink.add(menuItems);
  }

  ///Upload image IPFS
  Future<String> uploadImageToIPFS({
    required String bin,
  }) async {
    String ipfsHash = '';
    final headers = {
      'pinata_api_key': 'ac8828bff3bcd1c1b828',
      'pinata_secret_api_key':
          'cd1b0dc4478a40abd0b80e127e1184697f6d2f23ed3452326fe92ff3e92324df'
    };
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('https://api.pinata.cloud/pinning/pinFileToIPFS?file'),
    );
    request.files.add(await http.MultipartFile.fromPath('file', bin));
    request.headers.addAll(headers);
    try {
      final http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        final Map<String, dynamic> map =
            jsonDecode(await response.stream.bytesToString());
        ipfsHash = map['IpfsHash'];
      } else {
        log(response.reasonPhrase.toString());
      }
    } catch (e) {
      log(e.toString());
    }
    return ipfsHash;
  }

  ///Create list Social link from data
  List<Map<String, String>> createSocialMap() {
    final List<Map<String, String>> list = [];
    if (faceBook.isNotEmpty) {
      list.add({
        'type': 'facebook',
        'url': faceBook,
      });
    }
    if (instagram.isNotEmpty) {
      list.add({
        'type': 'instagram',
        'url': instagram,
      });
    }
    if (twitter.isNotEmpty) {
      list.add({
        'type': 'twitter',
        'url': twitter,
      });
    }
    if (telegram.isNotEmpty) {
      list.add({
        'type': 'telegram',
        'url': telegram,
      });
    }
    return list;
  }

  ///Create CID map
  Map<String,String> cidMap = {
    'avatar_cid' : '',
    'cover_cid' : '',
    'feature_cid' : '',
  };
  Future<void> cidCreate() async {
    coverPhotoUploadStatusSubject.sink.add(-1);
    final coverCid = await uploadImageToIPFS(bin: avatarPath);
    coverCid.isEmpty
        ? coverPhotoUploadStatusSubject.sink.add(0)
        : coverPhotoUploadStatusSubject.sink.add(1);
    avatarUploadStatusSubject.sink.add(-1);
    final avatarCid = await uploadImageToIPFS(bin: avatarPath);
    avatarCid.isEmpty
        ? avatarUploadStatusSubject.sink.add(0)
        : avatarUploadStatusSubject.sink.add(1);
    featurePhotoUploadStatusSubject.sink.add(-1);
    final featureCid = await uploadImageToIPFS(bin: avatarPath);
    featureCid.isEmpty
        ? featurePhotoUploadStatusSubject.sink.add(0)
        : featurePhotoUploadStatusSubject.sink.add(1);
    cidMap['cover_cid'] = coverCid;
    cidMap['avatar_cid'] = avatarCid;
    cidMap['feature_cid'] = featureCid;
  }


  ///Create Collection
  Future<void> createCollection() async {
    final List<Map<String, String>> socialLink = createSocialMap();
    final String standard = collectionType == 0 ? 'ERC-721' : 'ERC-1155';
    final Map<String, dynamic> sortParam = {
      'avatar_cid': cidMap['cover_cid'],
      'category_id': categoryId,
      'collection_standard': standard,
      'cover_cid': cidMap['cover_cid'],
      'custom_url': customUrl,
      'description': description,
      'feature_cid': cidMap['feature_cid'],
      'name': collectionName,
      'royalty': royalties,
      'social_links': socialLink,
      'txn_hash': 'txnHash',
    };
    log(sortParam.toString());
  }
}
