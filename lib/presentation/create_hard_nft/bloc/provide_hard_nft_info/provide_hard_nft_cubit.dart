import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'provide_hard_nft_state.dart';

enum DropDownBtnType {
  CONDITION,
  COUNTRY,
  CITY,
}

class ProvideHardNftCubit extends Cubit<ProvideHardNftState> {
  ProvideHardNftCubit() : super(ProvideHardNftInitial());

  BehaviorSubject<bool> visibleDropDownCountry = BehaviorSubject();

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

  List<Map<String, String>> properties = [];

  //isValue ? value : property
  void saveProperties({
    required bool isValue,
    String? propertyForm,
    String? valueForm,
  }) {
    final Map<String, String> propertyMap = {};
    propertyMap.update(
      'value',
      (existingValue) => valueForm ?? '',
      ifAbsent: () => valueForm ?? '',
    );
    propertyMap.update(
      'property',
      (existingValue) => propertyForm ?? '',
      ifAbsent: () => propertyForm ?? '',
    );
    if (propertyForm != null && valueForm != null) {
      properties.add(propertyMap);
    } else {}
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
