
class DetailAssetHardNft {
  String? id;
  int? status;
  ContactCountryAssetHardNft? assetType;
  String? walletAddress;
  double? expectingPrice;
  String? name;
  String? expectingPriceSymbol;
  String? additionalInformation;
  String? contactName;
  String? contactEmail;
  String? contactAddress;
  ContactPhoneCodeAssetHardNft? contactPhoneCode;
  String? contactPhone;
  ContactCountryAssetHardNft? contactCountry;
  ContactCityAssetHardNft? contactCity;
  String? requestId;
  int? displayStatus;
  CollectionAssetHardNft? collection;
  ContactCountryAssetHardNft? condition;
  List<MediaListAssetHardNft>? mediaList;
  String? bcTxnHash;
  String? assetCid;
  NFTAssetHard? nftAssetHard;

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
    this.nftAssetHard,
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

class NFTAssetHard {
  String? id;
  String? name;
  String? mediaId;
  String? coverId;
  int? numberOfCopies;
  int? status;
  int? bcTokenId;
  String? nftId;
  String? assetId;

  NFTAssetHard({
    this.id,
    this.name,
    this.mediaId,
    this.coverId,
    this.numberOfCopies,
    this.status,
    this.bcTokenId,
    this.nftId,
    this.assetId,
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
  CollectionTypeAssetHardNft? collectionType;
  bool? isWhitelist;
  String? latitude;
  String? longitude;
  String? collectionAddress;

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
    this.collectionAddress,
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
