import 'dart:io';

import 'package:Dfy/config/themes/app_theme.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

Future<Map<String, dynamic>> pickMediaFile() async {
  String filePath = '';
  String mediaType = '';
  int fileSize = 0;
  final FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: [
      'mp4',
      'WEBM',
      'mp3',
      'WAV',
      'OGG',
      'png',
      'jpg',
      'jpeg',
      'GIF'
    ],
  );
  if (result != null) {
    final fileExtension = result.files.single.extension;
    if (fileExtension == 'mp4' || fileExtension == 'webm') {
      mediaType = 'video';
    } else if (fileExtension == 'mp3' ||
        fileExtension == 'wav' ||
        fileExtension == 'OOG') {
      mediaType = 'audio';
    } else {
      mediaType = 'image';
    }
    filePath = result.files.single.path ?? '';
    fileSize = result.files.single.size;
  } else {
    // User canceled the picker
  }
  return {'type': mediaType, 'path': filePath, 'size': fileSize};
}

Future<String> pickImageFunc({
  required String imageType,
  required String tittle,
}) async {
  String filePath = '';
  try {
    final newImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (newImage == null) {
      return '';
    }
    final List<CropAspectRatioPreset> presetAndroid = imageType == 'avatar'
        ? [
            CropAspectRatioPreset.square,
          ]
        : [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ];
    final List<CropAspectRatioPreset> presetIos = imageType == 'avatar'
        ? [
            CropAspectRatioPreset.square,
          ]
        : [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio5x3,
            CropAspectRatioPreset.ratio5x4,
            CropAspectRatioPreset.ratio7x5,
            CropAspectRatioPreset.ratio16x9,
          ];
    final File? croppedFile = await ImageCropper.cropImage(
      sourcePath: newImage.path,
      cropStyle: imageType == 'avatar' ? CropStyle.circle : CropStyle.rectangle,
      aspectRatioPresets: Platform.isAndroid ? presetAndroid : presetIos,
      androidUiSettings: AndroidUiSettings(
        activeControlsWidgetColor: AppTheme.getInstance().bgBtsColor(),
        toolbarColor: AppTheme.getInstance().bgBtsColor(),
        backgroundColor: AppTheme.getInstance().bgBtsColor(),
        statusBarColor: Colors.black,
        toolbarTitle: tittle,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: imageType == 'avatar'
            ? CropAspectRatioPreset.square
            : CropAspectRatioPreset.original,
        lockAspectRatio: imageType == 'avatar',
      ),
      iosUiSettings: IOSUiSettings(
        title: tittle,
      ),
    );
    if (croppedFile != null) {
      filePath = croppedFile.path;
    }
    return filePath;
  } on PlatformException catch (e) {
    throw 'Cant upload image $e';
  }
}
