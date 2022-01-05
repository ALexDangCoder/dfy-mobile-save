import 'package:Dfy/domain/model/market_place/nft_collection_explore_model.dart';

class ListTypeNftCollectionExploreModel {

  String? id;
  String? name;
  int? type;
  int? position;
  String? url;
  List<NftCollectionExploreModel>? items;

  ListTypeNftCollectionExploreModel({
    this.id,
    this.name,
    this.type,
    this.position,
    this.url,
    this.items,
  });
}
