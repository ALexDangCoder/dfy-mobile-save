import 'dart:developer';

import 'package:Dfy/presentation/create_hard_nft/bloc/provide_hard_nft_info/provide_hard_nft_cubit.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:Dfy/utils/pick_media_file.dart';

extension FileController on ProvideHardNftCubit {
  Future<void> pickMedia() async {
    final Map<String, dynamic> mediaMap =
        await pickMediaFile(type: PickerType.MEDIA_FILE);
    final _path = mediaMap.getStringValue(PATH_OF_FILE);
    if (mediaMap.getBoolValue(VALID_FORMAT_OF_FILE) && _path.isNotEmpty) {
      listPathImage.add(_path);
      final temp = listPathImage.toSet();
      listPathImage = temp.toList();
      // listImagePathSubject.sink.add(listPathImage);
      if (listPathImage.length == 1) {
        currentIndexImage = 0;
        currentImagePath = listPathImage.first;
        currentImagePathSubject.sink.add(currentImagePath);
      }
      sendListWithoutMainCurrentImg();
    }
    checkLentData();
  }

  void checkLentData({bool isMedia = true}) {
    if (isMedia) {
      listPathImage.length < 9
          ? enableButtonUploadImageSubject.sink.add(true)
          : enableButtonUploadImageSubject.sink.add(false);
    } else {
      listPathDocument.length < 5
          ? enableButtonUploadDocumentSubject.sink.add(true)
          : enableButtonUploadDocumentSubject.sink.add(false);
    }
  }

  Future<void> pickDocument() async {
    final Map<String, dynamic> mediaMap =
        await pickMediaFile(type: PickerType.DOCUMENT);
    final _path = mediaMap.getStringValue(PATH_OF_FILE);
    if (mediaMap.getBoolValue(VALID_FORMAT_OF_FILE) && _path.isNotEmpty) {
      listPathDocument.add(_path);
      final temp = listPathDocument.toSet();
      listPathDocument = temp.toList();
      // dataStep1.documents.add(value)
      listDocumentPathSubject.sink.add(listPathDocument);
    }
    print(mediaMap.getStringValue(TYPE_OF_FILE));
    checkLentData(isMedia: false);
  }

  void controlMainImage({required bool isNext}) {
    if (currentImagePath.isEmpty) {
      currentIndexImage = 0;
      currentImagePath = listPathImage.first;
    }
    if (isNext) {
      if (currentIndexImage == (listPathImage.length - 1)) {
        currentIndexImage = 0;
        currentImagePath = listPathImage.first;
      } else {
        currentIndexImage++;
        currentImagePath = listPathImage[currentIndexImage];
      }
    } else {
      if (currentIndexImage == 0) {
        currentIndexImage = listPathImage.length - 1;
        currentImagePath = listPathImage.last;
      } else {
        currentIndexImage--;
        currentImagePath = listPathImage[currentIndexImage];
      }
    }
    currentImagePathSubject.sink.add(currentImagePath);
    sendListWithoutMainCurrentImg();
  }

  void removeCurrentImage() {
    listPathImage.removeAt(currentIndexImage);
    if (listPathImage.isNotEmpty) {
      if (currentIndexImage > 0) {
        currentIndexImage--;
      } else {
        currentIndexImage = 0;
      }
      currentImagePath = listPathImage[currentIndexImage];
      currentImagePathSubject.sink.add(currentImagePath);
    } else {
      currentImagePath = '';
      currentIndexImage = 0;
      currentImagePathSubject.sink.add(currentImagePath);
    }
    // listImagePathSubject.sink.add(listPathImage);
    sendListWithoutMainCurrentImg();
    enableButtonUploadImageSubject.sink.add(true);
  }

  void sendListWithoutMainCurrentImg(){
    final List<String> tempList = [];
    tempList.addAll(listPathImage);
    try{
      tempList.removeAt(currentIndexImage);
      log('LIST ALL: ${listPathImage.length}, LIST TEMP: ${tempList.length}');
    } catch (_){
    }
    listImagePathSubject.sink.add(tempList);
  }

  void removeDocument(int _index) {
    listPathDocument.removeAt(_index);
    listDocumentPathSubject.sink.add(listPathDocument);
    enableButtonUploadDocumentSubject.sink.add(true);
  }
}
