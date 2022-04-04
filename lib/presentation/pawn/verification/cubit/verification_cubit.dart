import 'dart:math';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/city_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/country_model.dart';
import 'package:Dfy/domain/model/pawn/user_profile.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/domain/repository/hard_nft_my_account/step1/step1_repository.dart';
import 'package:Dfy/domain/repository/home_pawn/user_repository.dart';
import 'package:Dfy/presentation/pawn/edit_profile/cubit/edit_profile_cubit.dart';
import 'package:Dfy/presentation/pawn/verification/ui/step_two_verify.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:Dfy/utils/pick_media_file.dart';
import 'package:Dfy/utils/upload_ipfs/pin_to_ipfs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../main.dart';

part 'verification_state.dart';

class VerificationCubit extends BaseCubit<VerificationState> {
  VerificationCubit() : super(VerificationInitial());

  BehaviorSubject<String> errorFirstName = BehaviorSubject.seeded('');
  BehaviorSubject<String> errorId = BehaviorSubject.seeded('');
  BehaviorSubject<String> errorBackPhoto = BehaviorSubject.seeded('');
  BehaviorSubject<String> errorFrontPhoto = BehaviorSubject.seeded('');
  BehaviorSubject<String> errorSelfiePhoto = BehaviorSubject.seeded('');
  BehaviorSubject<String> reward = BehaviorSubject.seeded('');
  BehaviorSubject<String> errorLastName = BehaviorSubject.seeded('');
  BehaviorSubject<CountryModel> country = BehaviorSubject();
  BehaviorSubject<CityModel> city = BehaviorSubject();
  BehaviorSubject<int> selectBirth = BehaviorSubject.seeded(0);
  BehaviorSubject<List<CountryModel>> streamCountry =
      BehaviorSubject.seeded([]);
  BehaviorSubject<List<CityModel>> streamCity = BehaviorSubject.seeded([]);

  UsersRepository get _repo => Get.find();

  Step1Repository get _step1Repository => Get.find();

  Identity type = Identity.CC_ID;

  UserProfile userProfile = UserProfile();

  Future<void> getCountriesApi() async {
    final Result<List<CountryModel>> resultCountries =
        await _step1Repository.getCountries();
    resultCountries.when(
      success: (res) {
        listCountry = res;
        streamCountry.add(listCountry);
      },
      error: (error) {},
    );
  }

  Future<void> getDetailKYC() async {
    showLoading();
    final Result<UserProfile> result = await _repo.getMyUserProfile();
    result.when(
      success: (res) {
        showContent();
        userProfile = res;
        emit(VerificationSuccess());
      },
      error: (err) {},
    );
  }

  List<CountryModel> listCountry = [];
  List<CityModel> listCity = [];

  Future<void> getCites(String id) async {
    listCity.clear();
    final Result<List<CityModel>> resultCities =
        await _step1Repository.getCities(id);
    resultCities.when(
      success: (res) {
        listCity = res;
        streamCity.add(listCity);
      },
      error: (error) {},
    );
  }

  bool checkRequire({
    String? firsName,
    String? lastName,
    String? middleName,
    int? dateOfBirth,
    CountryModel? country,
    CityModel? cities,
    String? address,
  }) {
    if (firsName != '' && lastName != '' && address != '') {
      setInfo(
        firsName: firsName,
        lastName: lastName,
        middleName: middleName,
        dateOfBirth: dateOfBirth,
        country: country,
        cities: cities,
        address: address,
      );
      return true;
    } else {
      if (firsName == '') {
        errorFirstName.add('First name is required');
      }
      if (lastName == '') {
        errorLastName.add('Last name is required');
      }
      return false;
    }
  }

  void setInfo({
    String? firsName,
    String? lastName,
    String? middleName,
    int? dateOfBirth,
    CountryModel? country,
    CityModel? cities,
    String? address,
  }) {
    if (userProfile.kyc != null) {
      userProfile.kyc?.firstName = firsName;
      userProfile.kyc?.lastName = lastName;
      userProfile.kyc?.middleName = middleName;
      userProfile.kyc?.dateOfBirth = dateOfBirth;
      userProfile.kyc?.country = country;
      userProfile.kyc?.city = cities;
      userProfile.kyc?.address = address;
    } else {
      userProfile.kyc = KYC(
        firstName: firsName,
        lastName: lastName,
        middleName: middleName,
        dateOfBirth: dateOfBirth,
        country: country,
        city: cities,
        address: address,
      );
    }
  }

