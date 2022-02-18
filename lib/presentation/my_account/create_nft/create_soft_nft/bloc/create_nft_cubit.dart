import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/config/base/base_state.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
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
import 'package:rxdart/rxdart.dart';
import 'package:video_player/video_player.dart';

part 'create_nft_state.dart';

const String KEY_PROPERTY = 'key';
const String VALUE_PROPERTY = 'value';
const String MEDIA_KEY = 'media_file';
const String COVER_PHOTO_KEY = 'cover_photo';
const String INPUT_KEY = 'input_text';
const String COLLECTION_KEY = 'collection';
const String PROPERTIES_KEY = 'properties';


class CreateNftCubit extends BaseCubit<CreateNftState> {

  CreateNftCubit() : super(CreateNftInitial());

  VideoPlayerController? controller;

  AudioPlayer audioPlayer = AudioPlayer();

  CollectionDetailRepository get collectionDetailRepository => Get.find();


  final PinToIPFS ipfsService = PinToIPFS();

  Web3Utils web3utils = Web3Utils();

  NFTRepository get nftRepo => Get.find();

  List<TypeNFTModel> listNft = [];
  List<CollectionMarketModel> softCollectionList = [];

  String selectedId = '';
  int selectedNftType = 0;
  String walletAddress = PrefsService.getCurrentBEWallet();

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

  final BehaviorSubject<List<TypeNFTModel>> listNftSubject = BehaviorSubject();

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
  List<bool> boolProperties = [];

  Map<String, bool> createNftMapCheck = {
    MEDIA_KEY: false,
    COVER_PHOTO_KEY: false,
    INPUT_KEY: false,
    COLLECTION_KEY: false,
    PROPERTIES_KEY : true,
  };

  void validateCreate() {
    if (mediaType == MEDIA_IMAGE_FILE) {
      if (createNftMapCheck[MEDIA_KEY] == false ||
          createNftMapCheck[INPUT_KEY] == false ||
          createNftMapCheck[COLLECTION_KEY] == false ||
          createNftMapCheck[PROPERTIES_KEY] == false) {
        createNftButtonSubject.sink.add(false);
      } else {
        createNftButtonSubject.sink.add(true);
      }
    } else {
      if (createNftMapCheck[MEDIA_KEY] == false ||
          createNftMapCheck[COVER_PHOTO_KEY] == false ||
          createNftMapCheck[INPUT_KEY] == false ||
          createNftMapCheck[COLLECTION_KEY] == false ||
          createNftMapCheck[PROPERTIES_KEY] == false) {
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
