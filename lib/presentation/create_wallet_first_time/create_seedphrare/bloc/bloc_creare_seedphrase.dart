import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/item.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/create_seed_phrase_state.dart';
import 'package:Dfy/utils/extensions/validator.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../main.dart';

class BLocCreateSeedPhrase extends Cubit<SeedState> {
  BLocCreateSeedPhrase(this.passWord) : super(SeedInitialState());

  BehaviorSubject<String> nameWallet = BehaviorSubject.seeded('Account 1');
  BehaviorSubject<bool> isCheckBox1 = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isCheckBox2 = BehaviorSubject.seeded(false);

  BehaviorSubject<bool> isCheckButton1 = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isCheckButton = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isCheckData = BehaviorSubject.seeded(false);
  BehaviorSubject<List<Item>> listTitle = BehaviorSubject.seeded([]);
  BehaviorSubject<List<Item>> listSeedPhrase = BehaviorSubject.seeded([]);
  BehaviorSubject<bool> isCheckTouchID = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isCheckAppLock = BehaviorSubject.seeded(true);

  BehaviorSubject<bool> isSeedPhraseImportFailed =
      BehaviorSubject.seeded(false);

  final String passWord;

  Future<void> generateWallet({String password = ''}) async {
    try {
      final data = {
        'password': password,
      };
      await trustWalletChannel.invokeMethod('generateWallet', data);
    } on PlatformException {
      //todo

    }
  }

  bool getIsSeedPhraseImport() {
    for (final Item item in listTitle.value) {
      if (!item.isCheck) {
        return false;
      }
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

  Future<void> storeWallet({
    String password = '',
    required String seedPhrase,
    required String walletName,
  }) async {
    try {
      final data = {
        'seedPhrase': seedPhrase,
        'walletName': walletName,
        'password': password,
      };
      await trustWalletChannel.invokeMethod('storeWallet', data);
    } on PlatformException {
      //todo

    }
  }

  Future<void> setConfig({
    required String password,
    required bool isAppLock,
    required bool isFaceID,
  }) async {
    try {
      final data = {
        'isAppLock': isAppLock,
        'isFaceID': isFaceID,
        'password': password,
      };
      await PrefsService.saveFirstAppConfig('false');
      await PrefsService.saveAppLockConfig(isAppLock.toString());
      await PrefsService.saveFaceIDConfig(isFaceID.toString());
      await trustWalletChannel.invokeMethod('setConfig', data);
    } on PlatformException {
      //todo

    }
  }

  String passPhrase = '';
  String walletAddress = '';
  String privateKey = '';
  bool configSuccess = false;

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'generateWalletCallback':
        privateKey = await methodCall.arguments['privateKey'];
        walletAddress = await methodCall.arguments['walletAddress'];
        passPhrase = await methodCall.arguments['passPhrase'];
        getStringToList(passPhrase);
        isCheckData.sink.add(true);
        break;
      case 'storeWalletCallback':
        final bool isSuccess = await methodCall.arguments['isSuccess'];
        emit(SeedNavState());
        break;
      case 'setConfigCallback':
        bool isSuccess = await methodCall.arguments['isSuccess'];
        break;
      default:
        break;
    }
  }


  void isButton() {
    if (Validator.validateNotNull(nameWallet.value) && isCheckBox1.value) {
      isCheckButton1.sink.add(true);
    } else {
      isCheckButton1.sink.add(false);
    }
  }

  void getStringToList(String passPhrase) {
    listTitle1 = passPhrase.split(' ');
    getListTitle();
  }

  void getCheck() {
    String isData = '';
    for (final Item value in listTitle3) {
      isData += '${value.title} ';
    }
    if ('$passPhrase ' == isData) {
      isSeedPhraseImportFailed.sink.add(false);
    } else {
      isSeedPhraseImportFailed.sink.add(true);
    }
  }

  List<String> listTitle1 = [];
  final List<Item> listTitle2 = [];
  final List<Item> listTitle3 = [];

  void reloadListTitleBox(String title) {
    for (final Item value in listTitle2) {
      if (value.title == title) {
        value.isCheck = false;
      }
    }
    listTitle.sink.add(listTitle2);
  }

  void getListTitle() {
    for (final String title in listTitle1) {
      listTitle2.add(Item(title: title));
    }
    listTitle.sink.add(listTitle2);
    reloadListSeedPhrase();
  }

  void reloadListSeedPhrase() {
    listSeedPhrase.sink.add(listTitle3);
  }

  void reloadListSeedPhrase1() {
    listSeedPhrase.sink.add([]);
    for (final Item value in listTitle.value) {
      value.isCheck = false;
    }
    listTitle3.clear();
    isCheckBox2.sink.add(false);
  }

  void reloadListTitle() {
    listTitle.sink.add(listTitle2);
    reloadListSeedPhrase();
  }

  void dispose() {
    isCheckBox1.close();
    isCheckBox2.close();
    listTitle.close();
    listSeedPhrase.close();
  }
}
