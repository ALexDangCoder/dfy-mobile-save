import 'dart:io';

import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

Future<Map<String, dynamic>> pickMediaFile({required PickerType type}) async {
  final List<String> allowedExtensions = type.fileType;

  String _filePath = '';
  String _fileType = '';
  String _fileExtension = '';
  bool _validFormat = true;
  int fileSize = 0;
  final FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: allowedExtensions,
  );
  if (result != null) {
    _fileExtension = (result.files.single.extension ?? '').toUpperCase();
    _validFormat = allowedExtensions.contains(_fileExtension);
    if(PickerType.DOCUMENT.fileType.contains(_fileExtension)){
      _fileType = DOCUMENT_FILE;
    } else {
      if (_fileExtension == 'MP4' || _fileExtension == 'WEBM') {
        _fileType = MEDIA_VIDEO_FILE;
      } else if (_fileExtension == 'MP3' ||
          _fileExtension == 'WAV' ||
          _fileExtension == 'OOG') {
        _fileType = MEDIA_AUDIO_FILE;
      } else {
        _fileType = MEDIA_IMAGE_FILE;
      }
    }

    _filePath = result.files.single.path ?? '';
    fileSize = result.files.single.size;
  } else {
    // User canceled the picker
  }
  return {
    'type': _fileType,
    'path': _filePath,
    'size': fileSize,
    'extension': _fileExtension,
    'valid_format' : _validFormat,
  };
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
    final List<CropAspectRatioPreset> presetAndroid = imageType == AVATAR_PHOTO
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
    final List<CropAspectRatioPreset> presetIos = imageType == AVATAR_PHOTO
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
      cropStyle:
          imageType == AVATAR_PHOTO ? CropStyle.circle : CropStyle.rectangle,
      aspectRatioPresets: Platform.isAndroid ? presetAndroid : presetIos,
      androidUiSettings: AndroidUiSettings(
        activeControlsWidgetColor: AppTheme.getInstance().bgBtsColor(),
        toolbarColor: AppTheme.getInstance().bgBtsColor(),
        backgroundColor: AppTheme.getInstance().bgBtsColor(),
        statusBarColor: Colors.black,
        toolbarTitle: tittle,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: imageType == AVATAR_PHOTO
            ? CropAspectRatioPreset.square
            : CropAspectRatioPreset.original,
        lockAspectRatio: imageType == AVATAR_PHOTO,
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

enum PickerType {
  MEDIA_FILE,
  IMAGE_FILE,
  DOCUMENT,
}

extension GetTypeByName on PickerType {
  List<String> get fileType {
    switch (this) {
      case PickerType.MEDIA_FILE:
        return ['MP4', 'WEBM', 'MP3', 'WAV', 'OGG', 'PNG', 'JPG', 'JPEG', 'GIF'];
      case PickerType.IMAGE_FILE:
        return ['JPG', 'PNG', 'GIF',]; //'JPEG'
      case PickerType.DOCUMENT:
        return ['DOC','DOCX','PDF','XLS','XLSX'];
    }
  }
}
