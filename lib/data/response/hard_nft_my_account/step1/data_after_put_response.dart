
import 'package:Dfy/data/response/create_hard_nft/detail_asset_hard_nft_response.dart';
import 'package:Dfy/data/response/create_hard_nft/evaluators_response.dart';
import 'package:Dfy/data/response/hard_nft_my_account/step1/cities_res.dart';
import 'package:Dfy/domain/model/evaluation_hard_nft.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/asset_ft_contact_country.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/item_data_after_put_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/media_ft_document.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_after_put_response.g.dart';

@JsonSerializable()
class DataAfterPutResponse {
  @JsonKey(name: 'rc')
  int? rc;
  @JsonKey(name: 'rd')
  String? rd;
  @JsonKey(name: 'item')
  ItemDataAfterPutResponse? itemDataAfterPutResponse;
  @JsonKey(name: 'trace-id')
  String? traceId;

  DataAfterPutResponse(
    this.rc,
    this.rd,
    this.itemDataAfterPutResponse,
    this.traceId,
  );

  ItemDataAfterPutModel? toDomain() => itemDataAfterPutResponse?.toDomain();

  factory DataAfterPutResponse.fromJson(Map<String, dynamic> json) =>
      _$DataAfterPutResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataAfterPutResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class AdditionalInfoListResponse {
  @JsonKey(name: 'trait_type')
  String? traitType;
  @JsonKey(name: 'value')
  String? value;

  AdditionalInfoListResponse(this.traitType, this.value);

  factory AdditionalInfoListResponse.fromJson(Map<String, dynamic> json) =>
      _$AdditionalInfoListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdditionalInfoListResponseToJson(this);

  AdditionalInfo toModel() => AdditionalInfo(traitType, value);
}

@JsonSerializable()
class AssetFeatContactCountryResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;

  AssetFeatContactCountryResponse(this.id, this.name);

  factory AssetFeatContactCountryResponse.fromJson(Map<String, dynamic> json) =>
      _$AssetFeatContactCountryResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AssetFeatContactCountryResponseToJson(this);

  AssetFeatContactCountryModel toDomain() =>
      AssetFeatContactCountryModel(id, name);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class MediaFeatDocumentResponse {
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'cid')
  String? cid;

  MediaFeatDocumentResponse(this.name, this.cid, this.type);

  factory MediaFeatDocumentResponse.fromJson(Map<String, dynamic> json) =>
      _$MediaFeatDocumentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MediaFeatDocumentResponseToJson(this);

  MediaFeatDocumentModel toModel() => MediaFeatDocumentModel(name, type, cid);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class ItemDataAfterPutResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'asset_type')
  AssetFeatContactCountryResponse assetType;
  @JsonKey(name: 'wallet_address')
  String? walletAddress;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'expecting_price')
  double? expectingPrice;
  @JsonKey(name: 'expecting_price_symbol')
  String? expectingPriceSymbol;
  @JsonKey(name: 'additional_information')
  String? additionalInfo;
  @JsonKey(name: 'additional_info_list')
  List<AdditionalInfoListResponse>? additionalInfoList;
  @JsonKey(name: 'contact_name')
  String? contactName;
  @JsonKey(name: 'contact_email')
  String? contactEmail;
  @JsonKey(name: 'contact_address')
  String? contactAddress;
  @JsonKey(name: 'contact_phone_code')
  PhoneCodeResponse? contactPhoneCode;
  @JsonKey(name: 'contact_phone')
  String? contactPhone;
  @JsonKey(name: 'contact_country')
  AssetFeatContactCountryResponse? contactCountry;
  @JsonKey(name: 'contact_city')
  CityResponse? contactCity;
  @JsonKey(name: 'request_id')
  String? requestId;
  @JsonKey(name: 'collection')
  CollectionResponse? collection;
  @JsonKey(name: 'display_status')
  int? displayStatus;
  @JsonKey(name: 'condition')
  AssetFeatContactCountryResponse? condition;
  @JsonKey(name: 'document_list')
  List<MediaFeatDocumentResponse>? documentList;
  @JsonKey(name: 'media_list')
  List<MediaFeatDocumentResponse>? mediaList;
  @JsonKey(name: 'bc_txn_hash')
  String? bcTxnHash;
  @JsonKey(name: 'asset_cid')
  String? assetCid;
  @JsonKey(name: 'ipfs_status')
  int? ipfsStatus;
  @JsonKey(name: 'bc_asset_id')
  int? bcAssetId;

  ItemDataAfterPutResponse(
    this.id,
    this.status,
    this.assetType,
    this.walletAddress,
    this.name,
    this.expectingPrice,
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
    this.collection,
    this.displayStatus,
    this.condition,
    this.documentList,
    this.mediaList,
    this.bcTxnHash,
    this.assetCid,
    this.ipfsStatus,
    this.bcAssetId,
  );

  ItemDataAfterPutModel toDomain() => ItemDataAfterPutModel(
        id: id,
        status: status,
        assetType: assetType.toDomain(),
        walletAddress: walletAddress,
        expectingPrice: expectingPrice,
        name: name,
        expectingPriceSymbol: expectingPriceSymbol,
        additionalInfo: additionalInfo,
        additionalInfoList:
            additionalInfoList?.map((e) => e.toModel()).toList(),
        contactName: contactName,
        contactEmail: contactEmail,
        contactAddress: contactAddress,
        contactPhoneCode: contactPhoneCode?.toDomain(),
        contactPhone: contactPhone,
        contactCountry: contactCountry?.toDomain(),
        contactCity: contactCity?.toModel(),
        requestId: requestId,
        displayStatus: displayStatus,
        collection: collection?.toDomain(),
        condition: condition?.toDomain(),
        documentList: documentList?.map((e) => e.toModel()).toList(),
        mediaList: mediaList?.map((e) => e.toModel()).toList(),
        bcTxnHash: bcTxnHash,
        assetCid: assetCid,
        ipfsStatus: ipfsStatus,
        bcAssetId: bcAssetId,
      );

  factory ItemDataAfterPutResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemDataAfterPutResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ItemDataAfterPutResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
