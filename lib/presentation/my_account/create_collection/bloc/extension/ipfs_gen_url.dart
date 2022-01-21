import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/my_account/create_collection/bloc/create_collection_cubit.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


extension IPFSUpLoad on CreateCollectionCubit{
  ///Upload image IPFS
  Future<String> uploadImageToIPFS({
    required String bin,
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
      request.files.add(await http.MultipartFile.fromPath('file', bin));
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

  ///GET IPFS collection
  Future<void> getCollectionIPFS() async {
    const prefixURL = 'https://marketplace.defiforyou.uk/';
    await generateRandomURL();
    String ipfsHash = '';
    final Map<String, dynamic> body = {
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
    collectionIPFS = ipfsHash;
  }

  ///Gen random URL
  Future<void> generateRandomURL({int len = 11}) async {
    final r = Random();
    const _chars = 'abcdefghijklmnopqrstuvwxyz_0123456789';
    final autogenURL =
    List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
    final appConstants = Get.find<AppConstants>();
    final String uri =
        appConstants.baseUrl + ApiConstants.GET_BOOL_CUSTOM_URL + autogenURL;
    try {
      final response = await http.get(
        Uri.parse(uri),
      );
      if (response.statusCode == 200) {
        if (response.body == 'true') {
          customUrl = autogenURL;
        } else {
          customUrl = '';
          await generateRandomURL();
        }
      } else {
        showError();
      }
    } catch (e) {
      rethrow;
    }
  }

  ///validate custom URL
  Future<void> validateCustomURL(String _customUrl) async {
    if (debounceTime != null) {
      if (debounceTime!.isActive) {
        debounceTime!.cancel();
      }
    }
    if (_customUrl.isNotEmpty) {
      if (_customUrl.length > 255) {
        customURLSubject.sink.add(S.current.maximum_len);
      } else if (reg.hasMatch(_customUrl)) {
        customURLSubject.sink.add('');
        debounceTime = Timer(
          const Duration(milliseconds: 500),
              () async {
            final appConstants = Get.find<AppConstants>();
            final String uri = appConstants.baseUrl +
                ApiConstants.GET_BOOL_CUSTOM_URL +
                _customUrl;
            final response = await http.get(
              Uri.parse(uri),
            );
            if (response.statusCode == 200) {
              if (response.body == 'true') {
                customUrl = _customUrl;
                mapCheck['custom_url'] = true;
              } else {
                customURLSubject.sink.add(S.current.custom_url_taken);
                mapCheck['custom_url'] = false;
              }
            } else {
              throw Exception('Get response fail');
            }
          },
        );
      } else {
        mapCheck['custom_url'] = false;
        customURLSubject.sink.add(S.current.custom_url_err);
      }
    } else {
      mapCheck['custom_url'] = true;
      customURLSubject.sink.add('');
    }
  }
}