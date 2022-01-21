import 'dart:io';

import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/my_account/create_collection/bloc/create_collection_cubit.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/pick_media_file.dart';

extension UploadCreateCollection on CreateCollectionCubit{

  Future<void> pickImage({
    required String imageType,
    required String tittle,
  }) async {
    final filePath = await pickImageFunc(imageType: imageType, tittle: tittle);
    if (filePath.isNotEmpty) {
      final imageTemp = File(filePath);
      final imageSizeInMB =
          imageTemp.readAsBytesSync().lengthInBytes / 1048576;
      loadImage(
        type: imageType,
        imageSizeInMB: imageSizeInMB,
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
    switch (type) {
      case AVATAR_PHOTO:
        {
          if (imageSizeInMB > 15) {
            mapCheck['avatar'] = false;
            avatarMessSubject.sink.add(S.current.maximum_size);
            break;
          } else {
            mapCheck['avatar'] = true;
            avatarMessSubject.sink.add('');
            avatarSubject.sink.add(image);
            avatarPath = imagePath;
            avatar = image;
            break;
          }
        }
      case COVER_PHOTO:
        {
          if (imageSizeInMB > 15) {
            mapCheck['cover_photo'] = false;
            coverPhotoMessSubject.sink.add(S.current.maximum_size);
            break;
          } else {
            mapCheck['cover_photo'] = true;
            coverPhotoMessSubject.sink.add('');
            coverPhotoSubject.sink.add(image);
            coverPhotoPath = imagePath;
            coverPhoto = image;
            break;
          }
        }
      case FEATURE_PHOTO:
        {
          if (imageSizeInMB > 15) {
            mapCheck['feature_photo'] = false;
            featurePhotoMessSubject.sink.add(S.current.maximum_size);
            break;
          } else {
            mapCheck['feature_photo'] = true;
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