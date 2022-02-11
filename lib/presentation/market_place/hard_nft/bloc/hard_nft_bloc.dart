import 'dart:developer';

import 'package:Dfy/domain/model/evaluation_hard_nft.dart';
import 'package:rxdart/rxdart.dart';

class HardNFTBloc {
  List<String> listImg = [];

  void getListImage(Evaluation evaluation) {
    for (int i = 0; i < (evaluation.media?.length ?? 0); i++) {
      listImg.add(evaluation.media![i].urlImage ?? '');
    }
    final tempList = listImg.toSet();
    listImg = tempList.toList();
  }

  ///clear fake Data
  int currentIndexImage = 0;
  String currentImage = '';
  bool showMore = false;

  final BehaviorSubject<String> _imageSubject = BehaviorSubject();

  final BehaviorSubject<bool> _showPreSubject = BehaviorSubject();

  final BehaviorSubject<bool> _showNextSubject = BehaviorSubject();

  final BehaviorSubject<bool> _showMoreSubject = BehaviorSubject();

  final BehaviorSubject<int> _changeTabSubject = BehaviorSubject();

  Stream<String> get imageStream => _imageSubject.stream;

  Stream<bool> get showPreStream => _showPreSubject.stream;

  Stream<bool> get showNextStream => _showNextSubject.stream;

  Stream<bool> get showMoreStream => _showMoreSubject.stream;

  Stream<int> get changeTabStream => _changeTabSubject.stream;

  void changeImage(String _img) {
    if (currentImage != '') {
      getIndex(_img);
    }
    checkButton();
    currentImage = listImg[currentIndexImage];
    _imageSubject.sink.add(currentImage);
    getIndex(currentImage);
  }

  void nextImage() {
    if (currentIndexImage < listImg.length - 1) {
      currentImage = listImg[currentIndexImage + 1];
      _imageSubject.sink.add(currentImage);
      _showPreSubject.sink.add(true);
      _showNextSubject.sink.add(currentIndexImage != listImg.length - 2);
      getIndex(currentImage);
    }
  }

  void preImage() {
    if (currentIndexImage > 0) {
      currentImage = listImg[currentIndexImage - 1];
      _imageSubject.sink.add(currentImage);
      _showNextSubject.sink.add(true);
      _showPreSubject.sink.add((currentIndexImage - 1) != 0);
      getIndex(currentImage);
    }
  }

  void getIndex(String _img) {
    currentIndexImage = listImg.indexWhere((element) => element == _img);
  }

  void checkButton() {
    if (currentIndexImage == 0) {
      _showPreSubject.sink.add(false);
      _showNextSubject.sink.add(true);
    } else if (currentIndexImage == listImg.length - 1) {
      _showNextSubject.sink.add(false);
      _showPreSubject.sink.add(true);
    } else {
      _showPreSubject.sink.add(true);
      _showNextSubject.sink.add(true);
    }
  }

  void showInformation() {
    showMore = !showMore;
    _showMoreSubject.sink.add(showMore);
  }
}
