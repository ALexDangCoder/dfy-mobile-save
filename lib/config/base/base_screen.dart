import 'package:Dfy/widgets/dialog/dialog_utils.dart';
import 'package:Dfy/widgets/listener/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);
}

abstract class BaseStateScreen<T extends BaseScreen> extends State<T>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    _handleEventBus();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    _unAuthSubscription.clear();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  final CompositeSubscription _unAuthSubscription = CompositeSubscription();

  void _handleEventBus() {
    eventBus.on<TimeOutEvent>().listen((event) {
      _showTimeoutDialog(event.message);
    }).addTo(_unAuthSubscription);
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
