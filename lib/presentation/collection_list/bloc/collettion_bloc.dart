import 'package:rxdart/rxdart.dart';

class CollectionBloc {
  BehaviorSubject<bool> isMyCollection = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isOthers = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isArt = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isGame = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isCollectibles = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isUltilities = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isOthersCategory = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isCars = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isSports = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isMusic = BehaviorSubject.seeded(false);

  void dispone() {
    isMyCollection.close();
    isOthers.close();
    isArt.close();
    isGame.close();
    isCollectibles.close();
    isUltilities.close();
    isOthersCategory.close();
    isCars.close();
    isSports.close();
    isMusic.close();
  }
}
