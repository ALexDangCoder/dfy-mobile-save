import 'package:Dfy/utils/constants/app_constants.dart';

class NftInfo {
  String? contract;
  String? collectionId;
  String? name;
  String? id;
  String? img;
  String? description;
  String? standard = ERC_721;
  String? blockchain = 'Binance smart chain';
  String? collectionSymbol;
  String? collectionName;

  NftInfo({
    this.contract,
    this.collectionId,
    this.name,
    this.id,
    this.description,
    this.standard,
    this.blockchain,
    this.collectionSymbol,
    this.collectionName,
  });

  NftInfo.fromJson(Map<String, dynamic> json) {
    const url = 'https://defiforyou.mypinata.cloud/ipfs/';
    collectionId = json['collection_id'];
    description = json['description'];
    img = url + json['file_cid'];
    name = json['name'];
  }

  Map<String, dynamic> saveToJson({required String walletAddress}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['walletAddress'] = walletAddress;
    data['collectionAddress'] = contract ?? '';
    data['nftAddress'] = contract ?? '';
    data['collectionId'] = collectionId;
    data['nftName'] = name;
    data['nftID'] = int.parse(id ?? '-1');
    data['iconNFT'] = img;
    data['description'] = description;
    data['name'] = name;
    data['standard'] = standard ?? '';
    data['blockchain'] = blockchain ?? '';
    return data;
  }
}
