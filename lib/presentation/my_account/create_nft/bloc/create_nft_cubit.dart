import 'dart:io';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/config/base/base_state.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/type_nft_model.dart';
import 'package:Dfy/domain/repository/nft_repository.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:Dfy/utils/pick_media_file.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:video_player/video_player.dart';

part 'create_nft_state.dart';

class CreateNftCubit extends BaseCubit<CreateNftState> {
  CreateNftCubit() : super(CreateNftInitial()) {
    getListTypeNFT();
  }

  VideoPlayerController? _controller;

  NFTRepository get _nftRepo => Get.find();

  List<TypeNFTModel> listNft = [];
  List<TypeNFTModel> listSoftNft = [];
  List<TypeNFTModel> listHardNft = [];

  String selectedId = '';
  int selectedNftType = 0;

  ///Detail NFT var
  String nftName = '';
  String description = '';
  int royalty = 0;

  ///Stream
  ///id of nft
  final BehaviorSubject<String> selectIdSubject = BehaviorSubject();

  ///Media file
  final BehaviorSubject<String> mediaFileSubject = BehaviorSubject();
  final BehaviorSubject<String> imageFileSubject = BehaviorSubject();
  final BehaviorSubject<VideoPlayerController> videoFileSubject =
      BehaviorSubject();
  final BehaviorSubject<File> audioFileSubject = BehaviorSubject();

  ///Error text image file size
  final BehaviorSubject<String> fileErrorTextSubject = BehaviorSubject();

  Future<void> getListTypeNFT() async {
    showLoading();
    final Result<List<TypeNFTModel>> result = await _nftRepo.getListTypeNFT();
    result.when(
      success: (res) {
        showContent();
        listNft = res;
        res.sort((a, b) => (a.standard ?? 0).compareTo(b.standard ?? 0));
        listSoftNft = res.where((element) => element.type == 0).toList();
        emit(
          TypeNFT(listSoftNft: listSoftNft),
        );
        listHardNft = res.where((element) => element.type == 1).toList();
      },
      error: (error) {
        showError();
      },
    );
  }

  void changeId(String id) {
    selectedId = id;
    selectIdSubject.sink.add(selectedId);
    selectedNftType =
        listNft.where((element) => element.id == id).toList().first.type ?? 1;
  }
}

/// Detail NFT logic
extension CreateDetailNFF on CreateNftCubit {
  Future<void> pickFile() async {
    final Map<String, dynamic> mediaFile = await pickMediaFile();
    final type = mediaFile.getStringValue('type');
    final path = mediaFile.getStringValue('path');
    mediaFileSubject.sink.add(type);
    switch (type) {
      case 'image':
        {
          imageFileSubject.sink.add(path);
          break;
        }
      case 'video':
        {
          if(_controller==null){
            _controller = VideoPlayerController.file(File(path));
            await _controller?.setLooping(true);
            await _controller?.initialize();
            await _controller?.play();
            videoFileSubject.sink.add(_controller!);
          }
          break;
        }
      default:
        {
          break;
        }
    }
  }

  void clearData() {
    try {
      _controller?.pause();
      _controller = null;
    } catch (_) {}
    mediaFileSubject.sink.add('');
  }

  void dispose() {
    selectIdSubject.close();
    mediaFileSubject.close();
    imageFileSubject.close();
    fileErrorTextSubject.close();
    videoFileSubject.close();
    _controller?.dispose();
  }
}
