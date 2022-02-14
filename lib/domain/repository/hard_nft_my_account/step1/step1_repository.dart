import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/city_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/condition_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/country_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/hard_nft_type_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/phone_code_model.dart';

mixin Step1Repository {
  Future<Result<List<PhoneCodeModel>>> getPhoneCode();

  Future<Result<List<CountryModel>>> getCountries();

  Future<Result<List<ConditionModel>>> getConditions();

  Future<Result<List<CityModel>>> getCities(String id);

  Future<Result<List<HardNftTypeModel>>> getHardNftTypes();
}
