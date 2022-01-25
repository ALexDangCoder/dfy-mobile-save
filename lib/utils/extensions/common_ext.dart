import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> launchMail(
    {required String email, String? subject = '', String? body = '',}) async {
  try {
    await launch('mailto:$email?subject=$subject&body=$body');
  } catch (e) {
    rethrow;
  }
}


void updateLocale() {
  Get.updateLocale(
    Locale.fromSubtags(languageCode: PrefsService.getLanguage()),);
}
