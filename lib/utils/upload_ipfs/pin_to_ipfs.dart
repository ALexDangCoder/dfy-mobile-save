import 'dart:async';
import 'dart:convert';

import 'package:Dfy/data/request/collection/create_collection_ipfs_request.dart';
import 'package:Dfy/data/request/nft/create_soft_nft_ipfs_request.dart';
import 'package:Dfy/domain/repository/pinata/pinata_repository.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PinToIPFS {
  ///Upload image IPFS to get image cid
  PinataRepository get _pinataRepo => Get.find();
  final headers = {
    'pinata_api_key': ApiConstants.PINATA_API_KEY,
    'pinata_secret_api_key': ApiConstants.PINATA_SECRET_API_KEY
  };

  Future<String> pinFileToIPFS({
    required String pathFile,
  }) async {
    String ipfsHash = '';
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiConstants.PIN_FILE_TO_IPFS),
      );
      request.files.add(await http.MultipartFile.fromPath('file', pathFile));
      request.headers.addAll(headers);
      final http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        final Map<String, dynamic> map =
            jsonDecode(await response.stream.bytesToString());
        ipfsHash = map.getStringValue('IpfsHash');
      }
    } catch (e) {
      return ipfsHash;
    }
    return ipfsHash;
  }

  ///pin JSON IPFS to get collection(NFT) cid
  Future<String> pinJsonToIPFS({
    required PinJsonType type,
    CreateSoftNftIpfsRequest? softNftRequest,
    CreateCollectionIpfsRequest? collectionRequest,
  }) async {
    switch (type) {
      case PinJsonType.SOFT_NFT:
        final result = await _pinataRepo.createSoftNftPinJsonToIpfs(
          softNftRequest ?? CreateSoftNftIpfsRequest.init(),
        );
        return result.when(
          success: (res) {
            return res.ipfsHash;
          },
          error: (error) {
            return '';
          },
        );
      case PinJsonType.COLLECTION:
        final result = await _pinataRepo.createCollectionPinJsonToIpfs(
          collectionRequest ?? CreateCollectionIpfsRequest.init(),
        );
        return result.when(
          success: (res) {
            return res.ipfsHash;
          },
          error: (error) {
            return '';
          },
        );
    }
  }

  int uploadTimeCalculate(int fileSize) {
    if (fileSize > 0) {
      return (fileSize / 1000000).round() + 1;
    }
    return 0;
  }
}

enum PinJsonType {
  SOFT_NFT,
  COLLECTION,
}
