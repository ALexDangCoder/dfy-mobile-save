import 'dart:async';
import 'dart:io';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/model/market_place/category_model.dart';
import 'package:Dfy/domain/model/market_place/type_nft_model.dart';
import 'package:Dfy/domain/repository/market_place/category_repository.dart';
import 'package:Dfy/domain/repository/nft_repository.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/my_account/create_collection/bloc/extension/web3_create_collection.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/upload_ipfs/pin_file_to_ipfs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

part 'create_collection_state.dart';

class CreateCollectionCubit extends BaseCubit<CreateCollectionState> {
  CreateCollectionCubit() : super(CreateCollectionInitial());

  final Web3Utils web3utils = Web3Utils();

  String transactionData = '';

  String createId = '';
  int collectionStandard = ERC721;
  int collectionType = 0;

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
  String categoryName = '';
  String avatarPath = '';
  String coverPhotoPath = '';
  String featurePhotoPath = '';

  File? avatar;
  File? coverPhoto;
  File? featurePhoto;

  ///Social link map
  List<Map<String, String>> socialLinkMap = [];

  ///Image cid map
  Map<String, String> cidMap = {
    'avatar_cid': '',
    'cover_cid': '',
    'feature_cid': '',
  };

  ///IPFS of the collection send to Web3
  String collectionIPFS = '';

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

  CategoryRepository get categoryRepository => Get.find();

  //Stream
  ///Type NFT
  final BehaviorSubject<String> typeNFTSubject = BehaviorSubject();

  Stream<String> get typeNFTStream => typeNFTSubject.stream;

  ///CreateButton
  final BehaviorSubject<bool> enableCreateSubject = BehaviorSubject();

  Stream<bool> get enableCreateStream => enableCreateSubject.stream;

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

  ///Status upload image: -1 pending, 0 fail, 1 success
  BehaviorSubject<int> upLoadStatusSubject = BehaviorSubject();

  ///use to validate custom URL
  Timer? debounceTime;
  RegExp reg = RegExp(r'^[a-z0-9_]+$');

  //func
  void changeSelectedItem(String _id) {
    createId = _id;
    typeNFTSubject.sink.add(createId);
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
      enableCreateSubject.sink.add(false);
    } else {
      enableCreateSubject.sink.add(true);
    }
  }

  ///get List TypeNFT
  Future<void> getListTypeNFT() async {
    showLoading();
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
    showContent();
  }

  int getStandardFromID(String id) {
    final st = listNFT.where((element) => element.id == id).first;
    return st.standard ?? 0;
  }

  //type 0: soft, type 1: hard
  int getTypeFromID(String id) {
    final st = listNFT.where((element) => element.id == id).first;
    return st.type ?? 0;
  }

  /// get list category
  Future<void> getListCategory() async {
    List<Map<String, String>> menuItems = [];
    final Result<List<Category>> result =
        await categoryRepository.getListCategory();
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

  ///Create list Social link from data
  void createSocialMap() {
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
    socialLinkMap = list;
  }

  ///Create CID map
  Future<void> cidCreate(BuildContext context) async {
    upLoadStatusSubject.sink.add(-1);
    coverPhotoUploadStatusSubject.sink.add(-1);
    avatarUploadStatusSubject.sink.add(-1);
    featurePhotoUploadStatusSubject.sink.add(-1);

    final coverCid = await pinFileToIPFS(pathFile: avatarPath);
    coverCid.isEmpty
        ? coverPhotoUploadStatusSubject.sink.add(0)
        : coverPhotoUploadStatusSubject.sink.add(1);
    final avatarCid = await pinFileToIPFS(pathFile: avatarPath);
    avatarCid.isEmpty
        ? avatarUploadStatusSubject.sink.add(0)
        : avatarUploadStatusSubject.sink.add(1);
    final featureCid = await pinFileToIPFS(pathFile: avatarPath);
    featureCid.isEmpty
        ? featurePhotoUploadStatusSubject.sink.add(0)
        : featurePhotoUploadStatusSubject.sink.add(1);
    cidMap['cover_cid'] = coverCid;
    cidMap['avatar_cid'] = avatarCid;
    cidMap['feature_cid'] = featureCid;
    if (coverPhotoUploadStatusSubject.value == 0 ||
        avatarUploadStatusSubject.value == 0 ||
        featurePhotoUploadStatusSubject.value == 0) {
      upLoadStatusSubject.sink.add(0);
    } else {
      await sendDataWeb3(context);
      upLoadStatusSubject.sink.add(1);
    }
  }

  ///Create parameter Map
  Map<String, dynamic> getMapCreateCollection() {
    final String standard =
        collectionStandard == ERC721 ? 'ERC-721' : 'ERC-1155';
    if (collectionType == SOFT_COLLECTION) {
      return {
        'avatar_cid': cidMap['avatar_cid'],
        'category_id': categoryId,
        'collection_standard': standard,
        'cover_cid': cidMap['cover_cid'],
        'custom_url': customUrl,
        'description': description,
        'feature_cid': cidMap['feature_cid'],
        'name': collectionName,
        'royalty': royalties.toString(),
        'social_links': socialLinkMap,
        'txn_hash': 'txnHash',
      };
    } else {
      return {
        'avatar_cid': cidMap['avatar_cid'],
        'bc_txn_hash': 'txnHash',
        'category_id': categoryId,
        'category_name': categoryName,
        'collection_address': '',
        'collection_cid': collectionIPFS,
        'collection_type_id': 1,
        'custom_url': customUrl,
        'description': description,
        'name': collectionName,
        'social_links': socialLinkMap,
      };
    }
  }

  Future<void> getListWallets() async {
    try {
      await trustWalletChannel.invokeMethod('getListWallets', {});
    } on PlatformException {}
  }

  void dispose() {
    typeNFTSubject.close();
    enableCreateSubject.close();
    nameCollectionSubject.close();
    customURLSubject.close();
    descriptionSubject.close();
    categoriesSubject.close();
    royaltySubject.close();
    facebookSubject.close();
    twitterSubject.close();
    instagramSubject.close();
    telegramSubject.close();
    avatarMessSubject.close();
    coverPhotoMessSubject.close();
    featurePhotoMessSubject.close();
    avatarSubject.close();
    coverPhotoSubject.close();
    featurePhotoSubject.close();
    avatarUploadStatusSubject.close();
    coverPhotoUploadStatusSubject.close();
    featurePhotoUploadStatusSubject.close();
    listCategorySubject.close();
    listHardNFTSubject.close();
    listSoftNFTSubject.close();
    upLoadStatusSubject.close();
  }
}
