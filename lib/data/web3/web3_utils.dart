import 'dart:typed_data';

import 'package:Dfy/data/web3/abi/nft.g.dart';
import 'package:Dfy/data/web3/abi/token.g.dart';
import 'package:Dfy/data/web3/model/nft_info_model.dart';
import 'package:Dfy/data/web3/model/token_info_model.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter/services.dart' show rootBundle;

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
  final client = Web3Client(Get.find<AppConstants>().rpcUrl, Client());

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

  //get gas price
  Future<String> getGasPrice() async {
    final amount = await client.getGasPrice();
    return '${amount.getInWei}';
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
      final abiCode = await rootBundle.loadString('assets/abi/erc20_abi.json');
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
    final abiCode = await rootBundle.loadString('assets/abi/erc721_abi.json');
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

  Future<Map<String, dynamic>> sendRawTransaction(
      {required String transaction}) async {
    final List<int> listInt = hex.decode(transaction);
    final Uint8List signedTransaction = Uint8List.fromList(listInt);
    try {
      final raw = await client.sendRawTransaction(signedTransaction);
      return {
        'isSuccess': true,
        'txHash': raw,
      };
    } catch (error) {
      return {
        'isSuccess': false,
        'txHash': '',
      };
    }
  }

  //NFT detail
  Future<NftInfo> getNftDetail({
    required String contractAddress,
    required String walletAddress,
    String? password,
  }) async {
    return NftInfo();
  }

  //Market place
  Future<Uint8List?> _getPutOnSalesSignData({
    required int tokenId,
    required int numberOfCopies,
    required String price,
    required String currency,
    required String collectionAddress,
    required BuildContext context,
  }) async {
    final deployContract = await deployedContractAddress(
      '0x988b342d1223e01b0d6Ba4F496FD42d47969656b',
      context,
    );
    final putOnSalesFunction = deployContract.function('putOnSales');
    final putOnSale = Transaction.callContract(
      contract: deployContract,
      function: putOnSalesFunction,
      parameters: [
        BigInt.from(tokenId),
        BigInt.from(numberOfCopies),
        BigInt.from(num.parse(_handleAmount(18, price))),
        EthereumAddress.fromHex(currency),
        EthereumAddress.fromHex(collectionAddress),
      ],
    );
    return putOnSale.data;
  }

  Future<String> getPutOnSalesSignData({
    required int tokenId,
    required int numberOfCopies,
    required String price,
    required String currency,
    required String collectionAddress,
    required BuildContext context,
  }) async {
    final data = await _getPutOnSalesSignData(
      tokenId: tokenId,
      numberOfCopies: numberOfCopies,
      price: price,
      currency: currency,
      collectionAddress: collectionAddress,
      context: context,
    );
    return hex.encode(data ?? []);
  }

  Future<String> getPutOnSaleGasLimit({
    required String from,
    required String toContractAddress,
    required int tokenId,
    required int numberOfCopies,
    required String price,
    required String currency,
    required String collectionAddress,
    required BuildContext context,
  }) async {
    final data = await _getPutOnSalesSignData(
      tokenId: tokenId,
      numberOfCopies: numberOfCopies,
      price: price,
      currency: currency,
      collectionAddress: collectionAddress,
      context: context,
    );
    final gasLimit = await client.estimateGas(
      sender: EthereumAddress.fromHex(from),
      to: EthereumAddress.fromHex(toContractAddress),
      data: data,
    );
    final valueHundredMore = BigInt.from(100) + gasLimit;
    return '$valueHundredMore';
  }

  Future<bool> isApproved({
    required String payValue,
    required String walletAddres,
    required String tokenAddress,
    required String spenderAddress,
  }) async {
    final token =
        Token(address: EthereumAddress.fromHex(tokenAddress), client: client);
    try {
      final allowance = await token.allowance(
        EthereumAddress.fromHex(walletAddres),
        EthereumAddress.fromHex(spenderAddress),
      );
      if (BigInt.from(num.parse(_handleAmount(18, payValue))) < allowance) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<String> getGasLimitByData({
    required String from,
    required String toContractAddress,
    required String dataString,
  }) async {
    final data = Uint8List.fromList(hex.decode(dataString));
    final gasLimit = await client.estimateGas(
      sender: EthereumAddress.fromHex(from),
      to: EthereumAddress.fromHex(toContractAddress),
      data: data,
    );
    final valueHundredMore = BigInt.from(100) + gasLimit;
    return '$valueHundredMore';
  }

  Future<String> getBuyNftData({
    required String contractAddress,
    required String orderId,
    required String numberOfCopies,
    required BuildContext context,
  }) async {
    final deployedContract =
        await deployedContractAddress(contractAddress, context);
    final buyFunction = deployedContract.function('buyNFT');
    final buyNFT = Transaction.callContract(
      contract: deployedContract,
      function: buyFunction,
      parameters: [
        BigInt.from(num.parse(orderId)),
        BigInt.from(num.parse(numberOfCopies)),
      ],
    );
    return hex.encode(buyNFT.data ?? []);
  }

  Future<String> getCancelListingData({
    required String contractAddress,
    required String orderId,
    required BuildContext context,
  }) async {
    final deployedContract =
        await deployedContractAddress(contractAddress, context);
    final cancelFunction = deployedContract.function('cancelListing');
    final cancelListing = Transaction.callContract(
      contract: deployedContract,
      function: cancelFunction,
      parameters: [
        BigInt.from(num.parse(orderId)),
      ],
    );
    return hex.encode(cancelListing.data ?? []);
  }

  Future<String> getBuyOutData({
    required String contractAddress,
    required String auctionId,
    required BuildContext context,
  }) async {
    final deployContract =
        await auctionDeployedContract(contractAddress, context);
    final function = deployContract.function('buyOut');
    final buyOut = Transaction.callContract(
      contract: deployContract,
      function: function,
      parameters: [
        BigInt.from(num.parse(auctionId)),
      ],
    );
    return hex.encode(buyOut.data ?? []);
  }

  Future<String> getBidData({
    required String contractAddress,
    required String auctionId,
    required String bidValue,
    required BuildContext context,
  }) async {
    final deployContract =
        await auctionDeployedContract(contractAddress, context);
    final function = deployContract.function('bid');
    final bid = Transaction.callContract(
      contract: deployContract,
      function: function,
      parameters: [
        BigInt.from(num.parse(auctionId)),
        BigInt.from(num.parse(bidValue)),
      ],
    );
    return hex.encode(bid.data ?? []);
  }

  Future<String> getCancelAuctionData({
    required String contractAddress,
    required String auctionId,
    required BuildContext context,
  }) async {
    final deployContract =
        await auctionDeployedContract(contractAddress, context);
    final function = deployContract.function('cancelAuction');
    final cancelAuction = Transaction.callContract(
      contract: deployContract,
      function: function,
      parameters: [
        BigInt.from(num.parse(auctionId)),
      ],
    );
    return hex.encode(cancelAuction.data ?? []);
  }

  Future<String> getFinishAuctionData({
    required String contractAddress,
    required String auctionId,
    required BuildContext context,
  }) async {
    final deployContract =
        await auctionDeployedContract(contractAddress, context);
    final function = deployContract.function('finishAuction');
    final cancelAuction = Transaction.callContract(
      contract: deployContract,
      function: function,
      parameters: [
        BigInt.from(num.parse(auctionId)),
      ],
    );
    return hex.encode(cancelAuction.data ?? []);
  }

  Future<String> getPutOnAuctionData({
    required String contractAddress,
    required String tokenId,
    required String collectionAddress,
    required String startingPrice,
    required String buyOutPrice,
    required String priceStep,
    required String currencyAddress,
    required String startTime,
    required String endTime,
    required BuildContext context,
  }) async {
    final deployContract =
        await auctionDeployedContract(contractAddress, context);
    final function = deployContract.function('putOnAuction');
    final putOnAuction = Transaction.callContract(
      contract: deployContract,
      function: function,
      parameters: [
        BigInt.from(num.parse(tokenId)),
        EthereumAddress.fromHex(collectionAddress),
        BigInt.from(num.parse(startingPrice)),
        BigInt.from(num.parse(buyOutPrice)),
        BigInt.from(num.parse(priceStep)),
        EthereumAddress.fromHex(currencyAddress),
        BigInt.from(num.parse(startTime)),
        BigInt.from(num.parse(endTime)),
      ],
    );
    return hex.encode(putOnAuction.data ?? []);
  }

  Future<String> getTokenApproveData({
    required String contractAddress,
    required String spender,
    required BuildContext context,
  }) async {
    final deployContract =
        await deployedERC20Contract(contractAddress, context);
    final function = deployContract.function('approve');
    final approve = Transaction.callContract(
      contract: deployContract,
      function: function,
      parameters: [
        EthereumAddress.fromHex(spender),
        BigInt.from(
          num.parse(
              '115792089237316195423570985008687907853269984665640564039457'),
        ),
      ],
    );
    return hex.encode(approve.data ?? []);
  }

  Future<String> getCreateCollectionData({
    required String contractAddress,
    required String name,
    required String royaltyRate,
    required String collectionCID,
    required BuildContext context,
  }) async {
    final deployContract = await deployedNFTCollectionContract(contractAddress);
    final function = deployContract.function('createCollection');
    final createCollection = Transaction.callContract(
      contract: deployContract,
      function: function,
      parameters: [
        name,
        'DFY-NFT',
        BigInt.from(num.parse(royaltyRate)),
        collectionCID
      ],
    );
    return hex.encode(createCollection.data ?? []);
  }

  //pawn
  Future<String> getPutOnPawnData({
    required String nftContract,
    required String nftTokenId,
    required String expectedlLoanAmount,
    required String loanAsset,
    required String nftTokenQuantity,
    required String expectedDurationQty,
    required int durationType,
    required String beNFTId,
    required BuildContext context,
  }) async {
    final deployContract = await deployedNFTPawnContract(nft_pawn_dev2);
    final function = deployContract.function('putOnPawn');
    final putOnPawn = Transaction.callContract(
      contract: deployContract,
      function: function,
      parameters: [
        EthereumAddress.fromHex(nftContract),
        BigInt.from(num.parse(nftTokenId)),
        BigInt.from(num.parse(expectedlLoanAmount)),
        EthereumAddress.fromHex(loanAsset),
        BigInt.from(num.parse(nftTokenQuantity)),
        BigInt.from(num.parse(expectedDurationQty)),
        BigInt.from(durationType),
        beNFTId,
      ],
    );
    return hex.encode(putOnPawn.data ?? []);
  }

  Future<String> getAcceptOfferData({
    required String nftCollateralId,
    required String offerId,
    required BuildContext context,
  }) async {
    final deployContract = await deployedNFTPawnContract(nft_pawn_dev2);
    final function = deployContract.function('acceptOffer');
    final acceptOffer = Transaction.callContract(
      contract: deployContract,
      function: function,
      parameters: [
        BigInt.from(num.parse(nftCollateralId)),
        BigInt.from(num.parse(offerId)),
      ],
    );
    return hex.encode(acceptOffer.data ?? []);
  }

  Future<String> getCancelOfferData({
    required String nftCollateralId,
    required String offerId,
    required BuildContext context,
  }) async {
    final deployContract = await deployedNFTPawnContract(nft_pawn_dev2);
    final function = deployContract.function('cancelOffer');
    final cancelOffer = Transaction.callContract(
      contract: deployContract,
      function: function,
      parameters: [
        BigInt.from(num.parse(offerId)),
        BigInt.from(num.parse(nftCollateralId)),
      ],
    );
    return hex.encode(cancelOffer.data ?? []);
  }

  Future<String> getCreateOfferData({
    required String nftCollateralId,
    required String repaymentAsset,
    required String loanAmount,
    required String interest,
    required String duration,
    required int loanDurationType,
    required int repaymentCycleType,
    required BuildContext context,
  }) async {
    final deployContract = await deployedNFTPawnContract(nft_pawn_dev2);
    final function = deployContract.function('createOffer');
    final createOffer = Transaction.callContract(
      contract: deployContract,
      function: function,
      parameters: [
        BigInt.from(num.parse(nftCollateralId)),
        EthereumAddress.fromHex(repaymentAsset),
        BigInt.from(num.parse(_handleAmount(18, loanAmount))),
        BigInt.from(num.parse(_handleAmount(5, interest))),
        BigInt.from(num.parse(duration)),
        BigInt.from(loanDurationType),
        BigInt.from(repaymentCycleType),
      ],
    );
    return hex.encode(createOffer.data ?? []);
  }

  Future<String> getWithdrawCollateralData({
    required String nftCollateralId,
  }) async {
    final deployContract = await deployedNFTPawnContract(nft_pawn_dev2);
    final function = deployContract.function('withdrawCollateral');
    final withdrawCollateral = Transaction.callContract(
      contract: deployContract,
      function: function,
      parameters: [
        BigInt.from(num.parse(nftCollateralId)),
      ],
    );
    return hex.encode(withdrawCollateral.data ?? []);
  }

  //hardNFT
  Future<DeployedContract> deployedHardNftCollectionAddress(
    String contract,
  ) async {
    final abiCode =
        await rootBundle.loadString('assets/abi/Hard_NFT_Factory721_ABI.json');
    final deployContract = DeployedContract(
      ContractAbi.fromJson(abiCode, 'Hard Nft'),
      EthereumAddress.fromHex(contract),
    );
    return deployContract;
  }

  Future<String> getCreateHardCollectionData({
    required String name,
    required String royaltyRate,
    required String collectionCID,
    required BuildContext context,
  }) async {
    final deployContract =
        await deployedHardNftCollectionAddress(hard_nft_factory_address_dev2);
    final function = deployContract.function('createCollection');
    final createCollection = Transaction.callContract(
      contract: deployContract,
      function: function,
      parameters: [
        name,
        'DFY-HARD-NFT',
        collectionCID,
      ],
    );
    return hex.encode(createCollection.data ?? []);
  }

  Future<String> getCreateErc721NftData({
    required String collectionAddress,
    required String owner,
    required String royaltyRate,
    required String tokenCID,
  }) async {
    final deployContract = await deployedErc721Contract(collectionAddress);
    final function = deployContract.function('safeMint');
    final safeMint = Transaction.callContract(
      contract: deployContract,
      function: function,
      parameters: [
        EthereumAddress.fromHex(owner),
        BigInt.from(num.parse(_handleAmount(5, royaltyRate))),
        tokenCID,
      ],
    );
    return hex.encode(safeMint.data ?? []);
  }

  Future<DeployedContract> deployedContractAddress(
    String contract,
    BuildContext context,
  ) async {
    final abiCode =
        await rootBundle.loadString('assets/abi/SellNFT_ABI_DEV2.json');
    final deployContract = DeployedContract(
      ContractAbi.fromJson(abiCode, 'Sell NFT'),
      EthereumAddress.fromHex(contract),
      // EthereumAddress.fromHex('0x988b342d1223e01b0d6Ba4F496FD42d47969656b'),
    );
    return deployContract;
  }

  Future<DeployedContract> auctionDeployedContract(
    String contract,
    BuildContext context,
  ) async {
    final abiCode =
        await rootBundle.loadString('assets/abi/AuctionNFT_ABI.json');
    final deployContract = DeployedContract(
      ContractAbi.fromJson(abiCode, 'Aunction NFT'),
      EthereumAddress.fromHex(contract),
      // EthereumAddress.fromHex('0x988b342d1223e01b0d6Ba4F496FD42d47969656b'),
    );
    return deployContract;
  }

  Future<DeployedContract> deployedERC20Contract(
    String contract,
    BuildContext context,
  ) async {
    final abiCode = await rootBundle.loadString('assets/abi/erc20_abi.json');
    final deployContract = DeployedContract(
      ContractAbi.fromJson(abiCode, 'erc20'),
      EthereumAddress.fromHex(contract),
    );
    return deployContract;
  }

  Future<DeployedContract> deployedNFTCollectionContract(
    String contract,
  ) async {
    final abiCode = await rootBundle
        .loadString('assets/abi/DefiForYouNFTFactory_ABI_DEV2.json');
    final deployContract = DeployedContract(
      ContractAbi.fromJson(abiCode, 'nftFactory'),
      EthereumAddress.fromHex(contract),
    );
    return deployContract;
  }

  Future<DeployedContract> deployedNFTPawnContract(
    String contract,
  ) async {
    final abiCode =
        await rootBundle.loadString('assets/abi/PawnNFTABI_DEV2.json');
    final deployContract = DeployedContract(
      ContractAbi.fromJson(abiCode, 'nftPawn'),
      EthereumAddress.fromHex(contract),
    );
    return deployContract;
  }

  Future<DeployedContract> deployedErc721Contract(
    String contract,
  ) async {
    final abiCode = await rootBundle.loadString('assets/abi/erc721_abi.json');
    final deployContract = DeployedContract(
      ContractAbi.fromJson(abiCode, 'erc721'),
      EthereumAddress.fromHex(contract),
    );
    return deployContract;
  }

  String _handleAmount(int decimal, String value) {
    final parts = value.split('.');
    if (value.isEmpty) {
      return '0';
    } else {
      if (parts.length == 1) {
        var buffer = '';
        var size = 0;
        while (size < decimal) {
          buffer = buffer + '0';
          size++;
        }
        return '$value$buffer';
      } else if (parts.length > 1) {
        if (parts[1].length >= decimal) {
          final part = parts[1];
          return parts[0] + part.substring(0, decimal - 1);
        } else {
          final valueAmount = parts[0];
          final valueDecimal = parts[1];
          var buffer = '';
          var size = valueDecimal.length;
          while (size < decimal) {
            buffer = buffer + '0';
            size++;
          }
          return valueAmount + valueDecimal + buffer;
        }
      } else {
        return '0';
      }
    }
  }
}
