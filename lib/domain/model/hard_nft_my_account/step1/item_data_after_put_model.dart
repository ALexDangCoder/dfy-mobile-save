import 'package:Dfy/data/response/create_hard_nft/detail_asset_hard_nft_response.dart';
import 'package:Dfy/domain/model/collection.dart';
import 'package:Dfy/domain/model/evaluation_hard_nft.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/asset_ft_contact_country.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/city_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/condition_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/media_ft_document.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/phone_code_model.dart';
import 'package:Dfy/domain/model/market_place/collection_market_model.dart';
import 'package:Dfy/domain/model/market_place/detail_asset_hard_nft.dart';
import 'package:Dfy/domain/model/market_place/evaluator_detail.dart';

class ItemDataAfterPutModel {
  String? id;
  int? status;
  AssetFeatContactCountryModel? assetType;
  String? walletAddress;
  double? expectingPrice;
  String? name;
  String? expectingPriceSymbol;
  String? additionalInfo;
  List<AdditionalInfo>? additionalInfoList;
  String? contactName;
  String? contactEmail;
  String? contactAddress;
  PhoneCode? contactPhoneCode;
  String? contactPhone;
  AssetFeatContactCountryModel? contactCountry;
  CityModel? contactCity;
  String? requestId;
  int? displayStatus;
  CollectionAssetHardNft? collection;
  AssetFeatContactCountryModel? condition;
  List<MediaFeatDocumentModel>? documentList;
  List<MediaFeatDocumentModel>? mediaList;
  String? bcTxnHash;
  String? assetCid;
  int? ipfsStatus;
  int? bcAssetId;

  ItemDataAfterPutModel({
    this.id,
    this.status,
    this.assetType,
    this.walletAddress,
    this.expectingPrice,
    this.name,
    this.expectingPriceSymbol,
    this.additionalInfo,
    this.additionalInfoList,
    this.contactName,
    this.contactEmail,
    this.contactAddress,
    this.contactPhoneCode,
    this.contactPhone,
    this.contactCountry,
    this.contactCity,
    this.requestId,
    this.displayStatus,
    this.collection,
    this.condition,
    this.documentList,
    this.mediaList,
    this.bcTxnHash,
    this.assetCid,
    this.ipfsStatus,
    this.bcAssetId,
  });
}
