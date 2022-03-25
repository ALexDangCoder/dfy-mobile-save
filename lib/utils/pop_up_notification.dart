import 'dart:async';
import 'dart:ui';

import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/transaction_submit/transaction_fail.dart';
import 'package:Dfy/presentation/transaction_submit/transaction_submit.dart';
import 'package:Dfy/presentation/transaction_submit/transaction_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'constants/app_constants.dart';

/// show dialog loading
Future<void> showLoadingDialog(BuildContext context,
    {bool? showLoading}) async {
  final navigator = Navigator.of(context);
  await navigator.push(
    PageRouteBuilder(
      reverseTransitionDuration: Duration.zero,
      transitionDuration: Duration.zero,
      pageBuilder: (_, animation, ___) {
        return Scaffold(
          backgroundColor: Colors.black.withOpacity(0.4),
          body: Center(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 2.0, sigmaX: 2.0),
              child: TransactionSubmit(
                justLoading: showLoading,
              ),
            ),
          ),
        );
      },
      opaque: false,
    ),
  );
}

/// show dialog Error
Future<void> showLoadFail(BuildContext context) async {
  final navigator = Navigator.of(context);
  unawaited(
    navigator.push(
      PageRouteBuilder(
        reverseTransitionDuration: Duration.zero,
        transitionDuration: Duration.zero,
        pageBuilder: (_, animation, ___) {
          return Scaffold(
            backgroundColor: Colors.black.withOpacity(0.4),
            body: Center(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 2.0, sigmaX: 2.0),
                child: TransactionSubmitFail(
                  content: S.current.transaction_failed,
                ),
              ),
            ),
          );
        },
        opaque: false,
      ),
    ),
  );
  await Future.delayed(const Duration(seconds: secondShowPopUp), () {
    navigator.pop();
  });
}

/// show dialog success
Future<void> showLoadSuccess(BuildContext context, {bool? onlySuccess}) async {
  final navigator = Navigator.of(context);
  unawaited(
    navigator.push(
      PageRouteBuilder(
        reverseTransitionDuration: Duration.zero,
        transitionDuration: Duration.zero,
        pageBuilder: (_, animation, ___) {
          return Scaffold(
            backgroundColor: Colors.black.withOpacity(0.4),
            body: Center(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 2.0, sigmaX: 2.0),
                child: TransactionSubmitSuccess(
                  onlySuccess: onlySuccess,
                ),
              ),
            ),
          );
        },
        opaque: false,
      ),
    ),
  );
  await Future.delayed(const Duration(seconds: secondShowPopUp), () {
    navigator.pop();
  });
}