  void searchCountry(String value) {
    final List<CountryModel> search = [];
    for (final element in listCountry) {
      if ((element.name ?? '').toLowerCase().contains(value.toLowerCase())) {
        search.add(element);
      }
    }
    if (value.isEmpty) {
      streamCountry.add(listCountry);
    } else {
      streamCountry.add(search);
    }
  }

  void searchCities(String value) {
    final List<CityModel> search = [];
    for (final element in listCity) {
      if ((element.name ?? '').toLowerCase().contains(value.toLowerCase())) {
        search.add(element);
      }
    }
    if (value.isEmpty) {
      streamCity.add(listCity);
    } else {
      streamCity.add(search);
    }
  }

  /// Pick file

  final PinToIPFS ipfsService = PinToIPFS();
  String mediaFrontFileCid = '';
  String mediaFrontFilePath = '';
  String mediaBackFileCid = '';
  String mediaBackFilePath = '';
  String mediaSelfiePath = '';
  String mediaSelfieCid = '';
  BehaviorSubject<String> pickFrontFile = BehaviorSubject.seeded('');
  BehaviorSubject<String> pickBackFile = BehaviorSubject.seeded('');
  BehaviorSubject<String> pickSelfieFile = BehaviorSubject.seeded('');
  BehaviorSubject<StatusPickFile> selectBackImage =
      BehaviorSubject.seeded(StatusPickFile.START);
  BehaviorSubject<StatusPickFile> selectFrontImage =
      BehaviorSubject.seeded(StatusPickFile.START);
  BehaviorSubject<StatusPickFile> selectSelfieImage =
      BehaviorSubject.seeded(StatusPickFile.START);
  String fileFrontType = '';
  String fileBackType = '';
  String fileSelfieType = '';

  Future<void> pickImage({bool isBackMedia = false}) async {
    // final _fileMap = await pickImageFunc(
    //   imageType: FEATURE_PHOTO,
    //   tittle: 'Pick Image',
    //   needCrop: false,
    // );
    final _fileMap = await pickMediaFile(
      type: PickerType.IMAGE_FILE,
    );
    final _path = _fileMap.getStringValue(PATH_OF_FILE);
    if (_path.isNotEmpty) {
      final _imageSize = _fileMap.intValue(SIZE_OF_FILE);
      final _extension = _fileMap.getStringValue(EXTENSION_OF_FILE);
      if (isBackMedia) {
        selectFrontImage.add(StatusPickFile.PICK_FILE);
        if (_imageSize / 1048576 < 50) {
          errorFrontPhoto.add('');
          fileFrontType = '$MEDIA_IMAGE_FILE/$_extension';
          mediaFrontFilePath = _path;
          pickFrontFile.add(mediaFrontFilePath);
          selectFrontImage.add(StatusPickFile.PICK_SUCCESS);
        } else {
          selectFrontImage.add(StatusPickFile.PICK_ERROR);
        }
      } else {
        selectBackImage.add(StatusPickFile.PICK_FILE);
        if (_imageSize / 1048576 < 50) {
          errorBackPhoto.add('');
          fileBackType = '$MEDIA_IMAGE_FILE/$_extension';
          mediaBackFilePath = _path;
          pickBackFile.add(mediaBackFilePath);
          selectBackImage.add(StatusPickFile.PICK_SUCCESS);
        } else {
          selectBackImage.add(StatusPickFile.PICK_ERROR);
        }
      }
    } else {
      selectFrontImage.add(StatusPickFile.START);
      selectBackImage.add(StatusPickFile.START);
    }
  }

  Future<void> pickSelfieImage() async {
    final _fileMap = await pickMediaFile(
      type: PickerType.IMAGE_FILE,
    );
    final _path = _fileMap.getStringValue(PATH_OF_FILE);

    if (_path.isNotEmpty) {
      final _imageSize = _fileMap.intValue(SIZE_OF_FILE);
      final _extension = _fileMap.getStringValue(EXTENSION_OF_FILE);
      selectSelfieImage.add(StatusPickFile.PICK_FILE);
      if (_imageSize / 1048576 < 50) {
        errorSelfiePhoto.add('');
        fileSelfieType = '$MEDIA_IMAGE_FILE/$_extension';
        mediaSelfiePath = _path;
        pickSelfieFile.add(mediaSelfiePath);
        mediaSelfieCid = ApiConstants.BASE_URL_IMAGE +
            await ipfsService.pinFileToIPFS(pathFile: mediaSelfiePath);
        selectSelfieImage.add(StatusPickFile.PICK_SUCCESS);
      } else {
        selectSelfieImage.add(StatusPickFile.PICK_ERROR);
      }
    }
  }

