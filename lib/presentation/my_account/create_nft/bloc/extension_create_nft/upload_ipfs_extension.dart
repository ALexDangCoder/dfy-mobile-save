import 'package:Dfy/presentation/my_account/create_nft/bloc/create_nft_cubit.dart';
import 'package:Dfy/presentation/my_account/create_nft/bloc/extension_create_nft/core_bc.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/upload_ipfs/pin_file_to_ipfs.dart';
import 'package:Dfy/utils/upload_ipfs/pin_json_to_ipfs.dart';

extension UploadIPFS on CreateNftCubit {
  Future<void> uploadFileToIFPS() async {
    if (mediaType != MEDIA_IMAGE_FILE) {
      upLoadStatusSubject.sink.add(-1);
      mediaFileUploadStatusSubject.sink.add(-1);
      coverPhotoUploadStatusSubject.sink.add(-1);
      coverCid = await pinFileToIPFS(pathFile: coverPhotoPath);
      coverCid.isNotEmpty
          ? coverPhotoUploadStatusSubject.sink.add(1)
          : coverPhotoUploadStatusSubject.sink.add(0);
      mediaFileCid = await pinFileToIPFS(pathFile: mediaFilePath);
      mediaFileCid.isNotEmpty
          ? mediaFileUploadStatusSubject.sink.add(1)
          : mediaFileUploadStatusSubject.sink.add(0);
      if (coverPhotoUploadStatusSubject.value == 0 ||
          mediaFileUploadStatusSubject.value == 0) {
        upLoadStatusSubject.sink.add(0);
      } else {
        upLoadStatusSubject.sink.add(1);
      }
    } else {
      upLoadStatusSubject.sink.add(-1);
      mediaFileUploadStatusSubject.sink.add(-1);
      mediaFileCid = await pinFileToIPFS(pathFile: mediaFilePath);
      mediaFileCid.isNotEmpty
          ? mediaFileUploadStatusSubject.sink.add(1)
          : mediaFileUploadStatusSubject.sink.add(0);
      mediaFileUploadStatusSubject.value == 1
          ? upLoadStatusSubject.sink.add(1)
          : upLoadStatusSubject.sink.add(0);
    }
    final Map<String, dynamic> jsonMap = {
      'collection_id': collectionAddress,
      'cover_cid': coverCid,
      'description': description,
      'file_cid': mediaFileCid,
      'file_type': fileType,
      'minting_fee_number': mintingFeeNumber.toString(),
      'minting_fee_token': mintingFeeToken,
      'name': nftName,
      'properties': listProperty.toString(),
      'royalties': royalty.toString(),
    };
    nftIPFS = await pinJsonToIPFS(bodyMap: jsonMap);
    await getTransactionData();
  }
}
