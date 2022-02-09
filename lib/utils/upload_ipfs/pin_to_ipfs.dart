import 'dart:async';
import 'dart:convert';

import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class PinToIPFS {
  ///Upload image IPFS to get image cid

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
        ipfsHash = map['IpfsHash'];
      }
    } catch (e) {
      return ipfsHash;
    }
    return ipfsHash;
  }


  ///pin JSON IPFS to get collection(NFT) cid
  Future<String> pinJsonToIPFS({
    required Map<String, dynamic> bodyMap,
  }) async {
    String ipfsHash = '';
    final Map<String, dynamic> body = bodyMap;
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.PIN_JSON_TO_IPFS),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        final map = json.decode(response.body);
        ipfsHash = map['IpfsHash'];
      }
    } catch (e) {
      return ipfsHash;
    }
    return ipfsHash;
  }


  int uploadTimeCalculate(int fileSize) {
    if (fileSize > 0) {
      return (fileSize / 1000000).round() + 1;
    }
    return 0;
  }
}
