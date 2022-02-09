import 'package:Dfy/presentation/my_account/create_collection/bloc/create_collection_cubit.dart';
import 'package:Dfy/presentation/my_account/create_collection/bloc/extension/ipfs_gen_url.dart';
import 'package:Dfy/utils/app_utils.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:flutter/material.dart';

extension Web3Call on CreateCollectionCubit {
  Future<void> sendDataWeb3(BuildContext context) async {
    const prefixURL = ApiConstants.PREFIX_CUSTOM_URL;
    await generateRandomURL();
    final Map<String, dynamic> jsonBody = {
      'external_link':
          ApiConstants.URL_BASE + cidMap.getStringValue('avatar_cid'),
      'feature_cid': cidMap.getStringValue('feature_cid'),
      'image': ApiConstants.URL_BASE + (cidMap.getStringValue('avatar_cid')),
      'name': collectionName,
      'custom_url': '$prefixURL$customUrl',
      'avatar_cid': cidMap['avatar_cid'],
      'category': categoryId,
      'cover_cid': cidMap['cover_cid'],
      'social_links': socialLinkMap.toString(),

    };
    collectionIPFS = await ipfsService.pinJsonToIPFS(bodyMap: jsonBody);
    if (collectionIPFS.isNotEmpty){
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
