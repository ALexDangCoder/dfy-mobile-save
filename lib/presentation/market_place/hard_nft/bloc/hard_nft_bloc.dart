import 'package:rxdart/rxdart.dart';

class HardNFTBloc {
  List<String> listImg = [
    'https://i1-vnexpress.vnecdn.net/2021/07/07/Aventador-Ultimae-Coupe-1-3961-1625659942.jpg?w=0&h=0&q=100&dpr=2&fit=crop&s=ea17Gz8qHY-aIVS-Ev73xg',
    'https://i1-vnexpress.vnecdn.net/2021/07/07/Aventador-Ultimae-3-4-Rear-988-8401-6806-1625659942.jpg?w=0&h=0&q=100&dpr=1&fit=crop&s=IOBRMVVPbJ2V3bAikJK3Vg',
    'https://i1-vnexpress.vnecdn.net/2021/07/07/Aventador-Ultimae-Front-5556-1-3532-3841-1625659942.jpg?w=0&h=0&q=100&dpr=1&fit=crop&s=BEL11PJgSu5diDe9c1QJig',
    'https://i1-vnexpress.vnecdn.net/2021/07/07/Aventador-Ultimae-Rear-1848-16-6335-6733-1625659942.jpg?w=0&h=0&q=100&dpr=1&fit=crop&s=tJHxvyrGwIW7kVTciDgThw',
  ];

  final BehaviorSubject<String> _imageSubject = BehaviorSubject();

  Stream<String> get imageStream => _imageSubject.stream;

  void changeImage(String img){
    _imageSubject.sink.add(img);
  }
}
