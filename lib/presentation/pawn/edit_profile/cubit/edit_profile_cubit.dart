import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:Dfy/utils/pick_media_file.dart';
import 'package:Dfy/utils/upload_ipfs/pin_to_ipfs.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends BaseCubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  BehaviorSubject<String> errorName = BehaviorSubject.seeded('');
  BehaviorSubject<String> errorPhone = BehaviorSubject.seeded('');
  BehaviorSubject<String> errorAddress = BehaviorSubject.seeded('');
  BehaviorSubject<String> errorDescription = BehaviorSubject.seeded('');
  BehaviorSubject<bool> selectImage = BehaviorSubject.seeded(false);

  String mediaFileCid = '';
  String coverCid = '';
  String mediaFilePath = '';
  String coverPhotoPath = '';
  String fileType = '';

  final PinToIPFS ipfsService = PinToIPFS();

  Future<void> pickImage({bool isMainMedia = false}) async {
    showLoading();
    final _fileMap = await pickImageFunc(
      imageType: FEATURE_PHOTO,
      tittle: 'Pick Image',
      needCrop: false,
    );
    final _path = _fileMap.getStringValue(PATH_OF_FILE);
    if (_path.isNotEmpty) {
      final _imageSize = _fileMap.intValue(SIZE_OF_FILE);
      final _extension = _fileMap.getStringValue(EXTENSION_OF_FILE);
      if (isMainMedia) {
        if (_imageSize / 1048576 < 50) {
          fileType = '$MEDIA_IMAGE_FILE/$_extension';
          mediaFilePath = _path;
          mediaFileCid = ApiConstants.BASE_URL_IMAGE +
              await ipfsService.pinFileToIPFS(pathFile: mediaFilePath);
          selectImage.add(true);
        } else {
          //collectionMessSubject.sink.add(S.current.maximum_file_size);
        }
      } else {
        if (_imageSize / 1048576 < 50) {
          coverPhotoPath = _path;
          coverCid = ApiConstants.BASE_URL_IMAGE +
              await ipfsService.pinFileToIPFS(pathFile: coverPhotoPath);
          selectImage.add(true);
        } else {
          //coverPhotoMessSubject.sink.add(S.current.maximum_file_size);
        }
      }
    }
  }

  String date(int createAt) {
    final DateTime data = DateTime.fromMillisecondsSinceEpoch(
      createAt,
    );
    String month = '';
    switch (data.month) {
      case 1:
        month = S.current.january;
        break;
      case 2:
        month = S.current.february;
        break;
      case 3:
        month = S.current.march;
        break;
      case 4:
        month = S.current.april;
        break;
      case 5:
        month = S.current.may;
        break;
      case 6:
        month = S.current.june;
        break;
      case 7:
        month = S.current.july;
        break;
      case 8:
        month = S.current.august;
        break;
      case 9:
        month = S.current.september;
        break;
      case 10:
        month = S.current.october;
        break;
      case 11:
        month = S.current.november;
        break;
      case 12:
        month = S.current.december;
        break;
    }
    return '$month${data.year}';
  }
}
