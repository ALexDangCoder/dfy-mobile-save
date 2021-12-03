import 'dart:typed_data';

class NftModel {
  String? nftName;
  String? nftAddress;
  Uint8List? iconNFT;

  NftModel({
    this.nftName,
    this.nftAddress,
    this.iconNFT,
  });

  NftModel.fromWalletCore(dynamic json)
      : nftName = json['nftName'].toString(),
        iconNFT = json['iconNFT'],
        nftAddress = json['nftAddress'].toString();
}
