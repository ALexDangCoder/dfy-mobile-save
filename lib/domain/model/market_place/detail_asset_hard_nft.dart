import 'package:Dfy/data/response/create_hard_nft/detail_asset_hard_nft_response.dart';

class DetailAssetHardNft {
  String? id;
  int? status;
  ContactCountryResponse? assetType;
  String? walletAddress;
  double? expectingPrice;
  String? name;
  String? expectingPriceSymbol;
  String? additionalInformation;
  List<String>? additionalInfoList;
  String? contactName;
  String? contactEmail;
  String? contactAddress;
  ContactPhoneCodeResponse? contactPhoneCode;
  String? contactPhone;
  ContactCountryResponse? contactCountry;
  ContactCityResponse? contactCity;
  String? requestId;
  int? displayStatus;
  CollectionResponse? collection;
  ContactCountryResponse? condition;
  List<String>? documentList;
  List<MediaListResponse>? mediaList;
  String? bcTxnHash;
  String? assetCid;
  int? ipfsStatus;
  int? bcAssetId;

  DetailAssetHardNft({
    this.id,
    this.status,
    this.assetType,
    this.walletAddress,
    this.expectingPrice,
    this.name,
    this.expectingPriceSymbol,
    this.additionalInformation,
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

class ContactPhoneCodeAssetHardNft {
  int? id;
  String? name;
  String? code;

  ContactPhoneCodeAssetHardNft({
    this.id,
    this.name,
    this.code,
  });
}

class ContactCountryAssetHardNft {
  int? id;
  String? name;

  ContactCountryAssetHardNft({
    this.id,
    this.name,
  });
}

class CollectionAssetHardNft {
  String? id;
  String? name;
  String? description;
  String? avatarCid;
  String? coverCid;
  String? featureCid;
  String? customUrl;
  double? royaltyRate;
  String? bcTxnHash;
  String? collectionCid;
  String? walletAddress;
  CollectionTypeRespone? collectionType;
  bool? isWhitelist;
  String? latitude;
  String? longitude;

  CollectionAssetHardNft({
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
  });
}

class CollectionTypeAssetHardNft {
  String? id;
  int? standard;
  String? name;
  String? description;
  int? type;

  CollectionTypeAssetHardNft({
    this.id,
    this.standard,
    this.name,
    this.description,
    this.type,
  });
}

class ContactCityAssetHardNft {
  int? id;
  String? name;
  int? countryId;
  double? latitude;
  double? longitude;

  ContactCityAssetHardNft({
    this.id,
    this.name,
    this.countryId,
    this.latitude,
    this.longitude,
  });
}

class MediaListAssetHardNft {
  String? name;
  String? type;
  String? cid;

  MediaListAssetHardNft({
    this.name,
    this.type,
    this.cid,
  });
}
