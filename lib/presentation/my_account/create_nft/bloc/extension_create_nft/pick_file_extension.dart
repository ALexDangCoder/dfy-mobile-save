import 'dart:io';

import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/my_account/create_nft/bloc/create_nft_cubit.dart';
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
    mediaType = _mediaFile.getStringValue('type');
    final _path = _mediaFile.getStringValue('path');
    mediaFileSubject.sink.add(mediaType);
    if (_path.isNotEmpty) {
      final _isValidFormat = _mediaFile.getBoolValue('valid_format');
      final _extension = _mediaFile.getStringValue('extension');
      final _size = _mediaFile.intValue('size');
      fileType = '$mediaType/$_extension';
      if (50 < _size / 1000000) {
        clearMainData();
        collectionMessSubject.sink.add(S.current.maximum_file_size);
        createNftMapCheck['media_file'] = false;
      }
      if (!_isValidFormat) {
        clearMainData();
        collectionMessSubject.sink.add(S.current.invalid_file_format);
        createNftMapCheck['media_file'] = false;
      } else {
        mediaFileUploadTime = ipfsService.uploadTimeCalculate(_size);
        mediaFilePath = _path;
        createNftMapCheck['media_file'] = true;
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
      createNftMapCheck['media_file'] = false;
    }
    validateCreate();
  }

  Future<void> pickCoverPhoto() async {
    coverPhotoMessSubject.sink.add('');
    final Map<String, dynamic> mediaFile = await pickMediaFile(
      type: PickerType.IMAGE_FILE,
    );
    final _path = mediaFile.getStringValue('path');
    if (_path.isNotEmpty) {
      final _isValidFormat = mediaFile.getBoolValue('valid_format');
      coverFileSize = mediaFile.intValue('size');
      if (coverFileSize / 1000000 > 50) {
        createNftMapCheck['cover_photo'] = false;
        coverPhotoMessSubject.sink.add(S.current.maximum_file_size);
      } else if (!_isValidFormat) {
        createNftMapCheck['cover_photo'] = false;
        coverPhotoMessSubject.sink.add(S.current.invalid_file_format);
      } else {
        createNftMapCheck['cover_photo'] = true;
        coverPhotoPath = _path;
        coverPhotoSubject.sink.add(coverPhotoPath);
      }
    } else {
      createNftMapCheck['cover_photo'] = false;
    }
    validateCreate();
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

  void clearCoverPhoto() {
    coverPhotoPath = '';
    coverPhotoMessSubject.sink.add('');
    coverPhotoSubject.sink.add(coverPhotoPath);
    createNftMapCheck['cover_photo'] = false;
    validateCreate();
    coverFileSize = 0;
  }

  void clearMediaFile() {
    createNftMapCheck['media_file'] = false;
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
