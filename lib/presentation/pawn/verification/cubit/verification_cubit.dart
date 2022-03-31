import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/city_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/country_model.dart';
import 'package:Dfy/domain/model/pawn/user_profile.dart';
import 'package:Dfy/domain/repository/hard_nft_my_account/step1/step1_repository.dart';
import 'package:Dfy/domain/repository/home_pawn/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'verification_state.dart';

class VerificationCubit extends BaseCubit<VerificationState> {
  VerificationCubit() : super(VerificationInitial());

  BehaviorSubject<String> errorFirstName = BehaviorSubject.seeded('');
  BehaviorSubject<String> errorLastName = BehaviorSubject.seeded('');
  BehaviorSubject<CountryModel> country = BehaviorSubject();
  BehaviorSubject<CityModel> city = BehaviorSubject();
  BehaviorSubject<int> selectBirth = BehaviorSubject.seeded(0);
  BehaviorSubject<List<CountryModel>> streamCountry =
      BehaviorSubject.seeded([]);
  BehaviorSubject<List<CityModel>> streamCity = BehaviorSubject.seeded([]);

  UsersRepository get _repo => Get.find();

  Step1Repository get _step1Repository => Get.find();

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
}
