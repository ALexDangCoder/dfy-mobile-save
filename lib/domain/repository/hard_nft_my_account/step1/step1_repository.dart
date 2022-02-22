import 'package:Dfy/data/request/create_hard_nft/create_hard_nft_assets_request.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/asset_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/bc_txn_hash_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/city_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/condition_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/country_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/hard_nft_type_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/item_data_after_put_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/phone_code_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/put_hard_nft_model.dart';

mixin Step1Repository {
  Future<Result<List<PhoneCodeModel>>> getPhoneCode();

  Future<Result<List<CountryModel>>> getCountries();

  Future<Result<List<ConditionModel>>> getConditions();

  Future<Result<List<CityModel>>> getCities(String id);

  Future<Result<List<HardNftTypeModel>>> getHardNftTypes();

  Future<Result<AssetModel>> getAssetAfterPost(
    CreateHardNftAssetsRequest request,
  );

  Future<Result<ItemDataAfterPutModel>> getDetailAssetHardNFT(
    String assetId,
  );

  Future<Result<PutHardNftModel>> getResponseAfterPut(
    String id,
    Map<String, dynamic> bcTxnHashJson,
  );
}
