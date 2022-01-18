import 'dart:async';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:rxdart/rxdart.dart';

import 'menu_account_state.dart';

class MenuAccountCubit extends BaseCubit<MenuAccountState> {
  MenuAccountCubit() : super(NoLoginState());

  final BehaviorSubject<String?> _addressWalletSubject =
      BehaviorSubject.seeded('seedValue');

  Stream<String?> get addressWalletStream => _addressWalletSubject.stream;

  Future<void> logout() async {
    showLoading();
    await Future.delayed(const Duration(seconds: 2));
    _addressWalletSubject.add(null);
    showContent();
  }
}
