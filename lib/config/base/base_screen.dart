import 'package:Dfy/data/services/market_place/login_service.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/market_place/login_model.dart';
import 'package:Dfy/domain/repository/market_place/login_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/widgets/dialog/dialog_utils.dart';
import 'package:Dfy/widgets/listener/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
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
    eventBus.on<UnAuthEvent>().listen((event) {
      _showUnAuthDialog();
    }).addTo(_unAuthSubscription);
  }

  void _showTimeoutDialog(String msg) {
    Fluttertoast.showToast(msg: msg);
  }

  LoginRepository get _loginRepo => Get.find();

  Future<void> _showUnAuthDialog() async {
    final login = PrefsService.getWalletLogin();
    final loginModel = loginFromJson(login);
    final String refreshToken = loginModel.refreshToken ?? '';
    final result = await _loginRepo.refreshToken(refreshToken);
    result.when(
      success: (res) {
        PrefsService.saveWalletLogin(
          loginToJson(res),
        );
      },
      error: (err) {},
    );
    return;
  }
}
