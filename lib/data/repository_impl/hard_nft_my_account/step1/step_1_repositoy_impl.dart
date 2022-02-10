import 'package:Dfy/data/response/hard_nft_my_account/step1/cities_res.dart';
import 'package:Dfy/data/response/hard_nft_my_account/step1/condition_res.dart';
import 'package:Dfy/data/response/hard_nft_my_account/step1/country_res.dart';
import 'package:Dfy/data/response/hard_nft_my_account/step1/hard_nft_type_select.dart';
import 'package:Dfy/data/response/hard_nft_my_account/step1/phone_code_res.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/hard_nft_my_account/step1/step_1_service.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/city_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/condition_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/country_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/hard_nft_type_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/phone_code_model.dart';
import 'package:Dfy/domain/repository/hard_nft_my_account/step1/step1_repository.dart';

class Step1RepositoryImpl implements Step1Repository {
  final Step1Client _step1client;

  Step1RepositoryImpl(this._step1client);

  @override
  Future<Result<List<PhoneCodeModel>>> getPhoneCode() {
    return runCatchingAsync<ListPhoneCodeResponse, List<PhoneCodeModel>>(
      () => _step1client.getPhoneCode(),
      (response) => response.toDomain() ?? [],
    );
  }

  @override
  Future<Result<List<CountryModel>>> getCountries() {
    return runCatchingAsync<ListCountryResponse, List<CountryModel>>(
      () => _step1client.getCountries(),
      (response) => response.toDomain() ?? [],
    );
  }

  @override
  Future<Result<List<CityModel>>> getCities(String id) {
    return runCatchingAsync<CitiesResponse, List<CityModel>>(
      () => _step1client.getCities(id),
      (response) => response.toDomain() ?? [],
    );
  }

  @override
  Future<Result<List<ConditionModel>>> getConditions() {
    return runCatchingAsync<ListConditionResponse, List<ConditionModel>>(
      () => _step1client.getConditions(),
      (response) => response.toDomain() ?? [],
    );
  }

  @override
  Future<Result<List<HardNftTypeModel>>> getHardNftTypes() {
    return runCatchingAsync<ListHardNFTTypeResponse, List<HardNftTypeModel>>(
      () => _step1client.getNFTTypes(),
      (response) => response.toDomain() ?? [],
    );
  }
}
