import 'package:Dfy/domain/model/market_place/detail_asset_hard_nft.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detail_asset_hard_nft_response.g.dart';

@JsonSerializable()
class DetailAssetHardNftResponse extends Equatable {
  @JsonKey(name: 'rd')
  String? rd;

  @JsonKey(name: 'rc')
  int? rc;

  @JsonKey(name: 'trace-id')
  String? traceId;

  @JsonKey(name: 'item')
  ItemDetailAssetHardNftResponse? item;

  DetailAssetHardNftResponse(
    this.rd,
    this.rc,
    this.traceId,
    this.item,
  );

  factory DetailAssetHardNftResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailAssetHardNftResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailAssetHardNftResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class ItemDetailAssetHardNftResponse extends Equatable {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'asset_type')
  ContactCountryResponse? assetType;
  @JsonKey(name: 'wallet_address')
  String? walletAddress;
  @JsonKey(name: 'expecting_price')
  double? expectingPrice;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'expecting_price_symbol')
  String? expectingPriceSymbol;
  @JsonKey(name: 'additional_information')
  String? additionalInformation;
  @JsonKey(name: 'contact_name')
  String? contactName;
  @JsonKey(name: 'contact_email')
  String? contactEmail;
  @JsonKey(name: 'contact_address')
  String? contactAddress;
  @JsonKey(name: 'contact_phone_code')
  ContactPhoneCodeResponse? contactPhoneCode;
  @JsonKey(name: 'nft')
  NFTResponse nftResponse;
  @JsonKey(name: 'contact_phone')
  String? contactPhone;
  @JsonKey(name: 'contact_country')
  ContactCountryResponse? contactCountry;
  @JsonKey(name: 'contact_city')
  ContactCityResponse? contactCity;
  @JsonKey(name: 'request_id')
  String? requestId;
  @JsonKey(name: 'display_status')
  int? displayStatus;
  @JsonKey(name: 'collection')
  CollectionResponse? collection;
  @JsonKey(name: 'condition')
  ContactCountryResponse? condition;
  @JsonKey(name: 'media_list')
  List<MediaListResponse>? mediaList;
  @JsonKey(name: 'bc_txn_hash')
  String? bcTxnHash;
  @JsonKey(name: 'asset_cid')
  String? assetCid;
  @JsonKey(name: 'ipfs_status')
  int? ipfsStatus;
  @JsonKey(name: 'bc_asset_id')
  int? bcAssetId;

  ItemDetailAssetHardNftResponse(
    this.id,
    this.status,
    this.assetType,
    this.walletAddress,
    this.expectingPrice,
    this.name,
    this.expectingPriceSymbol,
    this.additionalInformation,
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
    this.mediaList,
    this.bcTxnHash,
    this.assetCid,
    this.ipfsStatus,
    this.bcAssetId,
    this.nftResponse,
  );

  factory ItemDetailAssetHardNftResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemDetailAssetHardNftResponseFromJson(json);

  DetailAssetHardNft toDomain() => DetailAssetHardNft(
        bcTxnHash: bcTxnHash,
        requestId: requestId,
        status: status,
        id: id,
        name: name,
        contactName: contactName,
        assetType: assetType,
        expectingPrice: expectingPrice,
        additionalInformation: additionalInformation,
        assetCid: assetCid,
        bcAssetId: bcAssetId,
        collection: collection,
        condition: condition,
        contactAddress: contactAddress,
        contactCity: contactCity,
        contactCountry: contactCountry,
        contactEmail: contactEmail,
        contactPhone: contactPhone,
        contactPhoneCode: contactPhoneCode,
        displayStatus: displayStatus,
        expectingPriceSymbol: expectingPriceSymbol,
        ipfsStatus: ipfsStatus,
        mediaList: mediaList,
        walletAddress: walletAddress,
        nftAssetHard: nftResponse,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class ContactPhoneCodeResponse extends Equatable {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'code')
  String? code;

  ContactPhoneCodeResponse(
    this.id,
    this.name,
    this.code,
  );

  factory ContactPhoneCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactPhoneCodeResponseFromJson(json);

  ContactPhoneCodeAssetHardNft toDomain() => ContactPhoneCodeAssetHardNft(
        id: id,
        name: name,
        code: code,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}


@JsonSerializable()
class NFTResponse extends Equatable {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'media_cid')
  String? mediaId;
  @JsonKey(name: 'cover_cid')
  String? coverId;
  @JsonKey(name: 'number_of_copies')
  int? numberOfCopies;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'bc_token_id')
  int? bcTokenId;
  @JsonKey(name: 'nft_cid')
  String? nftId;
  @JsonKey(name: 'asset_id')
  String? assetId;

  NFTResponse(
    this.id,
    this.name,
    this.mediaId,
    this.coverId,
    this.numberOfCopies,
    this.status,
    this.bcTokenId,
    this.nftId,
    this.assetId,
  );

  factory NFTResponse.fromJson(Map<String, dynamic> json) =>
      _$NFTResponseFromJson(json);

  NFTAssetHard toDomain() => NFTAssetHard(
        id: id,
        name: name,
        mediaId: mediaId,
        coverId: coverId,
        numberOfCopies: numberOfCopies,
        status: status,
        bcTokenId: bcTokenId,
        nftId: nftId,
        assetId: assetId,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class ContactCountryResponse extends Equatable {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;

  ContactCountryResponse(
    this.id,
    this.name,
  );

  factory ContactCountryResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactCountryResponseFromJson(json);

  ContactCountryAssetHardNft toDomain() => ContactCountryAssetHardNft(
        id: id,
        name: name,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class CollectionResponse extends Equatable {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'avatar_cid')
  String? avatarCid;
  @JsonKey(name: 'cover_cid')
  String? coverCid;
  @JsonKey(name: 'feature_cid')
  String? featureCid;
  @JsonKey(name: 'custom_url')
  String? customUrl;
  @JsonKey(name: 'royalty_rate')
  double? royaltyRate;
  @JsonKey(name: 'bc_txn_hash')
  String? bcTxnHash;
  @JsonKey(name: 'collection_cid')
  String? collectionCid;
  @JsonKey(name: 'wallet_address')
  String? walletAddress;
  @JsonKey(name: 'collection_type')
  CollectionTypeRespone? collectionType;
  @JsonKey(name: 'is_whitelist')
  bool? isWhitelist;
  @JsonKey(name: 'latitude')
  String? latitude;
  @JsonKey(name: 'longitude')
  String? longitude;

  CollectionResponse(
    this.id,
    this.name,
    this.description,
    this.avatarCid,
    this.coverCid,
    this.featureCid,
    this.customUrl,
    this.royaltyRate,
    this.bcTxnHash,
    this.collectionCid,
    this.walletAddress,
    this.collectionType,
    this.isWhitelist,
    this.latitude,
    this.longitude,
  );

  factory CollectionResponse.fromJson(Map<String, dynamic> json) =>
      _$CollectionResponseFromJson(json);

  CollectionAssetHardNft toDomain() => CollectionAssetHardNft(
        id: id,
        name: name,
        walletAddress: walletAddress,
        bcTxnHash: bcTxnHash,
        collectionType: collectionType,
        avatarCid: avatarCid,
        collectionCid: collectionCid,
        coverCid: coverCid,
        customUrl: customUrl,
        description: description,
        featureCid: featureCid,
        isWhitelist: isWhitelist,
        latitude: latitude,
        longitude: longitude,
        royaltyRate: royaltyRate,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class CollectionTypeRespone extends Equatable {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'standard')
  int? standard;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'type')
  int? type;

  CollectionTypeRespone(
    this.id,
    this.standard,
    this.name,
    this.description,
    this.type,
  );

  factory CollectionTypeRespone.fromJson(Map<String, dynamic> json) =>
      _$CollectionTypeResponeFromJson(json);

  CollectionTypeAssetHardNft toDomain() => CollectionTypeAssetHardNft(
        id: id,
        name: name,
        description: description,
        standard: standard,
        type: type,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class ContactCityResponse extends Equatable {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'country_id')
  int? countryId;
  @JsonKey(name: 'latitude')
  double? latitude;
  @JsonKey(name: 'longitude')
  double? longitude;

  ContactCityResponse(
    this.id,
    this.name,
    this.countryId,
    this.latitude,
    this.longitude,
  );

  factory ContactCityResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactCityResponseFromJson(json);

  ContactCityAssetHardNft toDomain() => ContactCityAssetHardNft(
        id: id,
        name: name,
        longitude: longitude,
        latitude: latitude,
        countryId: countryId,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class MediaListResponse extends Equatable {
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'cid')
  String? cid;

  MediaListResponse(
    this.name,
    this.type,
    this.cid,
  );

  factory MediaListResponse.fromJson(Map<String, dynamic> json) =>
      _$MediaListResponseFromJson(json);

  MediaListAssetHardNft toDomain() => MediaListAssetHardNft(
        name: name,
        type: type,
        cid: cid,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
