import 'dart:io';

import 'package:Dfy/presentation/create_hard_nft/bloc/provide_hard_nft_info/provide_hard_nft_cubit.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:Dfy/utils/pick_media_file.dart';
import 'package:video_player/video_player.dart';

extension FileController on ProvideHardNftCubit {
  Future<void> pickMedia({bool pickImageIos = false}) async {
    final Map<String, dynamic> mediaMap = pickImageIos
        ? await pickImageFunc(tittle: 'Pick Image', needCrop: false)
        : await pickMediaFile(type: PickerType.MEDIA_FILE);
    final _path = mediaMap.getStringValue(PATH_OF_FILE);
    if (mediaMap.getBoolValue(VALID_FORMAT_OF_FILE) &&
        _path.isNotEmpty &&
        !listPathImage.contains(_path)) {
      listPathImage.add(_path);
      listFile.add({
        PATH_OF_FILE: _path,
        TYPE_OF_FILE: mediaMap.getStringValue(TYPE_OF_FILE),
        EXTENSION_OF_FILE: mediaMap.getStringValue(EXTENSION_OF_FILE),
      });
      if (listFile.length == 1) {
        currentIndexFile = 0;
        currentFile = listFile.first;
        await checkCurrentFile();
      }
      sendListWithoutCurrentFile();
    }
    checkLentData();
    mapValidate['mediaFiles'] = listFile.isNotEmpty;
    validateAll();
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
    if (mediaMap.getBoolValue(VALID_FORMAT_OF_FILE) &&
        _path.isNotEmpty &&
        !listPathDocument.contains(_path)) {
      listDocumentFile.add({
        PATH_OF_FILE: _path,
        TYPE_OF_FILE: mediaMap.getStringValue(TYPE_OF_FILE),
        EXTENSION_OF_FILE: mediaMap.getStringValue(EXTENSION_OF_FILE)
      });
      listPathDocument.add(_path);
      // dataStep1.documents.add(value)
      listDocumentPathSubject.sink.add(listPathDocument);
    }
    checkLentData(isMedia: false);
  }

  Future<void> controlMainImage({required bool isNext}) async {
    await videoController?.pause();
    await controlAudio(needStop: true);
    if (currentFile.isEmpty) {
      currentIndexFile = 0;
      currentFile = listFile.first;
    }
    if (isNext) {
      if (currentIndexFile == (listFile.length - 1)) {
        currentIndexFile = 0;
        currentFile = listFile.first;
      } else {
        currentIndexFile++;
        currentFile = listFile[currentIndexFile];
      }
    } else {
      if (currentIndexFile == 0) {
        currentIndexFile = listFile.length - 1;
        currentFile = listFile.last;
      } else {
        currentIndexFile--;
        currentFile = listFile[currentIndexFile];
      }
    }
    await checkCurrentFile();
    sendListWithoutCurrentFile();
  }

  Future<void> removeCurrentImage() async {
    listPathImage.removeAt(currentIndexFile);
    listFile.removeAt(currentIndexFile);
    await videoController?.pause();
    await controlAudio(needStop: true);
    if (listFile.isNotEmpty) {
      if (currentIndexFile > 0) {
        currentIndexFile--;
      } else {
        currentIndexFile = 0;
      }
      currentFile = listFile[currentIndexFile];
    } else {
      currentFile = {};
      currentIndexFile = 0;
    }
    await checkCurrentFile();
    sendListWithoutCurrentFile();
    enableButtonUploadImageSubject.sink.add(true);
    mapValidate['mediaFiles'] = listFile.isNotEmpty;
    validateAll();
  }

  void sendListWithoutCurrentFile() {
    final List<Map<String, String>> tempList = [];
    tempList.addAll(listFile);
    try {
      tempList.removeAt(currentIndexFile);
    } catch (_) {}
    listImagePathSubject.sink.add(tempList);
  }

  void removeDocument(int _index) {
    listPathDocument.removeAt(_index);
    listDocumentFile.removeAt(_index);
    listDocumentPathSubject.sink.add(listPathDocument);
    enableButtonUploadDocumentSubject.sink.add(true);
  }

  Future<void> initVideo(String _path) async {
    if (_path != currentVideo) {
      currentVideo = _path;
      videoController = VideoPlayerController.file(File(_path));
      await videoController?.initialize();
      playVideoButtonSubject.sink.add(true);
    }
    videoFileSubject.sink.add(videoController!);
  }

  Future<void> checkCurrentFile() async {
    final _fileType = currentFile.getStringValue(TYPE_OF_FILE);
    if (_fileType == MEDIA_VIDEO_FILE) {
      await initVideo(currentFile.getStringValue(PATH_OF_FILE));
    } else if (_fileType == MEDIA_AUDIO_FILE) {
      await audioPlayer.play(
        currentFile.getStringValue(PATH_OF_FILE),
        isLocal: true,
      );
      await audioPlayer.pause();
      isPlayingAudioSubject.sink.add(false);
    }
    currentFileSubject.sink.add(currentFile);
  }

  Future<void> controlAudio({bool needStop = false}) async {
    if (needStop) {
      await audioPlayer.stop();
    } else {
      if (isPlayingAudioSubject.value) {
        await audioPlayer.pause();
        isPlayingAudioSubject.sink.add(false);
      } else {
        await audioPlayer.resume();
        isPlayingAudioSubject.sink.add(true);
      }
    }
  }

  String getTypeUploadFile({required String type, required String extension}) {
    String _returnType = type;
    switch (extension) {
      case 'doc':
        _returnType = DOC;
        break;
      case 'docx':
        _returnType = DOCX;
        break;
      case 'xls':
        _returnType = XLS;
        break;
      case 'xlsx':
        _returnType = XLSX;
        break;
      case 'pdf':
        _returnType = PDF;
        break;
      default:
        break;
    }
    return '$_returnType/$extension';
  }
}
