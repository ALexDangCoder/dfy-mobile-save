import 'dart:io';

import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

const String TYPE_OF_FILE = 'type';
const String PATH_OF_FILE = 'path';
const String SIZE_OF_FILE = 'size';
const String EXTENSION_OF_FILE = 'extension';
const String VALID_FORMAT_OF_FILE = 'valid_format';

Future<Map<String, dynamic>> pickMediaFile({required PickerType type}) async {
  final List<String> allowedExtensions = type.fileType;

  String _filePath = '';
  String _fileType = '';
  String _fileExtension = '';
  bool _validFormat = true;
  int _fileSize = 0;
  final FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: allowedExtensions,
  );
  if (result != null) {
    _fileExtension = (result.files.single.extension ?? '').toUpperCase();
    _validFormat = allowedExtensions.contains(_fileExtension);
    if (PickerType.DOCUMENT.fileType.contains(_fileExtension)) {
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
    _fileSize = result.files.single.size;
  } else {
    // User canceled the picker
  }
  return {
    TYPE_OF_FILE: _fileType,
    PATH_OF_FILE: _filePath,
    SIZE_OF_FILE: _fileSize,
    EXTENSION_OF_FILE: _fileExtension,
    VALID_FORMAT_OF_FILE: _validFormat,
  };
}

Future<Map<String, dynamic>> pickImageFunc({
  required String imageType,
  required String tittle,
  bool needCrop = true,
}) async {
  String filePath = '';
  final Map<String, dynamic> _resultMap = {
    PATH_OF_FILE: '',
    SIZE_OF_FILE: 0,
    EXTENSION_OF_FILE: '',
    VALID_FORMAT_OF_FILE: '',
  };
  try {
    final newImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (newImage == null) {
      return _resultMap;
    }
    final extension = (p.extension(newImage.path)).replaceAll('.', '');
    _resultMap[EXTENSION_OF_FILE] = extension;
    _resultMap[VALID_FORMAT_OF_FILE] =
        PickerType.IMAGE_FILE.fileType.contains(extension.toUpperCase());
    if (!needCrop) {
      _resultMap[SIZE_OF_FILE] =
          File(newImage.path).readAsBytesSync().lengthInBytes;
      _resultMap[PATH_OF_FILE] = newImage.path;
      return _resultMap;
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
      _resultMap[SIZE_OF_FILE] =
          File(filePath).readAsBytesSync().lengthInBytes;
    }
    _resultMap[PATH_OF_FILE] = filePath;
    return _resultMap;
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
        return [
          'MP4',
          'WEBM',
          'MP3',
          'WAV',
          'OGG',
          'PNG',
          'JPG',
          'JPEG',
          'GIF'
        ];
      case PickerType.IMAGE_FILE:
        return ['JPG', 'PNG', 'GIF', 'JPEG'];
      case PickerType.DOCUMENT:
        return ['DOC', 'DOCX', 'PDF', 'XLS', 'XLSX'];
    }
  }
}
