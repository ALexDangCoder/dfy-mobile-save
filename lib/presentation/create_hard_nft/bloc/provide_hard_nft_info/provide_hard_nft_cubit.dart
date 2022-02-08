import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'provide_hard_nft_state.dart';

enum DropDownBtnType {
  CONDITION,
  COUNTRY,
  CITY,
}

class PropertyModel {
  String value;
  String property;

  PropertyModel({required this.value, required this.property});
}

class ProvideHardNftCubit extends Cubit<ProvideHardNftState> {
  ProvideHardNftCubit() : super(ProvideHardNftInitial());

  BehaviorSubject<bool> visibleDropDownCountry = BehaviorSubject();
  // BehaviorSubject<bool> showItemProperties = BehaviorSubject();
  BehaviorSubject<List<PropertyModel>> showItemProperties = BehaviorSubject();
  //todo
  // Future<void> pickFile() async {
  //   collectionMessSubject.sink.add('');
  //   mediaType = '';
  //   final Map<String, dynamic> _mediaFile =
  //   await pickMediaFile(type: PickerType.MEDIA_FILE);
  //   mediaType = _mediaFile.getStringValue('type');
  //   final _path = _mediaFile.getStringValue('path');
  //   mediaFileSubject.sink.add(mediaType);
  //   if (_path.isNotEmpty) {
  //     final _isValidFormat = _mediaFile.getBoolValue('valid_format');
  //     final _extension = _mediaFile.getStringValue('extension');
  //     final _size = _mediaFile.intValue('size');
  //     fileType = '$mediaType/$_extension';
  //     if (50 < _size / 1000000) {
  //       clearMainData();
  //       collectionMessSubject.sink.add(S.current.maximum_file_size);
  //       createNftMapCheck['media_file'] = false;
  //     }
  //     if (!_isValidFormat) {
  //       clearMainData();
  //       collectionMessSubject.sink.add(S.current.invalid_file_format);
  //       createNftMapCheck['media_file'] = false;
  //     } else {
  //       mediaFileUploadTime = ipfsService.uploadTimeCalculate(_size);
  //       mediaFilePath = _path;
  //       createNftMapCheck['media_file'] = true;
  //       switch (mediaType) {
  //         case MEDIA_IMAGE_FILE:
  //           {
  //             imageFileSubject.sink.add(_path);
  //             break;
  //           }
  //         case MEDIA_VIDEO_FILE:
  //           {
  //             if (controller == null) {
  //               controller = VideoPlayerController.file(File(_path));
  //               await controller?.initialize();
  //               await controller?.setLooping(true);
  //               playVideoButtonSubject.sink.add(true);
  //               videoFileSubject.sink.add(controller!);
  //             }
  //             break;
  //           }
  //         case MEDIA_AUDIO_FILE:
  //           {
  //             await audioPlayer.play(_path, isLocal: true);
  //             await audioPlayer.pause();
  //             isPlayingAudioSubject.sink.add(false);
  //             audioFileSubject.sink.add(_path);
  //           }
  //           break;
  //         default:
  //           {
  //             break;
  //           }
  //       }
  //     }
  //   } else {
  //     createNftMapCheck['media_file'] = false;
  //   }
  //   validateCreate();
  // }


  List<PropertyModel> properties = [];

  void checkPropertiesWhenSave() {
    properties.forEach(
      (element) {
        properties.removeWhere(
          (element) => element.property.isEmpty || element.value.isEmpty,
        );
      },
    );
    if(properties.isEmpty) {
      showItemProperties.sink.add([]);
    } else {
      showItemProperties.sink.add(properties);
    }
  }

  void showHideDropDownBtn({
    DropDownBtnType? typeDropDown,
    bool? value,
  }) {
    if (typeDropDown != null) {
      switch (typeDropDown) {
        case DropDownBtnType.CITY:
          break;
        case DropDownBtnType.COUNTRY:
          visibleDropDownCountry.sink.add(value ?? true);
          break;
        default:
          break;
      }
    } else {
      visibleDropDownCountry.sink.add(false);
    }
  }
}
