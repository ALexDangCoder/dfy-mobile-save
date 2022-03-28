import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/city_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/country_model.dart';
import 'package:Dfy/domain/repository/hard_nft_my_account/step1/step1_repository.dart';
import 'package:Dfy/domain/repository/home_pawn/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'edit_personal_info_state.dart';

enum CheckList { COUNTRY, CITIES }

class EditPersonalInfoCubit extends BaseCubit<EditPersonalInfoState> {
  EditPersonalInfoCubit() : super(EditPersonalInfoInitial());

  BehaviorSubject<String> errorName = BehaviorSubject.seeded('');
  BehaviorSubject<String> errorFirstName = BehaviorSubject.seeded('');
  BehaviorSubject<String> errorLastName = BehaviorSubject.seeded('');
  BehaviorSubject<String> errorAddress = BehaviorSubject.seeded('');
  BehaviorSubject<String> errorPersonalLink = BehaviorSubject.seeded('');
  BehaviorSubject<String> errorPersonalLink2 = BehaviorSubject.seeded('');
  BehaviorSubject<String> errorPersonalLink3 = BehaviorSubject.seeded('');
  BehaviorSubject<String> errorPersonalLink4 = BehaviorSubject.seeded('');
  BehaviorSubject<String> errorPersonalLink5 = BehaviorSubject.seeded('');
  List<BehaviorSubject<String>> listErrorPersonalLink = [];
  BehaviorSubject<CountryModel> country = BehaviorSubject();
  BehaviorSubject<CityModel> city = BehaviorSubject();
  BehaviorSubject<int> selectBirth = BehaviorSubject.seeded(0);
  BehaviorSubject<List<CountryModel>> streamCountry =
      BehaviorSubject.seeded([]);
  BehaviorSubject<List<CityModel>> streamCity = BehaviorSubject.seeded([]);
  BehaviorSubject<int> personalLinkStream = BehaviorSubject();
  List<String> personalLink = [];

  Step1Repository get _step1Repository => Get.find();

  Future<void> getCites(String id) async {
    listCity.clear();
    final Result<List<CityModel>> resultCities =
        await _step1Repository.getCities(id.toString());
    resultCities.when(
      success: (res) {
        listCity = res;
      },
      error: (error) {},
    );
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

  List<CountryModel> listCountry = [];
  List<CityModel> listCity = [];

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

  UsersRepository get _repo => Get.find();

  Future<void> updateData({
    String? name,
    String? address,
    String? countryId,
    String? cityId,
    int? dateOfBirth,
    String? firstName,
    String? lastName,
    String? id,
    String? middleName,
    List<String>? list,
  }) async {
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(dateOfBirth ?? 0);
    final Map<String,dynamic> map;
    if(name == ''){
    map = {
      'kyc': {
        'address': address,
        'cityId': cityId,
        'countryId': countryId,
        'dateOfBirth': {
          'date': dateOfBirth,
          'day': date.day,
          'hours': date.hour,
          'minutes': date.minute,
          'month': date.month,
          'nanos': date.microsecondsSinceEpoch,
          'seconds': date.second,
          'time': dateOfBirth,
          'timezoneOffset': 0,
          'year': date.year,
        },
        'firstName': firstName,
        'id': id,
        'lastName': lastName,
        'middleName': middleName,
      },
      'links': list,
      'name': '$firstName $middleName $lastName',
    };
    } else {
      map = {
        'links': list,
        'name': name,
      };
    }
    final Result<String> code = await _repo.saveDataPersonalToBe(map: map);
    code.when(
      success: (res) {},
      error: (error) {},
    );
  }

  List<String> getListLink(String text, List<TextEditingController> list) {
    if (list.isNotEmpty) {
      final List<String> addLink = [text];
      for (final element in list) {
        if (element.text != '') {
          addLink.add(element.text);
        }
      }
      return addLink;
    } else {
      return [text];
    }
  }
}
