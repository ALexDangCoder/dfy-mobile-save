import 'dart:async';

import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/model/market_place/category_model.dart';
import 'package:Dfy/domain/repository/market_place/category_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/create_collection/ui/create_collection_screen.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class CreateCollectionBloc {
  TypeNFT createType = TypeNFT.NONE;

  String collectionName = '';
  String customUrl = '';
  String description = '';
  String featureCid = '';
  String faceBook = '';
  String twitter = '';
  String instagram = '';
  String telegram = '';
  int royalties = 0;

  String categoryName = '';
  String categoryId = '';

  Map<String, bool> mapCheck = {
    'cover_photo': true,
    'avatar_photo': true,
    'feature_photo': true,
    'collection_name': false,
    'custom_url': true,
    'description': false,
    'categories': false,
    'royalties': true,
    'facebook': true,
    'twitter': true,
    'instagram': true,
    'telegram': true,
  };

  CategoryRepository get _categoryRepository => Get.find();

  //Stream
  ///Type NFT
  final BehaviorSubject<TypeNFT> _typeNFTSubject = BehaviorSubject();

  Stream<TypeNFT> get typeNFTStream => _typeNFTSubject.stream;

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

  ///Send Category
  BehaviorSubject<List<DropdownMenuItem<String>>> listCategorySubject =
      BehaviorSubject();

  //func
  void changeSelectedItem(TypeNFT type) {
    createType = type;
    _typeNFTSubject.sink.add(createType);
  }

  void validateCreate() {
    if (mapCheck['cover_photo'] == false ||
        mapCheck['avatar_photo'] == false ||
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
          validateName(mess);
          break;
        }
      case 'url':
        {
          validateURL(mess);
          break;
        }
      case 'des':
        {
          validateDes(mess);
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
          validateFacebook(mess);
          break;
        }
      case 'twitter':
        {
          validateTwitter(mess);
          break;
        }
      case 'instagram':
        {
          validateInstagram(mess);
          break;
        }
      case 'telegram':
        {
          validateTelegram(mess);
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
        hintText != 'app.defiforyou/uk/marketplace/....') {
      return '$hintText can not be empty';
    } else if (hintText == S.current.royalties) {
      if (value.isEmpty) {
        return '';
      } else {
        try {
          if (int.parse(value) > 50) {
            return S.current.max_royalty;
          } else {
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

  void validateName(String mess) {
    nameCollectionSubject.sink.add(mess);
    if (mess.isEmpty) {
      mapCheck['collection_name'] = true;
    } else {
      mapCheck['collection_name'] = false;
    }
  }

  void validateURL(String mess) {
    customURLSubject.sink.add(mess);
    if (mess.isEmpty) {
      mapCheck['custom_url'] = true;
    } else {
      mapCheck['custom_url'] = false;
    }
  }

  void validateDes(String mess) {
    descriptionSubject.sink.add(mess);
    if (mess.isEmpty) {
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

  void validateFacebook(String mess) {
    facebookSubject.sink.add(mess);
    if (mess.isEmpty) {
      mapCheck['facebook'] = true;
    } else {
      mapCheck['facebook'] = false;
    }
  }

  void validateTwitter(String mess) {
    twitterSubject.sink.add(mess);
    if (mess.isEmpty) {
      mapCheck['twitter'] = true;
    } else {
      mapCheck['twitter'] = false;
    }
  }

  void validateInstagram(String mess) {
    instagramSubject.sink.add(mess);
    if (mess.isEmpty) {
      mapCheck['instagram'] = true;
    } else {
      mapCheck['instagram'] = false;
    }
  }

  void validateTelegram(String mess) {
    telegramSubject.sink.add(mess);
    if (mess.isEmpty) {
      mapCheck['telegram'] = true;
    } else {
      mapCheck['telegram'] = false;
    }
  }

  void validateCategory(String mess) {
    categoriesSubject.sink.add(mess);
    if (mess.isEmpty) {
      mapCheck['categories'] = true;
    } else {
      mapCheck['categories'] = false;
    }
  }

  Future<void> setCategory(String id) async {
    categoryId = id;
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

  /// get list category
  Future<void> getListCategory() async {
    List<DropdownMenuItem<String>> menuItems = [];
    final Result<List<Category>> result =
        await _categoryRepository.getListCategory();
    result.when(
      success: (res) {
        menuItems = res
            .map(
              (e) => DropdownMenuItem(
                value: e.id ?? '',
                child: Text(e.name ?? ''),
              ),
            )
            .toList();
      },
      error: (error) {},
    );
    listCategorySubject.sink.add(menuItems);
  }
}
