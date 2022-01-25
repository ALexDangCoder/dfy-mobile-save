import 'dart:io';

import 'package:Dfy/presentation/my_account/create_nft/bloc/create_nft_cubit.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:Dfy/utils/pick_media_file.dart';
import 'package:video_player/video_player.dart';

extension UploadExtension on CreateNftCubit {
  Future<void> pickFile() async {
    mediaType = '';
    final Map<String, dynamic> mediaFile = await pickMediaFile();
    mediaType = mediaFile.getStringValue('type');
    final path = mediaFile.getStringValue('path');
    if (path.isNotEmpty) {
      createNftMapCheck['media_file'] = true;
    } else {
      createNftMapCheck['media_file'] = false;
    }
    mediaFileSubject.sink.add(mediaType);
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
            await controller?.setLooping(true);
            await controller?.initialize();
            await controller?.play();
            videoFileSubject.sink.add(controller!);
          }
          break;
        }
      default:
        {
          break;
        }
    }
    validateCreate();
  }

  Future<void> pickCoverPhoto() async {
    final Map<String, dynamic> mediaFile = await pickMediaFile(
      isCoverPhoto: true,
    );
    final path = mediaFile.getStringValue('path');
    if (path.isNotEmpty) {
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
