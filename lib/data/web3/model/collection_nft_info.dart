import 'nft_info_model.dart';

class CollectionNft {
  String? name;
  String? symbol;
  String? contract;
  List<ListNft>? listNft;

  CollectionNft({this.name, this.symbol, this.contract, this.listNft});

  CollectionNft.fromJsonMap(Map<String, dynamic> json) {
    name = json['name'];
    symbol = json['symbol'];
    contract = json['contract'];
    if (json['listNft'] != null) {
      List<ListNft> listNft = [];
      json['listNft'].forEach((v) {
        listNft.add(ListNft.fromJsonMap(v));
      });
    }
  }

  CollectionNft.fromJson(dynamic json) {
    name = json['nftName'];
    symbol = json['symbol'];
    contract = json['collectionAddress'];
    final List<dynamic> items = json['listNft'];
    listNft = [];
    if (items != null) {
      for (var item in items) {
        listNft?.add(ListNft.fromJson(item));
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['symbol'] = symbol;
    data['contract'] = contract;
    data['listNft'] = listNft?.map((v) => v.toJson()).toList();
    return data;
  }
}

class ListNft {
  String? id;
  String? contract;
  String? uri;

  ListNft({this.id, this.contract, this.uri});

  ListNft.fromJsonMap(Map<String, dynamic> json) {
    id = json['id'];
    contract = json['contract'];
    uri = json['uri'];
  }

  ListNft.fromJson(dynamic json) {
    id = json['id'];
    contract = json['contract'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['contract'] = contract;
    data['uri'] = uri;
    return data;
  }
}

class CollectionShow {
  String? name;
  String? symbol;
  String? contract;
  List<NftInfo>? listNft;

  CollectionShow({this.name, this.symbol, this.contract, this.listNft});
}
