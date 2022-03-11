import 'package:Dfy/data/request/create_hard_nft/create_hard_nft_assets_request.dart';
import 'package:Dfy/data/request/create_hard_nft/create_hard_nft_ipfs_request.dart';
import 'package:Dfy/data/response/create_hard_nft/collection_create_hard_nft.dart';
import 'package:Dfy/data/response/hard_nft_my_account/step1/asset_res.dart';
import 'package:Dfy/data/response/hard_nft_my_account/step1/cities_res.dart';
import 'package:Dfy/data/response/hard_nft_my_account/step1/condition_res.dart';
import 'package:Dfy/data/response/hard_nft_my_account/step1/country_res.dart';
import 'package:Dfy/data/response/hard_nft_my_account/step1/data_after_put_response.dart';
import 'package:Dfy/data/response/hard_nft_my_account/step1/hard_nft_type_select.dart';
import 'package:Dfy/data/response/hard_nft_my_account/step1/phone_code_res.dart';
import 'package:Dfy/data/response/hard_nft_my_account/step1/put_hard_nft_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/hard_nft_my_account/step1/step_1_service.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/asset_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/bc_txn_hash_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/city_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/collection_hard_nft.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/condition_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/country_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/hard_nft_type_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/item_data_after_put_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/phone_code_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/put_hard_nft_model.dart';
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

  @override
  Future<Result<AssetModel>> getAssetAfterPost(
      CreateHardNftAssetsRequest request) {
    return runCatchingAsync<AssetResponse, AssetModel>(
      () => _step1client.createHardNFTAssets(request),
      (response) => response.toModel(),
    );
  }

  @override
  Future<Result<ItemDataAfterPutModel>> getDetailAssetHardNFT(String assetId) {
    return runCatchingAsync<DataAfterPutResponse, ItemDataAfterPutModel>(
      () => _step1client.getDetailAssetHardNFT(assetId),
      (response) => response.toDomain() ?? ItemDataAfterPutModel(),
    );
  }

  @override
  Future<Result<PutHardNftModel>> getResponseAfterPut(
    String id,
    Map<String, dynamic> bcTxnHashJson,
  ) {
    return runCatchingAsync<PutHardNftResponse, PutHardNftModel>(
      () => _step1client.putHardNftBeforeConfirm(id, bcTxnHashJson),
      (response) => response.toModel() ?? PutHardNftModel(),
    );
  }

  @override
  Future<Result<List<CollectionHardNft>>> getCollectionHardNft() {
    return runCatchingAsync<CollectionCreateHardNftResponse,
        List<CollectionHardNft>>(
      () => _step1client.getCollectionHardNft(),
      (response) => response.rows?.map((e) => e.toModel()).toList() ?? [],
    );
  }
}
