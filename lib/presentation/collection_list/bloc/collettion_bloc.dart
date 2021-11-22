import 'package:Dfy/data/response/collection/collection_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/repository/collection_repository.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class CollectionBloc {
  CollectionBloc() {
    getCollection();
  }

  //getlistcollection
  BehaviorSubject<List<CollectionRespone>> list = BehaviorSubject();

  //filter collection
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

  CollectionRepository get _collectionRepository => Get.find();
  List<CollectionRespone> arg = [];

  Future<void> getCollection() async {
    final Result<List<CollectionRespone>> result =
        await _collectionRepository.getCollection();
    result.when(
      success: (res) {
        arg = res.toList();
        list.sink.add(arg);
      },
      error: (error) {},
    );
  }

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
    list.close();
  }
}
