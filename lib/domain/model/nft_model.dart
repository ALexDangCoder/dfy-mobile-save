import 'dart:typed_data';

class NftModel {
  String? nftName = '';
  String? nftAddress = '';
  String? iconNFT = '';

  NftModel({
    this.nftName,
    this.nftAddress,
    this.iconNFT,
  });

  NftModel.fromWalletCore(dynamic json)
      : nftName = json['nftName'].toString(),
        iconNFT = json['iconNFT'].toString(),
        nftAddress = json['nftAddress'].toString();

  NftModel.init();
}
