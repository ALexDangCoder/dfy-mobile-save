import 'package:Dfy/data/response/collection/collection_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/repository/collection_repository.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class CollectionBloc {
  CollectionBloc() {
    //getCollection();
  }

  //getlistcollection
  BehaviorSubject<List<CollectionResponse>> list = BehaviorSubject();

  //filter collection
  BehaviorSubject<bool> isHardNft = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isSoftNft = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isArt = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isGame = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isCollectibles = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isUltilities = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isOthersCategory = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isCars = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isSports = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isMusic = BehaviorSubject.seeded(false);

  // CollectionRepository get _collectionRepository => Get.find();
  // List<CollectionResponse> arg = [];
  //
  // Future<void> getCollection() async {
  //   final Result<List<CollectionResponse>> result =
  //       await _collectionRepository.getCollection();
  //   result.when(
  //     success: (res) {
  //       arg = res.toList();
  //       list.sink.add(arg);
  //     },
  //     error: (error) {},
  //   );
  //}

  void dispone() {
    isHardNft.close();
    isSoftNft.close();
    isArt.close();
    isGame.close();
    isCollectibles.close();
    isUltilities.close();
    isOthersCategory.close();
    isCars.close();
    isSports.close();
    isMusic.close();
    list.close();
  }
}
