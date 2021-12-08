class NftInfo {
  String? contract;
  String? collectionId;
  String? name;
  String? id;
  String? img;
  String? link;
  String? description;
  String? standard;
  String? blockchain;

  NftInfo({
    this.contract,
    this.collectionId,
    this.name,
    this.id,
    this.link,
    this.description,
    this.standard,
    this.blockchain,
  });
  NftInfo.fromJson(Map<String, dynamic> json) {
    const url = 'https://defiforyou.mypinata.cloud/ipfs/';
    collectionId = json['collection_id'];
    description = json['description'];
    img = url + json['file_cid'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contract'] = contract;
    data['collectionId'] = collectionId;
    data['name'] = name;
    data['id'] = id;
    data['img'] = img;
    data['link'] = link;
    data['description'] = description;
    data['name'] = name;
    data['standard'] = standard;
    data['blockchain'] = blockchain;
    return data;
  }

  Map<String, dynamic> saveToJson({required String walletAddress}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['walletAddress'] = walletAddress;
    data['collectionAddress'] = contract;
    data['nftAddress'] = contract;
    data['collectionId'] = collectionId;
    data['nftName'] = name;
    data['nftID'] = id;
    data['iconNFT'] = img;
    data['link'] = link;
    data['description'] = description;
    data['name'] = name;
    data['standard'] = standard;
    data['blockchain'] = blockchain;
    return data;
  }
}
