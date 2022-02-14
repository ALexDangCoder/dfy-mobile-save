import 'package:Dfy/data/request/collection/create_collection_ipfs_request.dart';
import 'package:Dfy/data/request/collection/social_link_map_request.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/presentation/my_account/create_collection/bloc/create_collection_cubit.dart';
import 'package:Dfy/presentation/my_account/create_collection/bloc/extension/ipfs_gen_url.dart';
import 'package:Dfy/utils/app_utils.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:Dfy/utils/upload_ipfs/pin_to_ipfs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension Web3Call on CreateCollectionCubit {
  Future<void> sendDataWeb3(BuildContext context) async {
    final prefixURL = Get.find<AppConstants>().baseCustomUrl;
    if (customUrl.isEmpty){
      await generateRandomURL();
    }
    final CreateCollectionIpfsRequest request = CreateCollectionIpfsRequest(
      external_link:
          ApiConstants.URL_BASE + cidMap.getStringValue(AVATAR_CID),
      feature_cid: cidMap.getStringValue(FEATURE_CID),
      image: ApiConstants.URL_BASE + (cidMap.getStringValue(AVATAR_CID)),
      name: collectionName,
      custom_url: '$prefixURL$customUrl',
      avatar_cid: cidMap.getStringValue(AVATAR_CID),
      category: categoryId,
      cover_cid: cidMap.getStringValue(COVER_CID),
      social_links:
          socialLinkMap.map((e) => SocialLinkMapRequest.fromJson(e)).toList(),
    );
    collectionIPFS = await ipfsService.pinJsonToIPFS(
      type: PinJsonType.COLLECTION,
      collectionRequest: request,
    );
    if (collectionIPFS.isNotEmpty) {
      if (collectionType == 0) {
        transactionData = await web3utils.getCreateCollectionData(
          contractAddress: nft_factory_dev2,
          name: collectionName,
          royaltyRate: royalties.toString(),
          collectionCID: collectionIPFS,
          context: context,
        );
      } else {
        transactionData = await web3utils.getCreateHardCollectionData(
          name: collectionName,
          royaltyRate: royalties.toString(),
          collectionCID: collectionIPFS,
          context: context,
        );
      }
      upLoadStatusSubject.sink.add(1);
    } else {
      upLoadStatusSubject.sink.add(0);
    }
    hideLoading(context);
  }
}
