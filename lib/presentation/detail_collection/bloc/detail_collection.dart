import 'package:rxdart/rxdart.dart';

class DetailCollectionBloc {
// fillter nft
  BehaviorSubject<bool> isHardNft = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isSoftNft = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isOnSale = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isOnPawn = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isOnAuction = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isNotOnMarket = BehaviorSubject.seeded(false);
  BehaviorSubject<String> textSearch = BehaviorSubject.seeded('');

  void search() {
    textSearch.stream
        .debounceTime(
      const Duration(
        seconds: 1,
      ),
    )
        .listen((event) {
      if (event.length == '') {
        print(event);
      }
      print(event);
    });
  }

  void dispone() {
    isHardNft.close();
    isSoftNft.close();
    isOnSale.close();
    isOnPawn.close();
    isOnAuction.close();
    isNotOnMarket.close();
    textSearch.close();
  }
}
