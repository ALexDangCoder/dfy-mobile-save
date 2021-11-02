import 'package:Dfy/domain/model/item.dart';
import 'package:rxdart/rxdart.dart';

class BLocCreateSeedPhrase {
  BLocCreateSeedPhrase() {
    getList();
  }

  BehaviorSubject<List<Item>> listTitle = BehaviorSubject.seeded([]);
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

  void getList() {
    for (final String title in listTitle1) {
      listTitle2.add(Item(title: title));
    }
    listTitle.sink.add(listTitle2);
  }

  void getList2() {
    listTitle.sink.add(listTitle2);
  }
}
