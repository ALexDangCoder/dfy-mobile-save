import 'package:Dfy/presentation/my_account/create_collection/bloc/create_collection_cubit.dart';
import 'package:Dfy/presentation/my_account/create_collection/bloc/extension/ipfs_gen_url.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';

extension Web3Call on CreateCollectionCubit {
  Future<void> sendDataWeb3(BuildContext context) async {
    showLoading();
    await getCollectionIPFS();
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