  Future<void> upLoadImage() async {
    mediaBackFileCid = ApiConstants.BASE_URL_IMAGE +
        await ipfsService.pinFileToIPFS(pathFile: mediaBackFilePath);

    mediaFrontFileCid = ApiConstants.BASE_URL_IMAGE +
        await ipfsService.pinFileToIPFS(pathFile: mediaFrontFilePath);

    userProfile.kyc?.backPhoto = mediaBackFileCid;
    userProfile.kyc?.frontPhoto = mediaFrontFileCid;
  }

  bool checkData(String ccId, String dvId, String ppId) {
    if (type == Identity.CC_ID || type == Identity.DV_ID) {
      if ((ccId != '' || dvId != '') &&
          mediaFrontFilePath != '' &&
          mediaBackFilePath != '') {
        if(type == Identity.CC_ID ){
          userProfile.kyc?.kycNumber = ccId;
        }
        else {
          userProfile.kyc?.kycNumber = dvId;
        }
        return true;
      } else {
        if (ccId == '' || dvId == '') {
          errorId.add('Param is required');
        }
        if (mediaBackFilePath == '') {
          errorBackPhoto.add('Image is required');
        } else {
          errorBackPhoto.add('');
        }
        if (mediaFrontFilePath == '') {
          errorFrontPhoto.add('Image is required');
        } else {
          errorFrontPhoto.add('');
        }
        return false;
      }
    } else {
      if (ppId != '' && mediaFrontFilePath != '') {
        userProfile.kyc?.kycNumber = ppId;
        return true;
      } else {
        if (ppId == '') {
          errorId.add('Param is required');
        }
        if (mediaFrontFilePath == '') {
          errorFrontPhoto.add('Image is required');
        } else {
          errorBackPhoto.add('');
        }
        return false;
      }
    }
  }

  void clearImage(bool frontPhoto) {
    if (frontPhoto) {
      mediaFrontFilePath = '';
      pickFrontFile.add(mediaFrontFilePath);
    } else {
      mediaBackFilePath = '';
      pickBackFile.add(mediaBackFilePath);
    }
  }

  void clearImageSelfie() {
    mediaSelfiePath = '';
    pickSelfieFile.add(mediaSelfiePath);
  }

  Future<void> getReward() async {
    final Result<int> result = await _repo.getReward();
    result.when(
      success: (res) {
        reward.add(res.toString());
      },
      error: (err) {},
    );
  }
  List<Wallet> listWallet = [];
  BehaviorSubject<String> walletAddress = BehaviorSubject.seeded('');

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'getListWalletsCallback':
        listWallet.clear();
        final List<dynamic> data = methodCall.arguments;
        for (final element in data) {
          listWallet.add(Wallet.fromJson(element));
        }
        walletAddress.add(listWallet.first.address ?? '');
        break;
    }
    }
  Future<void> getListWallets() async {
    try {
      final data = {};
      await trustWalletChannel.invokeMethod('getListWallets', data);
    } on PlatformException {
      //nothing
    }
  }
  int randomAvatar() {
    final Random rd = Random();

    return rd.nextInt(10);
  }


  Future<void> putDataKYC() async {
    Map<String,dynamic> map = {
      'address': userProfile.kyc?.address,
      'backPhoto': userProfile.kyc?.backPhoto,
      'cityID':userProfile.kyc?.city?.id,
      'countryId':userProfile.kyc?.country?.id,
      'dateOfBirth': selectBirth.value,
      'id': userProfile.kyc?.id ?? 0,
      'kycNumber': userProfile.kyc?.kycNumber,
      'lastName': userProfile.kyc?.lastName,
      'middleName': userProfile.kyc?.middleName,
      'firstName': userProfile.kyc?.firstName,
      'frontPhoto': userProfile.kyc?.frontPhoto,
      'name': '${userProfile.kyc?.firstName} ${userProfile.kyc?.middleName} ${userProfile.kyc?.lastName}',
      'selfiePhoto': mediaSelfieCid,
      'typePhoto': 0,
      'userID': userProfile.id,
      'walletAddress':walletAddress.value,
    };
    final Result<KYC> result = await _repo.putKYCtoBE(map:map);
    result.when(
      success: (res) {
      },
      error: (err) {},
    );
  }
}
