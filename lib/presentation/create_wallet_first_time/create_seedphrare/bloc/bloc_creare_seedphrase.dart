import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/create_seed_phrase_state.dart';
import 'package:Dfy/utils/extensions/validator.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../main.dart';

class BLocCreateSeedPhrase extends Cubit<SeedState> {
  BLocCreateSeedPhrase(this.passWord) : super(SeedInitialState());

  BehaviorSubject<String> nameWallet = BehaviorSubject.seeded('');
  BehaviorSubject<bool> isCheckBox1 = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isCheckBox2 = BehaviorSubject.seeded(false);

  BehaviorSubject<bool> isCheckButton1 = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isCheckButton = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isCheckData = BehaviorSubject.seeded(false);
  BehaviorSubject<List<String>> listTitle = BehaviorSubject.seeded([]);
  BehaviorSubject<List<String>> listSeedPhrase = BehaviorSubject.seeded([]);
  BehaviorSubject<bool> isCheckTouchID = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isCheckAppLock = BehaviorSubject.seeded(true);

  BehaviorSubject<bool> isSeedPhraseImportFailed =
      BehaviorSubject.seeded(false);

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

  bool isWalletName() {
    if (Validator.validateNotNull(nameWallet.value)) {
      return true;
    }
    return false;
  }

  void getIsSeedPhraseImport2() {
    if (getIsSeedPhraseImport() && isCheckBox2.value) {
      isCheckButton.sink.add(true);
    } else {
      isCheckButton.sink.add(false);
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
    isCheckBox2.sink.add(false);
  }

  void isButton() {
    if (Validator.validateNotNull(nameWallet.value) && isCheckBox1.value) {
      isCheckButton1.sink.add(true);
    } else {
      isCheckButton1.sink.add(false);
    }
  }

  void getStringToList(String passPhrase) {
    listTitle1 = passPhrase.split(' '); //todo remove random
    List<int> indices = List<int>.generate(listTitle1.length, (i) => i);
    indices.shuffle();
    int newCount = listTitle1.length;
    List<String> randomList =
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
    } on PlatformException {
      //todo

    }
  }

  Future<void> generateWallet() async {
    try {
      final data = {};
      await trustWalletChannel.invokeMethod('generateWallet', data);
    } on PlatformException {
      //todo

    }
  }

  Future<void> savePassword({
    required String password,
  }) async {
    try {
      final data = {
        'password': password,
      };

      await trustWalletChannel.invokeMethod('savePassword', data);
    } on PlatformException {
      //todo

    }
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
    } on PlatformException {
      //todo

    }
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
        //todo
        bool isSuccess = await methodCall.arguments['isSuccess'];
        break;
      case 'savePasswordCallback':
        //todo
        bool isSuccess = await methodCall.arguments['isSuccess'];
        print('-----------------------------------$isSuccess');
        break;
      default:
        break;
    }
  }

  void dispose() {
    isCheckBox1.close();
    isCheckBox2.close();
    listTitle.close();
    listSeedPhrase.close();
  }
}
