import 'dart:convert';

import 'package:Dfy/data/request/collection/create_hard_collection_request.dart';
import 'package:Dfy/data/request/collection/create_soft_collection_request.dart';
import 'package:Dfy/data/request/nft/create_soft_nft_request.dart';
import 'package:Dfy/data/request/put_on_market/put_on_auction_request.dart';
import 'package:Dfy/data/request/put_on_market/put_on_pawn_request.dart';
import 'package:Dfy/data/request/put_on_market/put_on_sale_request.dart';
import 'package:Dfy/data/request/send_offer_request.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:Dfy/widgets/approve/bloc/approve_cubit.dart';

extension CallApiBE on ApproveCubit {
  Future<String> createCollection({
    required int type,
    required Map<String, dynamic> mapRawData,
    required String txhHash,
  }) async {
    if (type == SOFT_COLLECTION) {
      mapRawData['txn_hash'] = txhHash;
      final CreateSoftCollectionRequest data =
          CreateSoftCollectionRequest.fromJson(mapRawData);
      final result = await confirmRepository.createSoftCollection(data: data);
      result.when(
        success: (suc) {},
        error: (err) {},
      );
    } else {
      mapRawData['bc_txn_hash'] = txhHash;
      mapRawData['collection_address'] = addressWallet;
      final CreateHardCollectionRequest data =
          CreateHardCollectionRequest.fromJson(mapRawData);
      final result = await confirmRepository.createHardCollection(data: data);
      result.when(
        success: (suc) {},
        error: (err) {},
      );
    }
    return '';
  }

  Future<bool> putOnAuction({required String txHash}) async {
    final bool haveBuyOutPrice = putOnMarketModel?.buyOutPrice != null &&
        putOnMarketModel?.buyOutPrice != '';
    final bool havePriceStep = putOnMarketModel?.priceStep != null &&
        putOnMarketModel?.priceStep != '';
    final Map<String, dynamic> mapRawData = {
      'buy_out_price': int.parse(putOnMarketModel?.buyOutPrice ?? '0'),
      'enable_buy_out_price': haveBuyOutPrice,
      'enable_price_step': havePriceStep,
      'end_time': int.parse(putOnMarketModel?.endTime ?? '0'),
      'get_email': true,
      'nft_id': putOnMarketModel?.nftId,
      'nft_type': putOnMarketModel?.nftType ?? 0,
      'price_step': int.parse(putOnMarketModel?.priceStep ?? '0'),
      'reserve_price': int.parse(putOnMarketModel?.price ?? '0'),
      'start_time': int.parse(putOnMarketModel?.startTime ?? '0'),
      'token': putOnMarketModel?.tokenAddress,
      'txn_hash': txHash,
    };
    final PutOnAuctionRequest data = PutOnAuctionRequest.fromJson(mapRawData);
    final result = await confirmRepository.putOnAuction(data: data);
    bool res = false;
    result.when(
      success: (suc) {
        res = true;
      },
      error: (err) {
        res = false;
      },
    );
    return res;
  }

  Future<bool> putOnSale({required String txHash}) async {
    final Map<String, dynamic> mapRawData = {
      'nft_id': putOnMarketModel?.nftId ?? '',
      'token': putOnMarketModel?.tokenAddress ?? '',
      'txn_hash': txHash,
      'nft_type': putOnMarketModel?.nftType ?? 0,
      'number_of_copies': putOnMarketModel?.numberOfCopies ?? 1,
      'price': int.parse(putOnMarketModel?.price ?? ''),
    };
    final PutOnSaleRequest data = PutOnSaleRequest.fromJson(mapRawData);
    final result = await confirmRepository.putOnSale(data: data);
    bool res = false;
    result.when(
      success: (suc) {
        res = true;
      },
      error: (err) {
        res = false;
      },
    );
    return res;
  }

  Future<bool> putOnPawn({required String txHash}) async {
    final userInfo = PrefsService.getUserProfile();
    final Map<String, dynamic> mapProfileUser = jsonDecode(userInfo);
    String userId = '';
    if (mapProfileUser.intValue('id') != 0) {
      userId = mapProfileUser.intValue('id').toString();
    }
    final Map<String, dynamic> mapRawData = {
      'beNftId': putOnMarketModel?.nftId ?? '',
      'collectionAddress': putOnMarketModel?.collectionAddress ?? '',
      'collectionIsWhitelist': putOnMarketModel?.collectionIsWhitelist ?? false,
      'collectionName': putOnMarketModel?.collectionName ?? '',
      'durationQuantity': putOnMarketModel?.duration ?? '1',
      'durationType': putOnMarketModel?.durationType ?? 0,
      'loanAmount': putOnMarketModel?.price ?? '1',
      'loanSymbol': putOnMarketModel?.loanSymbol ?? '1',
      'networkName': networkName,
      'nftMediaCid': putOnMarketModel?.nftMediaCid ?? '1',
      'nftMediaType': putOnMarketModel?.nftMediaType ?? '1',
      'nftName': putOnMarketModel?.nftName ?? '1',
      'nftStandard': putOnMarketModel?.nftStandard ?? 0,
      'nftType': (putOnMarketModel?.nftType ?? 0).toString(),
      'numberOfCopies': putOnMarketModel?.numberOfCopies ?? 0,
      'totalOfCopies': putOnMarketModel?.totalOfCopies ?? 1,
      'txnHash': txHash,
      'userId': userId,
      'walletAddress': addressWallet,
    };
    final PutOnPawnRequest data = PutOnPawnRequest.fromJson(mapRawData);
    final result = await confirmRepository.putOnPawn(data: data);
    bool res = false;
    result.when(
      success: (suc) {
        res = true;
      },
      error: (err) {
        res = false;
      },
    );
    return res;
  }

  Future<void> confirmCancelSaleWithBE({
    required String txnHash,
    required String marketId,
  }) async {
    final result = await nftRepo.cancelSale(
      id: marketId,
      txnHash: txnHash,
    );
    result.when(
      success: (res) {},
      error: (err) {},
    );
  }

  Future<void> confirmCancelAuctionWithBE({
    required String txnHash,
    required String marketId,
  }) async {
    final result = await nftRepo.cancelAuction(
      id: marketId,
      txnHash: txnHash,
    );
    result.when(
      success: (res) {},
      error: (err) {},
    );
  }

  Future<void> sendOffer({
    required SendOfferRequest offerRequest,
  }) async {
    final result = await nftRepo.sendOffer(offerRequest);
    result.when(
      success: (res) {},
      error: (err) {},
    );
  }

  Future<void> createSoftNft({
    required Map<String, dynamic> mapRawData,
    required String txhHash,
  }) async {
    mapRawData['txn_hash'] = txhHash;
    final CreateSoftNftRequest data = CreateSoftNftRequest.fromJson(mapRawData);
    final result = await confirmRepository.createSoftNft(data: data);
    result.when(
      success: (suc) {},
      error: (err) {},
    );
  }

  Future<void> confirmCancelPawnWithBE({
    required int id,
  }) async {
    final result = await nftRepo.cancelPawn(id);
    result.when(
      success: (res) {},
      error: (err) {},
    );
  }
}
