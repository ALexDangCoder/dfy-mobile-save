import 'package:Dfy/data/web3/model/nft_info_model.dart';

import 'model/token_info_model.dart';

class Web3Utils {
  Web3Utils._privateConstructor();

  static final Web3Utils _shared = Web3Utils._privateConstructor();

  factory Web3Utils() => _shared;

  //Token

  //Token info
  TokenInfoModel getTokenInfo({required String contractAddress}) {
    return TokenInfoModel();
  }

  //get balance of an address
  int getTokenBalance(String contractAddress) {
    return 0;
  }

  //get gas price
  Future<int> getGasPrice() async {
    return 10;
  }

  Future<int> getEstimateGasPrice() async {
    return 0;
  }

  //Token detail
  Future<TokenInfoModel> getTokenDetail({
    required String contractAddress,
    required String walletAddress,
    String? password,
  }) async {
    return TokenInfoModel();
  }

  //NFT detail
  Future<NftInfoModel> getNftDetail({
    required String contractAddress,
    required String walletAddress,
    String? password,
  }) async {
    return NftInfoModel();
  }
}
