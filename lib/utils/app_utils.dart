import 'dart:io';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/widgets/dialog/cupertino_loading.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info/package_info.dart';

void hideKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

bool isEmail(String email) {
  return RegExp(EMAIL_REGEX).hasMatch(email);
}

/// validate vietnam phone number
bool isVNPhone(String phone) {
  return RegExp(VN_PHONE).hasMatch(phone);
}

double getWithSize(BuildContext context) {
  final Size size = MediaQuery.of(context).size;
  return size.width;
}

double getHeightSize(BuildContext context) {
  final Size size = MediaQuery.of(context).size;
  return size.height;
}

Future<String> getDeviceName() async {
  if (Platform.isAndroid) {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    //Xiaomi Redmi Note 7
    return '${androidInfo.manufacturer} ${androidInfo.model}';
  }

  if (Platform.isIOS) {
    final iosInfo = await DeviceInfoPlugin().iosInfo;
    //iPhone 11 Pro Max iPhone
    return '${iosInfo.name} ${iosInfo.model}';
  }
  return '';
}

Future<String> getOSName() async {
  if (Platform.isAndroid) {
    final info = await DeviceInfoPlugin().androidInfo;
    // Android 9 (SDK 28)
    return 'Android ${info.version.release} (SDK ${info.version.sdkInt})';
  }

  if (Platform.isIOS) {
    final iosInfo = await DeviceInfoPlugin().iosInfo;
    // iOS 13.1, iPhone 11 Pro Max iPhone
    return '${iosInfo.systemName}, ${iosInfo.systemVersion}';
  }
  return '';
}

String getDevice() {
  if (Platform.isAndroid) {
    return 'android';
  } else if (Platform.isIOS) {
    return 'ios';
  }
  return 'others';
}

Future<String> getAppVersion() async {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}

Future<String> getDeviceId() async {
  final deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    final iosDeviceInfo = await deviceInfo.iosInfo;
    return iosDeviceInfo.identifierForVendor;
  } else if (Platform.isAndroid) {
    final androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.androidId;
  } else {
    return '';
  }
}

void showLoading(BuildContext context, {Function? close}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return WillPopScope(
        child: const Center(
          child: CupertinoLoading(),
        ),
        onWillPop: () async => false,
      );
    },
  ).then(
    (value) {
      if (close != null) close(value);
    },
  );
}

void hideLoading(BuildContext context) {
  Navigator.of(context).pop();
}

void showErrDialog({
  required BuildContext context,
  required String title,
  required String content,
  Function()? onCloseDialog,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: GestureDetector(
            onTap: () {},
            child: Center(
              child: Container(
                constraints: BoxConstraints(minHeight: 177.h),
                width: 312.w,
                decoration: BoxDecoration(
                  color: AppTheme.getInstance().bgBtsColor(),
                  borderRadius: const BorderRadius.all(Radius.circular(36)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 19),
                      child: Text(
                        title,
                        style: textNormal(
                          AppTheme.getInstance().whiteColor(),
                          20,
                        ).copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.only(
                        right: 35,
                        bottom: 24,
                        left: 35,
                      ),
                      child: Text(
                        content,
                        style: textNormal(
                          AppTheme.getInstance().whiteColor(),
                          16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 1.w,
                            color: AppTheme.getInstance()
                                .whiteBackgroundButtonColor(),
                          ),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          if (onCloseDialog != null) {
                            onCloseDialog();
                          }
                          Navigator.pop(context);
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 19,
                            top: 17,
                          ),
                          child: Text(
                            'OK',
                            style: textNormal(
                              AppTheme.getInstance().fillColor(),
                              20,
                            ).copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
