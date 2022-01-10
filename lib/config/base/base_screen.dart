import 'package:Dfy/widgets/dialog/dialog_utils.dart';
import 'package:Dfy/widgets/listener/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);
}

abstract class BaseState<T extends BaseScreen> extends State<T> {
  @override
  void initState() {
    super.initState();
    _handleEventBus();
  }

  final CompositeSubscription _unAuthSubscription = CompositeSubscription();

  void _handleEventBus() {
    eventBus.on<TimeOutEvent>().listen((event) {
      _showTimeoutDialog(event.message);
    }).addTo(_unAuthSubscription);
  }

  @override
  void dispose() {
    _unAuthSubscription.clear();
    super.dispose();
  }

  void _showTimeoutDialog(String msg) {
    Fluttertoast.showToast(msg: msg);
  }

// void _showUnAuthDialog() {
//   DialogUtils.showAlert(
//     content: S.current.unauthorized,
//     onConfirm: () {
//       PrefsService.clearAuthData();
//       //todo
//       // openScreenAndRemoveUtil(context, AppRouter.);
//     },
//   );
// }
}
