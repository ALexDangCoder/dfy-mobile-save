
import 'package:Dfy/domain/model/item.dart';
import 'package:rxdart/rxdart.dart';

class BLocCreateSeedPhrase {
  BLocCreateSeedPhrase() {
    getList();
  }

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

  void getList4(String title) {
    for (final Item value in listTitle2) {
      if (value.title == title) {
        value.isCheck = false;
      }
    }
    listTitle.sink.add(listTitle2);
  }

  void getList() {
    for (final String title in listTitle1) {
      listTitle2.add(Item(title: title));
    }
    listTitle.sink.add(listTitle2);
    getList3();
  }

  void getList3() {
    listSeedPhrase.sink.add(listTitle3);
  }

  void getList2() {
    listTitle.sink.add(listTitle2);
    getList3();
  }
}
