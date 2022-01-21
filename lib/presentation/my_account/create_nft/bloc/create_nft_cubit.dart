import 'dart:io';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/config/base/base_state.dart';
import 'package:Dfy/domain/model/market_place/collection_market_model.dart';
import 'package:Dfy/domain/model/market_place/type_nft_model.dart';
import 'package:Dfy/domain/repository/market_place/collection_detail_repository.dart';
import 'package:Dfy/domain/repository/nft_repository.dart';
import 'package:Dfy/presentation/my_account/create_nft/bloc/extension_create_nft/select_nft_type_screen.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:rxdart/rxdart.dart';
import 'package:video_player/video_player.dart';

part 'create_nft_state.dart';

class CreateNftCubit extends BaseCubit<CreateNftState> {
  CreateNftCubit() : super(CreateNftInitial()) {
    getListTypeNFT();
  }

  VideoPlayerController? controller;

  CollectionDetailRepository get collectionDetailRepository => Get.find();

  NFTRepository get nftRepo => Get.find();

  List<TypeNFTModel> listNft = [];
  List<TypeNFTModel> listSoftNft = [];
  List<TypeNFTModel> listHardNft = [];
  List<CollectionMarketModel> listCollectionModel = [];

  String selectedId = '';
  int selectedNftType = 0;
  String walletAddress = '';

  ///Detail NFT var
  String mediaType = '';
  String nftName = '';
  String collectionAddress = '';
  String description = '';
  int royalty = 0;

  ///mediaFilePath
  String mediaFilePath = '';
  String coverPhotoPath = '';

  ///Stream
  ///id of nft
  final BehaviorSubject<String> selectIdSubject = BehaviorSubject();

  ///Create NFT Button
  final BehaviorSubject<bool> createNftButtonSubject = BehaviorSubject();

  ///Media file
  final BehaviorSubject<String> mediaFileSubject = BehaviorSubject();
  final BehaviorSubject<String> imageFileSubject = BehaviorSubject();
  final BehaviorSubject<VideoPlayerController> videoFileSubject =
      BehaviorSubject();
  final BehaviorSubject<File> audioFileSubject = BehaviorSubject();
  final BehaviorSubject<String> coverPhotoSubject = BehaviorSubject();

  ///Error text image file size
  final BehaviorSubject<String> fileErrorTextSubject = BehaviorSubject();
  final BehaviorSubject<List<Map<String, dynamic>>> listCollectionSubject =
      BehaviorSubject();

  ///Error String
  final BehaviorSubject<String> collectionMessSubject = BehaviorSubject();

  Map<String, bool> createNftMapCheck = {
    'media_file': false,
    'cover_photo': false,
    'input_text': false,
    'collection': false,
    'properties': true
  };

  void dispose() {
    selectIdSubject.close();
    mediaFileSubject.close();
    imageFileSubject.close();
    fileErrorTextSubject.close();
    videoFileSubject.close();
    controller?.dispose();
    listCollectionSubject.close();
  }

  void validateCreate() {
    log('Media type: $mediaType');
    log('media_file: ${createNftMapCheck.toString()}');
    if (mediaType == MEDIA_IMAGE_FILE) {
      if (createNftMapCheck['media_file'] == false ||
          createNftMapCheck['input_text'] == false ||
          createNftMapCheck['collection'] == false ||
          createNftMapCheck['properties'] == false) {
        createNftButtonSubject.sink.add(false);
      } else {
        createNftButtonSubject.sink.add(true);
      }
    } else {
      if (createNftMapCheck['media_file'] == false ||
          createNftMapCheck['cover_photo'] == false ||
          createNftMapCheck['input_text'] == false ||
          createNftMapCheck['collection'] == false ||
          createNftMapCheck['properties'] == false) {
        createNftButtonSubject.sink.add(false);
      } else {
        createNftButtonSubject.sink.add(true);
      }
    }
  }
}
