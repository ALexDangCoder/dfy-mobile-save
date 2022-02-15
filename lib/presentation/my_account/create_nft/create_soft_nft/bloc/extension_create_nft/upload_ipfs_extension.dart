import 'package:Dfy/data/request/nft/create_soft_nft_ipfs_request.dart';
import 'package:Dfy/data/request/nft/properties_map_request.dart';
import 'package:Dfy/presentation/my_account/create_nft/create_soft_nft/bloc/create_nft_cubit.dart';
import 'package:Dfy/utils/app_utils.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/upload_ipfs/pin_to_ipfs.dart';
import 'package:flutter/cupertino.dart';

extension UploadIPFS on CreateNftCubit {
  Future<void> uploadFileToIFPS(BuildContext context) async {
    final dataRequest = CreateSoftNftIpfsRequest(
      collection_id: collectionAddress,
      cover_cid: coverCid,
      description: description,
      file_cid: mediaFileCid,
      file_type: fileType,
      minting_fee_number: mintingFeeNumber.toString(),
      minting_fee_token: mintingFeeToken,
      name: nftName,
      royalties: royalty.toString(),
      properties:
          listProperty.map((e) => PropertiesMapRequest.fromJson(e)).toList(),
    );
    if (mediaType != MEDIA_IMAGE_FILE) {
      upLoadStatusSubject.sink.add(-1);
      mediaFileUploadStatusSubject.sink.add(-1);
      coverPhotoUploadStatusSubject.sink.add(-1);
      coverCid = await ipfsService.pinFileToIPFS(pathFile: coverPhotoPath);
      coverCid.isNotEmpty
          ? coverPhotoUploadStatusSubject.sink.add(1)
          : coverPhotoUploadStatusSubject.sink.add(0);
      mediaFileCid = await ipfsService.pinFileToIPFS(pathFile: mediaFilePath);
      mediaFileCid.isNotEmpty
          ? mediaFileUploadStatusSubject.sink.add(1)
          : mediaFileUploadStatusSubject.sink.add(0);
      if (coverPhotoUploadStatusSubject.value == 0 ||
          mediaFileUploadStatusSubject.value == 0) {
        upLoadStatusSubject.sink.add(0);
      } else {
        showLoading(context);
        nftIPFS = await ipfsService.pinJsonToIPFS(
          type: PinJsonType.SOFT_NFT,
          softNftRequest: dataRequest,
        );
        hideLoading(context);
        if (nftIPFS.isEmpty) {
          upLoadStatusSubject.sink.add(0);
        } else {
          upLoadStatusSubject.sink.add(1);
        }
      }
    } else {
      upLoadStatusSubject.sink.add(-1);
      mediaFileUploadStatusSubject.sink.add(-1);
      mediaFileCid = await ipfsService.pinFileToIPFS(pathFile: mediaFilePath);
      mediaFileCid.isNotEmpty
          ? mediaFileUploadStatusSubject.sink.add(1)
          : mediaFileUploadStatusSubject.sink.add(0);
      if (mediaFileUploadStatusSubject.value != 1) {
        upLoadStatusSubject.sink.add(0);
      } else {
        showLoading(context);
        nftIPFS = await ipfsService.pinJsonToIPFS(
          type: PinJsonType.SOFT_NFT,
          softNftRequest: dataRequest,
        );
        hideLoading(context);
        if (nftIPFS.isEmpty) {
          upLoadStatusSubject.sink.add(0);
        } else {
          upLoadStatusSubject.sink.add(1);
        }
      }
    }
  }
}
