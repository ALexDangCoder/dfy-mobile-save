import 'dart:io';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/config/base/base_state.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/collection_market_model.dart';
import 'package:Dfy/domain/model/market_place/type_nft_model.dart';
import 'package:Dfy/domain/repository/market_place/collection_detail_repository.dart';
import 'package:Dfy/domain/repository/nft_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:video_player/video_player.dart';

part 'create_nft_state.dart';

class CreateNftCubit extends BaseCubit<CreateNftState> {
  CreateNftCubit() : super(CreateNftInitial()) {
    getListTypeNFT();
  }

  VideoPlayerController? controller;

  CollectionDetailRepository get collectionDetailRepository => Get.find();

  NFTRepository get _nftRepo => Get.find();

  List<TypeNFTModel> listNft = [];
  List<TypeNFTModel> listSoftNft = [];
  List<TypeNFTModel> listHardNft = [];
  List<CollectionMarketModel> listCollectionModel = [];

  String selectedId = '';
  int selectedNftType = 0;
  String walletAddress = '';

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
  final BehaviorSubject<String> coverPhotoSubject = BehaviorSubject();

  ///Error text image file size
  final BehaviorSubject<String> fileErrorTextSubject = BehaviorSubject();

  final BehaviorSubject<List<Map<String,dynamic>>> listCollectionSubject =
      BehaviorSubject();

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

  void dispose() {
    selectIdSubject.close();
    mediaFileSubject.close();
    imageFileSubject.close();
    fileErrorTextSubject.close();
    videoFileSubject.close();
    controller?.dispose();
    listCollectionSubject.close();
  }
}
