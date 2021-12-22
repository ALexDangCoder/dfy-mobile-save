import 'dart:typed_data';

import 'package:Dfy/data/web3/abi/nft.g.dart';
import 'package:Dfy/data/web3/abi/token.g.dart';
import 'package:Dfy/data/web3/model/nft_info_model.dart';
import 'package:Dfy/data/web3/model/token_info_model.dart';
import 'package:Dfy/data/web3/model/transaction.dart';
import 'package:Dfy/data/web3/model/transaction_history_detail.dart';
import 'package:Dfy/domain/model/detail_history_nft.dart';
import 'package:Dfy/domain/model/history_nft.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class ImportNftResponse {
  bool isSuccess;
  String message;

  ImportNftResponse({
    required this.isSuccess,
    required this.message,
  });
}

class TransactionCountResponse {
  bool isSuccess;
  int count;

  TransactionCountResponse({
    required this.isSuccess,
    required this.count,
  });
}

class Web3Utils {
  Web3Utils._privateConstructor();

  static final Web3Utils _shared = Web3Utils._privateConstructor();

  factory Web3Utils() => _shared;

  //client
  final client = Web3Client(rpcURL, Client());

  Future<ImportNftResponse> importNFT({
    required String contract,
    required String address,
    int? id,
  }) async {
    try {
      final nft =
          Nft(address: EthereumAddress.fromHex(contract), client: client);
      if (id == null) {
        try {
          final balanceOfNft =
              await nft.balanceOf(EthereumAddress.fromHex(address));
          if (balanceOfNft > BigInt.zero) {
            return ImportNftResponse(isSuccess: true, message: '');
          } else {
            return ImportNftResponse(
              isSuccess: false,
              message: S.current.err_empty_nfts,
            );
          }
        } catch (error) {
          return ImportNftResponse(
            isSuccess: false,
            message: S.current.err_invalid_wallet_add,
          );
        }
      } else {
        try {
          final ownerAddress = await nft.ownerOf(BigInt.from(id));
          if (EthereumAddress.fromHex(address) == ownerAddress) {
            return ImportNftResponse(isSuccess: true, message: '');
          } else {
            return ImportNftResponse(
              isSuccess: false,
              message: S.current.err_not_owner_nft,
            );
          }
        } on Exception catch (_) {
          return ImportNftResponse(
            isSuccess: false,
            message: S.current.err_none_exist_nft,
          );
        } catch (error) {
          return ImportNftResponse(
            isSuccess: false,
            message: S.current.err_invalid_wallet_add,
          );
        }
      }
    } catch (error) {
      return ImportNftResponse(
        isSuccess: false,
        message: S.current.err_invalid_wallet_add,
      );
    }
  }

  Future<Map<String, dynamic>> getNFTInfo({
    required String contract,
    required int id,
  }) async {
    final nft = Nft(address: EthereumAddress.fromHex(contract), client: client);
    final name = await nft.name();
    final symbol = await nft.symbol();
    final nftUri = await nft.tokenURI(BigInt.from(id));
    return {
      'id': id,
      'name': name,
      'symbol': symbol,
      'uri': nftUri,
    };
  }

  Future<Map<String, dynamic>> getCollectionInfo({
    required String contract,
    int? id,
    required String address,
  }) async {
    final nft = Nft(address: EthereumAddress.fromHex(contract), client: client);
    final name = await nft.name();
    final symbol = await nft.symbol();
    final listNft = <Map<String, dynamic>>[];
    if (id == null) {
      final balance = await nft.balanceOf(EthereumAddress.fromHex(address));
      for (int i = 0; i < balance.toInt(); i++) {
        final nftId = await nft.tokenOfOwnerByIndex(
            EthereumAddress.fromHex(address), BigInt.from(i));
        final uri = await nft.tokenURI(nftId);
        final nftParam = {
          'id': '$nftId',
          'contract': contract,
          'uri': uri,
        };
        listNft.add(nftParam);
      }
    } else {
      final uri = await nft.tokenURI(BigInt.from(id));
      final nftParam = {
        'id': '$id',
        'contract': contract,
        'uri': uri,
      };
      listNft.add(nftParam);
    }
    return {
      'name': name,
      'symbol': symbol,
      'contract': contract,
      'listNft': listNft,
    };
  }

