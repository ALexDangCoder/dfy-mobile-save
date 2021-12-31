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

  void resetFilterActivity() {
    isTransfer.sink.add(false);
    isPutOnMarket.sink.add(false);
    isCancelMarket.sink.add(false);
    isBurn.sink.add(false);
    isLike.sink.add(false);
    isReport.sink.add(false);
    isBuy.sink.add(false);
    isBid.sink.add(false);
    isReceiveOffer.sink.add(false);
    isSignContract.sink.add(false);
    isAllActivity.sink.add(false);
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
