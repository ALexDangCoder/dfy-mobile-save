import 'package:Dfy/domain/model/item.dart';
import 'package:rxdart/rxdart.dart';

class BLocCreateSeedPhrase {
  BLocCreateSeedPhrase() {
    getListTitle();
  }

  BehaviorSubject<bool> isCheck = BehaviorSubject.seeded(false);

  BehaviorSubject<bool> isCheck2 = BehaviorSubject.seeded(false);
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
}
