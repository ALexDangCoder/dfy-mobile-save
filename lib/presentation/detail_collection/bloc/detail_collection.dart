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
  BehaviorSubject<bool> isShowMoreStream = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isAll = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isAllStatus = BehaviorSubject.seeded(false);

  //filter activity
  BehaviorSubject<bool> isTransfer = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isPutOnMarket = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isCancelMarket = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isBurn = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isLike = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isReport = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isBuy = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isBid = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isReceiveOffer = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isSignContract = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isAllActivity = BehaviorSubject.seeded(false);

  void resetFilterActivity(bool value) {
    isTransfer.sink.add(value);
    isPutOnMarket.sink.add(value);
    isCancelMarket.sink.add(value);
    isBurn.sink.add(value);
    isLike.sink.add(value);
    isReport.sink.add(value);
    isBuy.sink.add(value);
    isBid.sink.add(value);
    isReceiveOffer.sink.add(value);
    isSignContract.sink.add(value);
    isAllActivity.sink.add(value);
  }

  void allTypeNft(bool value) {
    isHardNft.sink.add(value);
    isSoftNft.sink.add(value);
  }

  void allStatusNft(bool value) {
    isNotOnMarket.sink.add(value);
    isOnAuction.sink.add(value);
    isOnSale.sink.add(value);
    isOnPawn.sink.add(value);
  }

//Transfer
// Put on market
// Cancel market
// Burn
// Like
// Report
// Buy
// Bid
// Receive offer
// Sign contract
  void reset() {
    isAll.sink.add(false);
    isHardNft.sink.add(false);
    isOnSale.sink.add(false);
    isSoftNft.sink.add(false);
    isOnPawn.sink.add(false);
    isOnAuction.sink.add(false);
    isNotOnMarket.sink.add(false);
    isAllStatus.sink.add(false);
  }

  void search() {
    textSearch.stream
        .debounceTime(
      const Duration(
        seconds: 1,
      ),
    )
        .listen((event) {
      if (event.length == '') {}
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
