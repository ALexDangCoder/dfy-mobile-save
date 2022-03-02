import 'package:Dfy/domain/env/develop.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/main.dart';
import 'package:get/get.dart';

Future<void> main() async {
  Get.put(AppConstants.fromJson(configDevEnv));
  await mainApp();
}
