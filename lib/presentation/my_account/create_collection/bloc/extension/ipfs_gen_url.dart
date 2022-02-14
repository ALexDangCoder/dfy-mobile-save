import 'dart:async';
import 'dart:math';

import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/my_account/create_collection/bloc/create_collection_cubit.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


extension IPFSUpLoad on CreateCollectionCubit{

  ///GET IPFS collection


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
                ApiConstants.GET_BOOL_CUSTOM_URL + appConstants.baseCustomUrl +
                _customUrl;
            final response = await http.get(
              Uri.parse(uri),
            );
            if (response.statusCode == 200) {
              if (response.body == 'true') {
                customUrl = _customUrl;
                mapCheck[CUSTOM_URL_MAP] = true;
              } else {
                customURLSubject.sink.add(S.current.custom_url_taken);
                mapCheck[CUSTOM_URL_MAP] = false;
              }
            } else {
              throw Exception('Get response fail');
            }
          },
        );
      } else {
        mapCheck[CUSTOM_URL_MAP] = false;
        customURLSubject.sink.add(S.current.custom_url_err);
      }
    } else {
      mapCheck[CUSTOM_URL_MAP] = true;
      customURLSubject.sink.add('');
    }
  }
}