  //NFT info
  Future<NftInfo> getNftInfo({
    required String contract,
    required int id,
  }) async {
    final nft = Nft(address: EthereumAddress.fromHex(contract), client: client);
    final name = await nft.name();
    return NftInfo(
      contract: '0x588B1b7C48517D1C8E1e083d4c05389D2E1A5e37',
      name: 'Name of NFT',
      blockchain: 'Binance Smart Chain',
      description:
          'In fringilla orci facilisis in sed eget nec sollicitudin nullam',
      id: '124124',
      // link: 'https://goole.com',
      standard: 'ERC-721',
    );
  }

  Future<List<Map<String, dynamic>>> importAllNFT({
    required String address,
    required String contract,
  }) async {
    final nft = Nft(address: EthereumAddress.fromHex(contract), client: client);
    final balance = await nft.balanceOf(EthereumAddress.fromHex(address));
    for (int i = 0; i < balance.toInt(); i++) {
      await nft.tokenByIndex(BigInt.from(i));
    }
    return [
      {
        'id': 0,
        'uri':
            'https://defiforyou.mypinata.cloud/ipfs/QmXCQTqZYYyDCF6GcnnophSZryRQ3HJTvEjokoRFYbH5MG',
      },
      {
        'id': 1,
        'uri':
            'https://defiforyou.mypinata.cloud/ipfs/QmQj6bT1VbwVZesexd43vvGxbCGqLaPJycdMZQGdsf6t3c',
      },
    ];
  }

  //Token info
  Future<TokenInfoModel?> getTokenInfo({
    required String contractAddress,
    String? walletAddress,
  }) async {
    Token token;
    try {
      token = Token(
        address: EthereumAddress.fromHex(contractAddress),
        client: client,
      );
    } catch (e) {
      return null;
    }
    double value = 0.0;
    String name;
    String symbol;
    BigInt decimal;
    try {
      name = await token.name();
    } catch (e) {
      return null;
    }
    try {
      decimal = await token.decimals();
    } catch (e) {
      return null;
    }
    try {
      symbol = await token.symbol();
    } catch (e) {
      return null;
    }
    if (walletAddress != null) {
      final balance =
          await token.balanceOf(EthereumAddress.fromHex(walletAddress));
      value = balance / BigInt.from(10).pow(18);
    }
    return TokenInfoModel(
      name,
      decimal,
      symbol,
      value,
    );
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
    final token =
        Token(address: EthereumAddress.fromHex(tokenAddress), client: client);
    try {
      final balance = await token.balanceOf(EthereumAddress.fromHex(ofAddress));
      return balance / BigInt.from(10).pow(18);
    } catch (e) {
      return 0.0;
    }
  }

  Future<TransactionCountResponse> getTransactionCount({
    required String address,
  }) async {
    try {
      final count =
          await client.getTransactionCount(EthereumAddress.fromHex(address));
      return TransactionCountResponse(isSuccess: true, count: count);
    } catch (error) {
      return TransactionCountResponse(isSuccess: false, count: 0);
    }
  }

  //Transaction History of a token
  Future<List<TransactionHistory>> getTransactionHistory({
    required String ofAddress,
    required String tokenAddress,
  }) async {
    return [
      TransactionHistory(
        'Contract interaction',
        'success',
        '2021-12-03 14:30',
        100.0,
      ),
      TransactionHistory(
        'Contract interaction',
        'success',
        '2021-12-03 14:30',
        100.0,
      ),
      TransactionHistory(
        'Contract interaction',
        'pending',
        '2021-12-03 14:30',
        100.0,
      ),
      TransactionHistory(
        'Contract interaction',
        'success',
        '2021-12-03 14:30',
        100.0,
      ),
      TransactionHistory(
        'Contract interaction',
        'fail',
        '2021-12-03 14:30',
        100.0,
      ),
    ];
  }

