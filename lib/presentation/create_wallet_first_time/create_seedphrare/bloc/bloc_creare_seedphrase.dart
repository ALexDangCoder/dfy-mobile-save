import 'package:Dfy/domain/model/item.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../main.dart';

class BLocCreateSeedPhrase {
  BLocCreateSeedPhrase(this.passWord);

  BehaviorSubject<bool> isCheckBox1 = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isCheckBox2 = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isCheckData = BehaviorSubject.seeded(false);
  BehaviorSubject<List<Item>> listTitle = BehaviorSubject.seeded([]);
  BehaviorSubject<List<Item>> listSeedPhrase = BehaviorSubject.seeded([]);
  final String passWord;

  Future<void> generateWallet({required String password}) async {
    try {
      final data = {
        'password': password,
      };
      await trustWalletChannel.invokeMethod('generateWallet', data);
    } on PlatformException {
      //todo

    }
  }

  String passPhrase = '';
   String walletAddress = '';
   String privateKey = '';

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'generateWalletCallback':
        privateKey = await methodCall.arguments['privateKey'];
        walletAddress = await methodCall.arguments['walletAddress'];
        passPhrase = await methodCall.arguments['passPhrase'];
        getStringToList(passPhrase);
        isCheckData.sink.add(true);
        break;
      default:
        break;
    }
  }

  void getStringToList(String passPhrase) {
    listTitle1 = passPhrase.split(' ');
    getListTitle();
  }

  bool getCheck() {
    String isData = '';
    for (final Item value in listTitle3) {
      isData += value.title + ' ';
    }
    if (passPhrase + ' ' == isData) {
      return true;
    }
    return false;
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

  void reloadListTitle() {
    listTitle.sink.add(listTitle2);
    reloadListSeedPhrase();
  }

  dispose() {
    isCheckBox1.close();
    isCheckBox2.close();
    listTitle.close();
    listSeedPhrase.close();
  }
}
