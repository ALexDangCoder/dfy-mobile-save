import 'package:Dfy/domain/model/item.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../main.dart';

class BLocCreateSeedPhrase {
  BLocCreateSeedPhrase() {
    getListTitle();
  }

  dispose() {
    isCheckBox1.close();
    isCheckBox2.close();
    listTitle.close();
    listSeedPhrase.close();
  }

  BehaviorSubject<bool> isCheckBox1 = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isCheckBox2 = BehaviorSubject.seeded(false);
  BehaviorSubject<List<Item>> listTitle = BehaviorSubject.seeded([]);
  BehaviorSubject<List<Item>> listSeedPhrase = BehaviorSubject.seeded([]);
  List<String> listTitle1 = [
    'happy',
    'lovely',
    'eternity',
    'victory',
    'school',
    'trust',
    'careful',
    'success',
    'confident',
    'drama',
    'patient',
    'hold',
  ];
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

  void reloadListTitle() {
    listTitle.sink.add(listTitle2);
    reloadListSeedPhrase();
  }

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'checkPasswordCallback':
        break;
      case 'storeWalletCallback':
        bool isSuccess = methodCall.arguments['isSuccess'];
        break;
      default:
        break;
    }
  }

  Future<void> storeWallet(
    bool isAppLock,
    bool isFaceID,
    String password,
  ) async {
    try {
      final data = {
        'isAppLock': isAppLock,
        'isFaceID': isFaceID,
        'password': password,
      };
      await trustWalletChannel.invokeListMethod('storeWallet', data);
    } on PlatformException {}
  }
}
