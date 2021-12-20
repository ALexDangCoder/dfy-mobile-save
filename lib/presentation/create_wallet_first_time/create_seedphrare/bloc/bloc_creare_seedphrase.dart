import 'dart:async';

import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/create_seed_phrase_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../main.dart';

class BLocCreateSeedPhrase extends Cubit<SeedState> {
  BLocCreateSeedPhrase(this.passWord) : super(SeedInitialState());

  BehaviorSubject<String> nameWallet = BehaviorSubject.seeded('');
  BehaviorSubject<String> isNameWallet = BehaviorSubject.seeded('value');
  BehaviorSubject<bool> isCheckBoxCreateSeedPhrase =
      BehaviorSubject.seeded(true);
  BehaviorSubject<bool> isCheckBoxCreateSeedPhraseConfirm =
      BehaviorSubject.seeded(false);
  BehaviorSubject<String> messStream = BehaviorSubject.seeded('');

  BehaviorSubject<bool> isCheckButtonCreate = BehaviorSubject.seeded(true);
  BehaviorSubject<bool> isCheckButtonConfirm = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isCheckData = BehaviorSubject.seeded(false);
  BehaviorSubject<List<String>> listTitle = BehaviorSubject.seeded([]);
  BehaviorSubject<List<String>> listSeedPhrase = BehaviorSubject.seeded([]);
  BehaviorSubject<bool> isCheckTouchID = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isCheckAppLock = BehaviorSubject.seeded(true);

  BehaviorSubject<bool> isSeedPhraseImportFailed =
      BehaviorSubject.seeded(false);

  Future<void> setFirstTime() async {
    await PrefsService.saveFirstAppConfig('false');
  }

  final String passWord;
  List<String> listTitle1 = [];
  final List<String> listContain = [];
  String passPhrase = '';
  String walletNameCore = '';
  String walletAddress = '';
  String privateKey = '';
  bool configSuccess = false;
  bool isSuccess = false;

  bool getIsSeedPhraseImport() {
    if (listTitle.value.isNotEmpty) {
      return false;
    }
    return true;
  }

  void getIsSeedPhraseImport2() {
    if (getIsSeedPhraseImport() && isCheckBoxCreateSeedPhraseConfirm.value) {
      isCheckButtonConfirm.sink.add(true);
    } else {
      isCheckButtonConfirm.sink.add(false);
    }
  }

  void addListBoxSeedPhrase(String title) {
    listContain.add(title);
    listSeedPhrase.sink.add(listContain);
  }

  void removeListSeedPhrase(int index) {
    final List<String> list = listTitle.value;
    list.removeAt(index);
    listTitle.sink.add(list);
  }

  void addListSeedPhrase(String title) {
    final List<String> listContainBox = listTitle.value;
    listContainBox.add(title);
    listTitle.sink.add(listContainBox);
  }

  void removeListBoxSeedPhrase(int index) {
    final List<String> list = listSeedPhrase.value;
    list.removeAt(index);
    listSeedPhrase.sink.add(list);
  }

  void resetPassPhrase() {
    getStringToList(passPhrase);
    listSeedPhrase.value.clear();
    isCheckBoxCreateSeedPhraseConfirm.sink.add(false);
  }

  void getStringToList(String passPhrase) {
    listTitle1 = passPhrase.split(' ');
    final List<int> indices = List<int>.generate(listTitle1.length, (i) => i);
    indices.shuffle();
    final int newCount = listTitle1.length;
    final List<String> randomList =
        indices.take(newCount).map((i) => listTitle1[i]).toList();
    listTitle.sink.add(randomList);
  }

  void getCheck() {
    String isData = '';
    for (final String value in listSeedPhrase.value) {
      isData += '$value ';
    }
    if ('$passPhrase ' == isData) {
      isSeedPhraseImportFailed.sink.add(false);
    } else {
      isSeedPhraseImportFailed.sink.add(true);
    }
  }

  Future<void> storeWallet({
    required String seedPhrase,
    required String privateKey,
    required String walletName,
    required String walletAddress,
  }) async {
    try {
      final data = {
        'seedPhrase': seedPhrase,
        'walletName': walletName,
        'privateKey': privateKey,
        'walletAddress': walletAddress,
      };
      await trustWalletChannel.invokeMethod('storeWallet', data);
    } on PlatformException {}
  }

  Future<void> generateWallet() async {
    try {
      final data = {};
      await trustWalletChannel.invokeMethod('generateWallet', data);
    } on PlatformException {}
  }

  Future<void> savePassword({
    required String password,
  }) async {
    try {
      final data = {
        'password': password,
      };

      await trustWalletChannel.invokeMethod('savePassword', data);
    } on PlatformException {}
  }

  Future<void> setConfig({
    required bool isAppLock,
    required bool isFaceID,
  }) async {
    try {
      final data = {
        'isAppLock': isAppLock,
        'isFaceID': isFaceID,
      };
      await trustWalletChannel.invokeMethod('setConfig', data);
    } on PlatformException {}
  }

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'generateWalletCallback':
        privateKey = await methodCall.arguments['privateKey'];
        walletAddress = await methodCall.arguments['walletAddress'];
        passPhrase = await methodCall.arguments['passPhrase'];
        walletNameCore = await methodCall.arguments['walletName'];
        getStringToList(passPhrase);
        isCheckData.sink.add(true);
        break;
      case 'storeWalletCallback':
        isSuccess = await methodCall.arguments['isSuccess'];
        emit(SeedNavState());
        break;
      case 'setConfigCallback':
        bool isSuccess = await methodCall.arguments['isSuccess'];
        break;
      case 'savePasswordCallback':
        bool isSuccess = await methodCall.arguments['isSuccess'];
        break;
      default:
        break;
    }
  }

  void validateNameWallet(String _name) {
    if (_name != '') {
      if (_name.length > 20) {
        messStream.sink.add(S.current.name_characters);
        isCheckButtonCreate.sink.add(false);
      } else {
        messStream.sink.add('');
        if (isCheckBoxCreateSeedPhrase.value) {
          isCheckButtonCreate.sink.add(true);
        } else {
          isCheckButtonCreate.sink.add(false);
        }
      }
    } else {
      isCheckButtonCreate.sink.add(false);
      messStream.sink.add(S.current.name_not_null);
    }
  }

  void dispose() {
    isCheckBoxCreateSeedPhrase.close();
    isCheckBoxCreateSeedPhraseConfirm.close();
    nameWallet.close();
    messStream.close();
    isSeedPhraseImportFailed.close();
    isCheckTouchID.close();
    isNameWallet.close();

    listTitle.close();
    listSeedPhrase.close();
  }
}
