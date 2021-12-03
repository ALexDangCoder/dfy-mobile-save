import 'package:Dfy/data/web3/model/nft_info_model.dart';
import 'package:Dfy/data/web3/model/token_info_model.dart';
import 'package:Dfy/data/web3/model/transaction.dart';
import 'package:Dfy/data/web3/model/transaction_history_detail.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class Web3Utils {
  Web3Utils._privateConstructor();

  static final Web3Utils _shared = Web3Utils._privateConstructor();

  factory Web3Utils() => _shared;

  //client
  final client = Web3Client(rpcURL, Client());

  //Token

  //Token info
  TokenInfoModel getTokenInfo({required String contractAddress}) {
    return TokenInfoModel();
  }

  //get balance of BNB from an address
  Future<double> getBalanceOfBnb({required String ofAddress}) async {
    final amount = await client.getBalance(EthereumAddress.fromHex(ofAddress));
    return amount.getInWei / BigInt.from(10).pow(18);
  }

  Future<double> getBalanceOfToken({
    required String ofAddress,
    required String tokenAddress,
    String? password,
  }) async {
    //TODO: Mockup data
    return 1000.0;
  }

  //Transaction History of a token
  Future<List<TransactionHistory>> getTransactionHistory({
    required String ofAddress,
    required String tokenAddress,
  }) async {
    return [
      TransactionHistory(
          'Contract interaction', 'success', '2021-12-03 14:30', 100.0),
      TransactionHistory(
          'Contract interaction', 'success', '2021-12-03 14:30', 100.0),
      TransactionHistory(
          'Contract interaction', 'pending', '2021-12-03 14:30', 100.0),
      TransactionHistory(
          'Contract interaction', 'fail', '2021-12-03 14:30', 100.0),
      TransactionHistory(
          'Contract interaction', 'fail', '2021-12-03 14:30', 100.0),
    ];
  }

  //Transaction History Detail
  Future<TransactionHistoryDetail> getHistoryDetail() async {
    return TransactionHistoryDetail(
      1000.0,
      0.005,
      '2021-12-03 14:30',
      '0xc945bb101ac51f0bbb77c294fe21280e9de55c82da3160ad665548ef8662f35a',
      '0x588B1b7C48517D1C8E1e083d4c05389D2E1A5e37',
      '0xf14aEdedE46Bf6763EbB5aA5C882364d29B167dD',
      300,
    );
  }

  //get balance of an address
  int getTokenBalance(String contractAddress) {
    return 0;
  }

  //get gas price
  Future<double> getGasPrice() async {
    final amount = await client.getGasPrice();
    return amount.getInWei / BigInt.from(10).pow(9);
  }

  Future<double> getEstimateGasPrice({
    required String from,
    required String to,
    required double value,
  }) async {
    final amount = await client.estimateGas(
      sender: EthereumAddress.fromHex(from),
      to: EthereumAddress.fromHex(to),
      value: EtherAmount.fromUnitAndValue(
        EtherUnit.gwei,
        (value * 1000000000).toInt(),
      ),
    );
    return amount / BigInt.from(10).pow(9);
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
  Future<NftInfo> getNftDetail({
    required String contractAddress,
    required String walletAddress,
    String? password,
  }) async {
    return NftInfo();
  }
}
