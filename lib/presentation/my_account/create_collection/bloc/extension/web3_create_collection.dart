import 'package:Dfy/presentation/my_account/create_collection/bloc/create_collection_cubit.dart';
import 'package:Dfy/presentation/my_account/create_collection/bloc/extension/ipfs_gen_url.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';

extension Web3Call on CreateCollectionCubit {
  Future<void> sendDataWeb3(BuildContext context) async {
    showLoading();
    const prefixURL = 'https://marketplace.defiforyou.uk/';
    await generateRandomURL();
    final Map<String, dynamic> jsonBody = {
      'external_link':
    'https://defiforyou.mypinata.cloud/ipfs/${cidMap['avatar_cid']}',
    'feature_cid': cidMap['feature_cid'],
    'image': 'https://defiforyou.mypinata.cloud/ipfs/${cidMap['avatar_cid']}',
    'name': collectionName,
    'custom_url': '$prefixURL$customUrl',
    'avatar_cid': cidMap['avatar_cid'],
    'category': categoryId,
    'cover_cid': cidMap['cover_cid'],
    'social_links': socialLinkMap.toString(),
    };
    collectionIPFS = await ipfsService.pinJsonToIPFS(bodyMap : jsonBody);
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
    showContent();
  }
}
