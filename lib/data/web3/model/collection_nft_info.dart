class CollectionNft {
  String? name;
  String? symbol;
  String? contract;
  List<ListNft>? listNft;

  CollectionNft({this.name, this.symbol, this.contract, this.listNft});

  CollectionNft.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    symbol = json['symbol'];
    contract = json['contract'];
    if (json['listNft'] != null) {
      List<ListNft> listNft = [];
      json['listNft'].forEach((v) {
        listNft.add(ListNft.fromJson(v));
      });
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
  int? id;
  String? contract;
  String? uri;

  ListNft({this.id, this.contract, this.uri});

  ListNft.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contract = json['contract'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['contract'] = contract;
    data['uri'] = uri;
    return data;
  }
}
