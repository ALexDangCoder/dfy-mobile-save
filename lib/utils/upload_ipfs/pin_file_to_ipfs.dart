import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

///Upload image IPFS
Future<String> pinFileToIPFS({
  required String pathFile,
}) async {
  String ipfsHash = '';
  try {
    final headers = {
      'pinata_api_key': 'ac8828bff3bcd1c1b828',
      'pinata_secret_api_key':
          'cd1b0dc4478a40abd0b80e127e1184697f6d2f23ed3452326fe92ff3e92324df'
    };
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('https://api.pinata.cloud/pinning/pinFileToIPFS?file'),
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
    rethrow;
  }
  return ipfsHash;
}

int uploadTimeCalculate(int fileSize){
  if(fileSize!=0){
    return (fileSize/1000000).round() + 1;
  }
  return 0;
}
