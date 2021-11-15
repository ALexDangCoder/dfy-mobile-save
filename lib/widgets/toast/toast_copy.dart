import 'package:Dfy/generated/l10n.dart';
import 'package:fluttertoast/fluttertoast.dart';

toast_copy() => Fluttertoast.showToast(
      msg: S.current.copy,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
    );
