import 'dart:developer';
import 'dart:io';

import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/my_account/create_nft/create_soft_nft/bloc/create_nft_cubit.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:Dfy/utils/pick_media_file.dart';
import 'package:video_player/video_player.dart';

extension PickFileExtension on CreateNftCubit {
  Future<void> pickFile() async {
    collectionMessSubject.sink.add('');
    mediaType = '';
    final Map<String, dynamic> _mediaFile =
        await pickMediaFile(type: PickerType.MEDIA_FILE);
    mediaType = _mediaFile.getStringValue(TYPE_OF_FILE);
    final _path = _mediaFile.getStringValue(PATH_OF_FILE);
    mediaFileSubject.sink.add(mediaType);
    if (_path.isNotEmpty) {
      final _isValidFormat = _mediaFile.getBoolValue(VALID_FORMAT_OF_FILE);
      final _extension = _mediaFile.getStringValue(EXTENSION_OF_FILE);
      final _size = _mediaFile.intValue(SIZE_OF_FILE);
      fileType = '$mediaType/$_extension';
      if (50 < _size / 1000000) {
        clearMainData();
        collectionMessSubject.sink.add(S.current.maximum_file_size);
        createNftMapCheck[MEDIA_KEY] = false;
      }
      if (!_isValidFormat) {
        clearMainData();
        collectionMessSubject.sink.add(S.current.invalid_file_format);
        createNftMapCheck[MEDIA_KEY] = false;
      } else {
        mediaFileUploadTime = ipfsService.uploadTimeCalculate(_size);
        mediaFilePath = _path;
        createNftMapCheck[MEDIA_KEY] = true;
        switch (mediaType) {
          case MEDIA_IMAGE_FILE:
            {
              imageFileSubject.sink.add(_path);
              break;
            }
          case MEDIA_VIDEO_FILE:
            {
              if (controller == null) {
                controller = VideoPlayerController.file(File(_path));
                await controller?.initialize();
                await controller?.setLooping(true);
                playVideoButtonSubject.sink.add(true);
                videoFileSubject.sink.add(controller!);
              }
              break;
            }
          case MEDIA_AUDIO_FILE:
            {
              await audioPlayer.play(_path, isLocal: true);
              await audioPlayer.pause();
              isPlayingAudioSubject.sink.add(false);
              audioFileSubject.sink.add(_path);
            }
            break;
          default:
            {
              break;
            }
        }
      }
    } else {
      createNftMapCheck[MEDIA_KEY] = false;
    }
    validateCreate();
  }

  Future<void> pickImage({bool isMainMedia = false}) async {
    collectionMessSubject.sink.add('');
    final _fileMap = await pickImageFunc(
      imageType: FEATURE_PHOTO,
      tittle: 'Pick Image',
      needCrop: false,
    );
    final _path = _fileMap.getStringValue(PATH_OF_FILE);
    if (_path.isNotEmpty) {
      final _imageSize = _fileMap.intValue(SIZE_OF_FILE);
      final _extension = _fileMap.getStringValue(EXTENSION_OF_FILE);
      log('SIZE: $_imageSize - EXTENSION: $_extension - PATH: $_path');
      if (isMainMedia) {
        if(_imageSize / 1048576 < 50){
          fileType = '$MEDIA_IMAGE_FILE/$_extension';
          mediaFilePath = _path;
          mediaType = MEDIA_IMAGE_FILE;
          mediaFileSubject.sink.add(mediaType);
          mediaFileUploadTime = ipfsService.uploadTimeCalculate(_imageSize);
          imageFileSubject.sink.add(_path);
          createNftMapCheck[MEDIA_KEY] = true;
        }
        else {
          collectionMessSubject.sink.add(S.current.maximum_file_size);
          createNftMapCheck[MEDIA_KEY] = false;
        }
      } else {
        if(_imageSize / 1048576 < 50){
          coverPhotoPath = _path;
          coverFileSize = _imageSize;
          coverPhotoSubject.sink.add(_path);
          createNftMapCheck[COVER_PHOTO_KEY] = true;
        }
        else {
          createNftMapCheck[COVER_PHOTO_KEY] = false;
          coverPhotoMessSubject.sink.add(S.current.maximum_file_size);
        }
      }
    }
    validateCreate();
  }

  // Future<void> pickCoverPhoto() async {
  //   coverPhotoMessSubject.sink.add('');
  //   final Map<String, dynamic> mediaFile = await pickMediaFile(
  //     type: PickerType.IMAGE_FILE,
  //   );
  //   final _path = mediaFile.getStringValue(PATH_OF_FILE);
  //   if (_path.isNotEmpty) {
  //     final _isValidFormat = mediaFile.getBoolValue(VALID_FORMAT_OF_FILE);
  //     coverFileSize = mediaFile.intValue(SIZE_OF_FILE);
  //     if (coverFileSize / 1000000 > 50) {
  //       createNftMapCheck[COVER_PHOTO_KEY] = false;
  //       coverPhotoMessSubject.sink.add(S.current.maximum_file_size);
  //     } else if (!_isValidFormat) {
  //       createNftMapCheck[COVER_PHOTO_KEY] = false;
  //       coverPhotoMessSubject.sink.add(S.current.invalid_file_format);
  //     } else {
  //       createNftMapCheck[COVER_PHOTO_KEY] = true;
  //       coverPhotoPath = _path;
  //       coverPhotoSubject.sink.add(coverPhotoPath);
  //     }
  //   } else {
  //     createNftMapCheck[COVER_PHOTO_KEY] = false;
  //   }
  //   validateCreate();
  // }

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

  void clearCoverPhoto() {
    coverPhotoPath = '';
    coverPhotoMessSubject.sink.add('');
    coverPhotoSubject.sink.add(coverPhotoPath);
    createNftMapCheck[COVER_PHOTO_KEY] = false;
    coverFileSize = 0;
    validateCreate();
  }

  void clearMediaFile() {
    createNftMapCheck[MEDIA_KEY] = false;
    try {
      audioPlayer.stop();
      controller?.pause();
      controller = null;
    } catch (_) {}
    mediaFileSubject.sink.add('');
  }

  void clearMainData() {
    clearMediaFile();
    clearCoverPhoto();
  }
}
