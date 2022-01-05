import 'package:Dfy/domain/model/search_marketplace/search_collection_nft_model.dart';

class ListSearchCollectionFtNftModel {
  String? name;
  String? type;
  int? position;
  List<SearchCollectionNftModel>? items;

  ListSearchCollectionFtNftModel({this.name, this.type, this.items, this.position});
}