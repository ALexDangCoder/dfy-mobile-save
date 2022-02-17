import 'dart:io';

import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/my_account/create_collection/bloc/create_collection_cubit.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:Dfy/utils/pick_media_file.dart';

extension UploadCreateCollection on CreateCollectionCubit{

  Future<void> pickImage({
    required String imageType,
    required String tittle,
  }) async {
    final fileMap = await pickImageFunc(imageType: imageType, tittle: tittle);
    final filePath = fileMap.getStringValue(PATH_OF_FILE);
    if (filePath.isNotEmpty) {
      final imageTemp = File(filePath);
      final imageSize =
          imageTemp.readAsBytesSync().lengthInBytes / 1048576;
      loadImage(
        type: imageType,
        imageSizeInMB: imageSize,
        imagePath: imageTemp.path,
        image: imageTemp,
      );
    }
  }

  void loadImage({
    required String type,
    required double imageSizeInMB,
    required String imagePath,
    required File image,
  }) {
    const maximumFileSize = 15728640;
    switch (type) {
      case AVATAR_PHOTO:
        {
          if (imageSizeInMB > maximumFileSize) {
            mapCheck[AVATAR_PHOTO_MAP] = false;
            avatarMessSubject.sink.add(S.current.maximum_size);
            break;
          } else {
            mapCheck[AVATAR_PHOTO_MAP] = true;
            avatarMessSubject.sink.add('');
            avatarSubject.sink.add(image);
            avatarPath = imagePath;
            avatar = image;
            break;
          }
        }
      case COVER_PHOTO:
        {
          if (imageSizeInMB > maximumFileSize) {
            mapCheck[COVER_PHOTO_MAP] = false;
            coverPhotoMessSubject.sink.add(S.current.maximum_size);
            break;
          } else {
            mapCheck[COVER_PHOTO_MAP] = true;
            coverPhotoMessSubject.sink.add('');
            coverPhotoSubject.sink.add(image);
            coverPhotoPath = imagePath;
            coverPhoto = image;
            break;
          }
        }
      case FEATURE_PHOTO:
        {
          if (imageSizeInMB > maximumFileSize) {
            mapCheck[FEATURE_PHOTO_MAP] = false;
            featurePhotoMessSubject.sink.add(S.current.maximum_size);
            break;
          } else {
            mapCheck[FEATURE_PHOTO_MAP] = true;
            featurePhotoMessSubject.sink.add('');
            featurePhotoSubject.sink.add(image);
            featurePhotoPath = imagePath;
            featurePhoto = image;
            break;
          }
        }
      default:
        break;
    }
    validateCreate();
  }
}