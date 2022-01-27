import 'dart:io';

import 'package:Dfy/presentation/my_account/create_nft/bloc/create_nft_cubit.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:Dfy/utils/pick_media_file.dart';
import 'package:video_player/video_player.dart';

extension PickFileExtension on CreateNftCubit {
  Future<void> pickFile() async {
    mediaType = '';
    final Map<String, dynamic> mediaFile =
        await pickMediaFile(type: PickerType.MEDIA_FILE);
    mediaType = mediaFile.getStringValue('type');
    final extension = mediaFile.getStringValue('extension');
    final path = mediaFile.getStringValue('path');
    fileType = '$mediaType/$extension';
    mediaFileSubject.sink.add(mediaType);
    if (path.isNotEmpty) {
      mediaFileUploadTime =
          ipfsService.uploadTimeCalculate(mediaFile.intValue('size'));
      mediaFilePath = path;
      createNftMapCheck['media_file'] = true;
      switch (mediaType) {
        case MEDIA_IMAGE_FILE:
          {
            imageFileSubject.sink.add(path);
            break;
          }
        case MEDIA_VIDEO_FILE:
          {
            if (controller == null) {
              controller = VideoPlayerController.file(File(path));
              await controller?.initialize();
              videoFileSubject.sink.add(controller!);
            }
            break;
          }
        default:
          {
            break;
          }
      }
    } else {
      createNftMapCheck['media_file'] = false;
    }
    validateCreate();
  }

  Future<void> pickCoverPhoto() async {
    final Map<String, dynamic> mediaFile = await pickMediaFile(
        type: PickerType.IMAGE_FILE,
    );
    final path = mediaFile.getStringValue('path');
    if (path.isNotEmpty) {
      coverFileSize = mediaFile.intValue('size');
      createNftMapCheck['cover_photo'] = true;
      coverPhotoPath = path;
      coverPhotoSubject.sink.add(coverPhotoPath);
    } else {
      createNftMapCheck['cover_photo'] = false;
    }
    validateCreate();
  }

  void clearCoverPhoto() {
    coverPhotoPath = '';
    coverPhotoSubject.sink.add(coverPhotoPath);
    createNftMapCheck['cover_photo'] = false;
    validateCreate();
    coverFileSize = 0;
  }

  void clearMainData() {
    createNftMapCheck['media_file'] = false;
    try {
      controller?.pause();
      controller = null;
    } catch (_) {}
    mediaFileSubject.sink.add('');
    clearCoverPhoto();
  }
}
