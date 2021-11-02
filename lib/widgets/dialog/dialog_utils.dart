import 'package:Dfy/utils/get_ext.dart';
import 'package:Dfy/widgets/dialog/android_dialog_widget.dart';
import 'package:Dfy/widgets/dialog/cupertino_loading.dart';
import 'package:Dfy/widgets/dialog/ios_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class DialogUtils {
  static void showAlert({
    bool cancelable = false,
    @required String? content,
    String? title,
    TextStyle? titleStyle,
    TextStyle? contentStyle,
    String? ok,
    String? cancel,
    Function? onConfirm,
    Function? onCancel,
  }) {
    if (Get.isDialogOpen == true) return;
    Get.dialog(
      isAndroid()
          ? AndroidDialog(
              onWillPop: cancelable,
              content: content,
              title: title,
              titleStyle: titleStyle,
              contentStyle: contentStyle,
              ok: ok,
              cancel: cancel,
              onConfirm: onConfirm,
              onCancel: onCancel,
            )
          : IOSDialog(
              content: content,
              title: title,
              titleStyle: titleStyle,
              contentStyle: contentStyle,
              ok: ok,
              cancel: cancel,
              onConfirm: onConfirm,
              onCancel: onCancel,
            ),
      barrierDismissible: cancelable,
    );
  }

  static void showLoading() {
    Get.dialog(
      WillPopScope(
        child: const Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          child: Center(child: CupertinoLoading()),
        ),
        onWillPop: () async => false,
      ),
      barrierDismissible: false,
    );
  }

  static void hideLoading() {
    if (Get.isDialogOpen == true) Get.back();
  }

  static void dismiss() {
    if (Get.isDialogOpen == true) Get.back();
  }
}

Future<bool?> showToast(
  String msg, {
  Toast length = Toast.LENGTH_SHORT,
  ToastGravity gravity = ToastGravity.BOTTOM,
}) {
  Fluttertoast.cancel();
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: length,
    gravity: gravity,
    fontSize: 14,
    backgroundColor: Colors.black,
    textColor: Colors.white.withOpacity(0.8),
  );
}
