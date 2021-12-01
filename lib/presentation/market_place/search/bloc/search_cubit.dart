import 'dart:async';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/domain/model/collection.dart';
import 'package:Dfy/domain/model/nft_item.dart';
import 'package:Dfy/presentation/market_place/ui/maket_place_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'search_state.dart';

class SearchCubit extends BaseCubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  final BehaviorSubject<bool> _isVisible = BehaviorSubject<bool>();
  Stream<bool> get isVisible => _isVisible.stream;

  void show(){
    _isVisible.sink.add(true);
  }
  void hide(){
    _isVisible.sink.add(false);
  }

  void search(String value)  {
    emit(SearchLoading());
    Timer(const Duration(milliseconds: 1500), () {
      emit(SearchSuccess());
    });
  }
  final BehaviorSubject<int> _lengthStream = BehaviorSubject<int>.seeded(3);
  Stream<int> get lengthStream => _lengthStream.stream;

  void showAllResult(int items) {
    _lengthStream.sink.add(items);
  }

  void dispose() {
    _lengthStream.close();
  }

  List<Collection> collections = [
    Collection(
      background: 'http://placeimg.com/640/480',
      avatar: 'https://cdn.fakercloud.com/avatars/aaronalfred_128.jpg',
      title: 'Trinidad',
      items: 1000,
    ),
    Collection(
      background: 'http://placeimg.com/640/480',
      avatar: 'https://cdn.fakercloud.com/avatars/aaronalfred_128.jpg',
      title: 'Kyat',
      items: 1000,
    ),
    Collection(
      background: 'http://placeimg.com/640/480',
      avatar: 'https://cdn.fakercloud.com/avatars/aaronalfred_128.jpg',
      title: 'Zambian Kwacha',
      items: 1000,
    ),
    Collection(
      background: 'http://placeimg.com/640/480',
      avatar: 'https://cdn.fakercloud.com/avatars/bobwassermann_128.jpg',
      title: 'Pataca',
      items: 1000,
    ),
    Collection(
      background: 'http://placeimg.com/640/480',
      avatar: 'https://cdn.fakercloud.com/avatars/picard102_128.jpg',
      title: 'Trinidad',
      items: 1000,
    ),
    Collection(
      background: 'http://placeimg.com/640/480',
      avatar: 'https://cdn.fakercloud.com/avatars/supervova_128.jpg',
      title: 'Trinidad',
      items: 1000,
    ),
  ];
  List<NftItem> listNFT = [
    NftItem(
      name: 'Lamborghi',
      image: 'http://placeimg.com/640/480',
      price: 10000,
      propertiesNFT: TypePropertiesNFT.AUCTION,
    ),
    NftItem(
      name: 'Lamborghin',
      image: 'http://placeimg.com/640/480',
      price: 10000,
      propertiesNFT: TypePropertiesNFT.PAWN,
    ),
    NftItem(
      name: ' Pink 21',
      image: 'http://placeimg.com/640/480',
      price: 10000,
      propertiesNFT: TypePropertiesNFT.SALE,
    ),
  ];


}
