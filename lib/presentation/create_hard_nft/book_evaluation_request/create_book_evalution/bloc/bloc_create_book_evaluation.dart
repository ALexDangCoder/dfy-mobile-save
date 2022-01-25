import 'package:Dfy/domain/model/market_place/pawn_shop_detail_model.dart';
import 'package:Dfy/domain/model/market_place/type_nft.dart';
import 'package:rxdart/rxdart.dart';

class BlocCreateBookEvaluation {
  List<TypeNFTModel> listTypeNft = [
    TypeNFTModel(
      image:
          'https://cdn.tgdd.vn/Files/2021/12/14/1404293/f8822mwg111_1280x720-800-resize.jpg',
      type: 'LayBE',
    ),
    TypeNFTModel(
      image:
          'https://cdn.tgdd.vn/Files/2021/12/14/1404293/f8822mwg111_1280x720-800-resize.jpg',
      type: 'LayBE',
    ),
    TypeNFTModel(
      image:
          'https://cdn.tgdd.vn/Files/2021/12/14/1404293/f8822mwg111_1280x720-800-resize.jpg',
      type: 'Layddd  dBE',
    ),
    TypeNFTModel(
      image:
          'https://cdn.tgdd.vn/Files/2021/12/14/1404293/f8822mwg111_1280x720-800-resize.jpg',
      type: 'LayBE',
    ),
    TypeNFTModel(
      image:
          'https://cdn.tgdd.vn/Files/2021/12/14/1404293/f8822mwg111_1280x720-800-resize.jpg',
      type: 'BE',
    ),
  ];

  BehaviorSubject<String> dateStream=BehaviorSubject.seeded('');
  BehaviorSubject<String> timeStream=BehaviorSubject.seeded('');
  List<String> listTimeWork = [
    'MON',
    'TUE',
    'WED',
    'THU',
  ];
  BehaviorSubject<PawnShopDetailModel> pawnShopDetail = BehaviorSubject.seeded(
    PawnShopDetailModel(
      urlAvatar:
          'https://cdn.tgdd.vn/Files/2021/12/14/1404293/f8822mwg111_1280x720-800-resize.jpg',
      urlCover:
          'https://cdn.tgdd.vn/Files/2021/12/14/1404293/f8822mwg111_1280x720-800-resize.jpg',
      title: 'Tima - Online Pawnshop',
      rate: 5.0,
      date: 'Joined in June, 2021',
      address: '0xaaa042c00000000000e751a410e',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Turpis dui aliquam, amet, massa purus ',
      email: 'doanahkull511@a.com',
      linkWeb: 'asdfasdfsdafsadfsdaf',
      location: 'sfdasdfasdfdsaf',
      numberPhone: '3412342314231',
      workingTime: '12341234231423143',
    ),
  );
}
