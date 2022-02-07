import 'dart:io';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/config/base/base_state.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/model/market_place/collection_market_model.dart';
import 'package:Dfy/domain/model/market_place/type_nft_model.dart';
import 'package:Dfy/domain/repository/market_place/collection_detail_repository.dart';
import 'package:Dfy/domain/repository/nft_repository.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/upload_ipfs/pin_to_ipfs.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:rxdart/rxdart.dart';
import 'package:video_player/video_player.dart';

part 'create_nft_state.dart';

class CreateNftCubit extends BaseCubit<CreateNftState> {
  CreateNftCubit() : super(CreateNftInitial());

  VideoPlayerController? controller;

  AudioPlayer audioPlayer = AudioPlayer();

  CollectionDetailRepository get collectionDetailRepository => Get.find();

  final PinToIPFS ipfsService = PinToIPFS();

  Web3Utils web3utils = Web3Utils();

  NFTRepository get nftRepo => Get.find();

  List<TypeNFTModel> listSoftNft = [];
  List<CollectionMarketModel> softCollectionList = [];

  String selectedId = '';
  int selectedNftType = 0;
  String walletAddress = '';

  String nftIPFS = '';
  String transactionData = '';
  String tokenAddress = '';
  String collectionName = '';

  ///Detail NFT var
  String mediaType = '';
  String nftName = '';
  String collectionAddress = '';
  String collectionId = '';
  String description = '';
  int royalty = 0;
  String mediaFileCid = '';
  String coverCid = '';
  String fileType = '';
  int mintingFeeNumber = 10;
  String mintingFeeToken = 'DFY';

  ///mediaFilePath,Size
  String mediaFilePath = '';
  String coverPhotoPath = '';
  int mediaFileUploadTime = 0;
  int coverFileSize = 0;

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
  final BehaviorSubject<String> audioFileSubject = BehaviorSubject();
  final BehaviorSubject<String> coverPhotoSubject = BehaviorSubject();
  final BehaviorSubject<bool> playVideoButtonSubject = BehaviorSubject();
  final BehaviorSubject<bool> isPlayingAudioSubject = BehaviorSubject();

  ///Error text image file size
  final BehaviorSubject<String> fileErrorTextSubject = BehaviorSubject();
  final BehaviorSubject<List<Map<String, dynamic>>> listCollectionSubject =
      BehaviorSubject();

  ///upload IPFS progress bar
  BehaviorSubject<int> mediaFileUploadStatusSubject = BehaviorSubject();
  BehaviorSubject<int> coverPhotoUploadStatusSubject = BehaviorSubject();
  BehaviorSubject<int> upLoadStatusSubject = BehaviorSubject();

  ///Error String
  final BehaviorSubject<String> collectionMessSubject = BehaviorSubject();
  final BehaviorSubject<String> coverPhotoMessSubject = BehaviorSubject();

  ///List Map value - properties
  final BehaviorSubject<List<Map<String, String>>> listPropertySubject =
      BehaviorSubject();
  final BehaviorSubject<bool> showAddPropertySubject = BehaviorSubject();

  List<Map<String, String>> listProperty = [];

  Map<String, bool> createNftMapCheck = {
    'media_file': false,
    'cover_photo': false,
    'input_text': false,
    'collection': false,
    'properties': true
  };

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

  Map<String, dynamic> getMapCreateSoftNft() {
    return {
      'collection_id': collectionId,
      'cover_cid': coverCid,
      'description': description,
      'file_cid': mediaFileCid,
      'file_type': fileType,
      'minting_fee_number': mintingFeeNumber,
      'minting_fee_token': mintingFeeToken,
      'name': nftName,
      'properties': listProperty,
      'royalties': royalty.toString(),
      'txn_hash': ''
    };
  }

  void dispose() {
    selectIdSubject.close();
    mediaFileSubject.close();
    imageFileSubject.close();
    fileErrorTextSubject.close();
    videoFileSubject.close();
    controller?.dispose();
    listCollectionSubject.close();
    audioPlayer.dispose();
  }
}