  //Transaction History Detail
  Future<TransactionHistoryDetail> getHistoryDetail({
    required String txhId,
  }) async {
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

  //NFT History
  Future<List<HistoryNFT>> getNFTHistory() async {
    return [
      HistoryNFT('Contract interaction', '2021-12-03 14:30', 'pending', '1'),
      HistoryNFT('Contract interaction', '2021-12-03 14:30', 'success', '7'),
      HistoryNFT('Contract interaction', '2021-12-03 14:30', 'pending', '5'),
      HistoryNFT('Contract interaction', '2021-12-03 14:30', 'success', '1'),
      HistoryNFT('Contract interaction', '2021-12-03 14:30', 'pending', '1'),
      HistoryNFT('Contract interaction', '2021-12-03 14:30', 'pending', '1'),
      HistoryNFT('Contract interaction', '2021-12-03 14:30', 'pending', '1'),
      HistoryNFT('Contract interaction', '2021-12-03 14:30', 'pending', '1'),
    ];
  }

  //NFT History detail
  Future<DetailHistoryNFT> getNFTHistoryDetail() async {
    return DetailHistoryNFT(
      2,
      'success',
      10.0,
      '2021-12-03 14:30',
      '0xc945bb101ac51f0bbb77c294fe21280e9de55c82da3160ad665548ef8662f35a',
      '0x588B1b7C48517D1C8E1e083d4c05389D2E1A5e37',
      '0xf14aEdedE46Bf6763EbB5aA5C882364d29B167dD',
      2409,
    );
  }

  //get balance of an address
  int getTokenBalance(String contractAddress) {
    return 0;
  }

  //get gas price
  Future<String> getGasPrice() async {
    final amount = await client.getGasPrice();
    return '${amount.getInWei}';
  }

  Future<String> getEstimateGasPrice({
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
    return '$amount';
  }

  Future<bool> checkValidAddress(String address) async {
    try {
      final ethAddress = EthereumAddress.fromHex(address);
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<String> getTokenGasLimit({
    required String contract,
    required String symbol,
    required String from,
    required String to,
    required double amount,
    required BuildContext context,
  }) async {
    if (symbol == 'BNB') {
      final gasLimit = await client.estimateGas(
        sender: EthereumAddress.fromHex(from),
        to: EthereumAddress.fromHex(to),
        value: EtherAmount.fromUnitAndValue(
          EtherUnit.wei,
          BigInt.from(amount * 1000000000000000000),
        ),
      );
      return '$gasLimit';
    } else {
      final abiCode = await DefaultAssetBundle.of(context)
          .loadString('assets/abi/erc20_abi.json');
      final deployContract = DeployedContract(
        ContractAbi.fromJson(abiCode, symbol),
        EthereumAddress.fromHex(contract),
      );
      final transferFunction = deployContract.function('transfer');
      final sendAmount = BigInt.from(amount * 1000000000000000000);
      final transferTransaction = Transaction.callContract(
        contract: deployContract,
        function: transferFunction,
        parameters: [
          EthereumAddress.fromHex(to),
          sendAmount,
        ],
      );
      final gasLimit = await client.estimateGas(
        sender: EthereumAddress.fromHex(from),
        to: EthereumAddress.fromHex(contract),
        data: transferTransaction.data,
      );
      final valueHundredMore = BigInt.from(100) + gasLimit;
      return '$valueHundredMore';
    }
  }

  Future<String> getNftGasLimit({
    required String from,
    required String to,
    required String contract,
    required String symbol,
    required int id,
    required BuildContext context,
  }) async {
    final abiCode = await DefaultAssetBundle.of(context)
        .loadString('assets/abi/erc721_abi.json');
    final deployContract = DeployedContract(
      ContractAbi.fromJson(abiCode, symbol),
      EthereumAddress.fromHex(contract),
    );
    final transferFunction = deployContract.function('transferFrom');
    final transferTransaction = Transaction.callContract(
      contract: deployContract,
      function: transferFunction,
      parameters: [
        EthereumAddress.fromHex(from),
        EthereumAddress.fromHex(to),
        BigInt.from(id),
      ],
    );
    final gasLimit = await client.estimateGas(
      sender: EthereumAddress.fromHex(from),
      to: EthereumAddress.fromHex(contract),
      data: transferTransaction.data,
    );
    final valueHundredMore = BigInt.from(100) + gasLimit;
    return '$valueHundredMore';
  }

  // Future<double> getTokenEstimateGas({
  //   required String contract,
  //   required String from,
  //   required String to,
  //   required double value,
  // }) async {
  //   final token =
  //       Token(address: EthereumAddress.fromHex(contract), client: client);
  //       final amount = await token
  // }

  Future<bool> sendRawTransaction({required String transaction}) async {
    final List<int> listInt = hex.decode(transaction);
    final Uint8List signedTransaction = Uint8List.fromList(listInt);
    try {
      await client.sendRawTransaction(signedTransaction);
      return true;
    } catch (error) {
      return false;
    }
  }

  //Token detail
  // Future<TokenInfoModel> getTokenDetail({
  //   required String contractAddress,
  //   required String walletAddress,
  //   String? password,
  // }) async {
  //   return TokenInfoModel('', 0, '', '');
  // }

  //NFT detail
  Future<NftInfo> getNftDetail({
    required String contractAddress,
    required String walletAddress,
    String? password,
  }) async {
    return NftInfo();
  }
}
