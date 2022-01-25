import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> pinJsonToIPFS({
  required Map<String, dynamic> bodyMap,
}) async {
  String ipfsHash = '';
  final Map<String, dynamic> body = bodyMap;
  final headers = {
    'pinata_api_key': 'ac8828bff3bcd1c1b828',
    'pinata_secret_api_key':
        'cd1b0dc4478a40abd0b80e127e1184697f6d2f23ed3452326fe92ff3e92324df'
  };
  try {
    final response = await http.post(
      Uri.parse('https://api.pinata.cloud/pinning/pinJSONToIPFS'),
      headers: headers,
      body: body,
    );
    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      ipfsHash = map['IpfsHash'];
    }
  } catch (e) {
    rethrow;
  }
  return ipfsHash;
}
