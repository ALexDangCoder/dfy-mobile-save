import 'dart:developer';

import 'package:rxdart/rxdart.dart';

class HardNFTBloc {
  List<String> listImg = [
    'https://i1-vnexpress.vnecdn.net/2021/07/07/Aventador-Ultimae-Coupe-1-3961-1625659942.jpg?w=0&h=0&q=100&dpr=2&fit=crop&s=ea17Gz8qHY-aIVS-Ev73xg',
    'https://i1-vnexpress.vnecdn.net/2021/07/07/Aventador-Ultimae-3-4-Rear-988-8401-6806-1625659942.jpg?w=0&h=0&q=100&dpr=1&fit=crop&s=IOBRMVVPbJ2V3bAikJK3Vg',
    'https://i1-vnexpress.vnecdn.net/2021/07/07/Aventador-Ultimae-Front-5556-1-3532-3841-1625659942.jpg?w=0&h=0&q=100&dpr=1&fit=crop&s=BEL11PJgSu5diDe9c1QJig',
    'https://i1-vnexpress.vnecdn.net/2021/07/07/Aventador-Ultimae-Rear-1848-16-6335-6733-1625659942.jpg?w=0&h=0&q=100&dpr=1&fit=crop&s=tJHxvyrGwIW7kVTciDgThw',
    'https://img.tinbanxe.vn/images/Lamborghini/Lamborghini%20Aventador%20SVJ/mau-sac/lamborghini-aventador-mau-cam-dam-tinbanxe.jpg',
    'https://img.tinbanxe.vn/images/Lamborghini/Lamborghini%20Aventador%20SVJ/mau-sac/lamborghini-aventador-mau-den-tinbanxe.jpg',
    'https://img.tinbanxe.vn/images/Lamborghini/Lamborghini%20Aventador%20SVJ/mau-sac/lamborghini-aventador-mau-trang-tinbanxe.jpg',
    'https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510_960_720.jpg',
    'https://media.istockphoto.com/photos/flora-of-gran-canaria-flowering-marguerite-daisy-picture-id1072462590',
    'https://news.cgtn.com/news/2020-09-20/Spider-flower-The-flower-with-a-distinctive-display-TVYLozFKg0/img/9c42156e261a4d2282370c03fce43a0a/9c42156e261a4d2282370c03fce43a0a.jpeg',
    'https://news.cgtn.com/news/2020-09-20/Spider-flower-The-flower-with-a-distinctive-display-TVYLozFKg0/img/eab3d2c3f58c4ba8b7fc8a7ca2957edf/eab3d2c3f58c4ba8b7fc8a7ca2957edf.jpeg',
    'https://news.cgtn.com/news/2020-09-20/Spider-flower-The-flower-with-a-distinctive-display-TVYLozFKg0/img/13cdba1b208b4e1cae15bd4f7f1fdc59/13cdba1b208b4e1cae15bd4f7f1fdc59.jpeg',
    'https://news.cgtn.com/news/2020-09-20/Spider-flower-The-flower-with-a-distinctive-display-TVYLozFKg0/img/da3aaec388854a5eadbfe73f86dfdca2/da3aaec388854a5eadbfe73f86dfdca2.jpeg'
  ];

  ///clear fake Data
  int currentIndexImage = 0;
  String currentImage = '';
  bool showMore = false;

  final BehaviorSubject<String> _imageSubject = BehaviorSubject();

  final BehaviorSubject<bool> _showPreSubject = BehaviorSubject();

  final BehaviorSubject<bool> _showNextSubject = BehaviorSubject();

  final BehaviorSubject<bool> _showMoreSubject = BehaviorSubject();



  Stream<String> get imageStream => _imageSubject.stream;

  Stream<bool> get showPreStream => _showPreSubject.stream;

  Stream<bool> get showNextStream => _showNextSubject.stream;

  Stream<bool> get showMoreStream => _showMoreSubject.stream;




  void changeImage(String _img){
    if(currentImage!=''){
      getIndex(_img);
    }
    checkButton();
    currentImage = listImg[currentIndexImage];
    _imageSubject.sink.add(currentImage);
    getIndex(currentImage);
  }

  void nextImage(){
    if (currentIndexImage < listImg.length-1){
      currentImage = listImg[currentIndexImage+1];
      _imageSubject.sink.add(currentImage);
      _showPreSubject.sink.add(true);
      _showNextSubject.sink.add(currentIndexImage != listImg.length-2);
      getIndex(currentImage);
    }
  }
  void preImage(){
    if (currentIndexImage > 0){
      currentImage = listImg[currentIndexImage-1];
      _imageSubject.sink.add(currentImage);
      _showNextSubject.sink.add(true);
      _showPreSubject.sink.add((currentIndexImage-1) != 0);
      getIndex(currentImage);
    }
  }
  void getIndex(String _img){
    currentIndexImage = listImg.indexWhere((element) => element == _img);
  }

  void checkButton(){
    if (currentIndexImage == 0){
      _showPreSubject.sink.add(false);
      _showNextSubject.sink.add(true);

    } else if (currentIndexImage == listImg.length-1){
      _showNextSubject.sink.add(false);
      _showPreSubject.sink.add(true);

    } else {
      _showPreSubject.sink.add(true);
      _showNextSubject.sink.add(true);
    }
  }

  void showInformation(){
    showMore = !showMore;
    _showMoreSubject.sink.add(showMore);
  }
}
