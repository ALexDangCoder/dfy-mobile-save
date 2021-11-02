import 'package:Dfy/config/app_config.dart';
import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/utils/constants/app_constants.dart';

class AppTheme {
  static AppColor? _instance;

  static AppColor getInstance() {
    _instance ??= AppMode.LIGHT == APP_THEME ? LightApp() : DarkApp();
    return _instance!;
  }
}
