import 'package:rxdart/rxdart.dart';

class DetailCollectionBloc {
  // fillter nft

  BehaviorSubject<bool> isHardNft = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isSoftNft = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isOnSale = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isOnPawn = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isOnAuction = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isNotOnMarket = BehaviorSubject.seeded(false);

  void dispone() {
    isHardNft.close();
    isSoftNft.close();
    isOnSale.close();
    isOnPawn.close();
    isOnAuction.close();
    isNotOnMarket.close();
  }
}
