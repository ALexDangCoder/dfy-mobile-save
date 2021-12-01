import 'package:Dfy/domain/model/hard_nft/evaluation_model.dart';
import 'package:Dfy/domain/model/hard_nft/hard_nft_model.dart';
import 'package:rxdart/rxdart.dart';

class HardNFTBloc {
  HardNFTModel mockNFTModel = HardNFTModel(
    image: 'https://phelieuminhhuy.com/wp-content/uploads/2015/07/7f3ce033-'
        'b9b2-4259-ba7c-f6e5bae431a9-1435911423691.jpg',
    name: 'Lamborghini Aventador Pink Ver 2021',
    amount: 1,
    isAuction: true,
    endTime: DateTime.now(),
    des: 'Kidzone ride on is the perfect gift for your child for any'
        'occasion. Adjustable seat belt to ensure security during '
        'driving. Rechargeable battery with 40-50 mins playtime.'
        'Charing time: 8-10 hours,'
        'Product Dimension (Inch): 42.52" x 24.41" x 15.75',
    collection: 'Defi For You',
    owner: '0xaaa042c0632f4d44c7cea978f22cd02e751a410e',
    contract: '0xaaa042c0632f4d44c7cea978f22cd02e751a410e',
    nftTokenID: '0xaaa042c0632f4d44c7cea978f22cd02e751a410e',
    nftStandard: '0xaaa042c0632f4d44c7cea978f22cd02e751a410e',
    blocChain: 'Binance BlocChain',
    evaluation: EvaluationModel(
      by: 'The London Evaluation',
      time: DateTime.now(),
      maxAmount: 1200000,
      depreciation: 20,
      conclusion: 'Fast & furious',
      images: [
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
      ],
    ),
  );

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
    currentImage = mockNFTModel.evaluation.images[currentIndexImage];
    _imageSubject.sink.add(currentImage);
    getIndex(currentImage);
  }

  void nextImage() {
    if (currentIndexImage < mockNFTModel.evaluation.images.length - 1) {
      currentImage = mockNFTModel.evaluation.images[currentIndexImage + 1];
      _imageSubject.sink.add(currentImage);
      _showPreSubject.sink.add(true);
      _showNextSubject.sink.add(currentIndexImage != mockNFTModel.evaluation.images.length - 2);
      getIndex(currentImage);
    }
  }

  void preImage() {
    if (currentIndexImage > 0) {
      currentImage = mockNFTModel.evaluation.images[currentIndexImage - 1];
      _imageSubject.sink.add(currentImage);
      _showNextSubject.sink.add(true);
      _showPreSubject.sink.add((currentIndexImage - 1) != 0);
      getIndex(currentImage);
    }
  }

  void getIndex(String _img) {
    currentIndexImage = mockNFTModel.evaluation.images.indexWhere((element) => element == _img);
  }

  void checkButton() {
    if (currentIndexImage == 0) {
      _showPreSubject.sink.add(false);
      _showNextSubject.sink.add(true);
    } else if (currentIndexImage == mockNFTModel.evaluation.images.length - 1) {
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

  void changeTab(int _index) {
    _changeTabSubject.sink.add(_index);
  }
}
