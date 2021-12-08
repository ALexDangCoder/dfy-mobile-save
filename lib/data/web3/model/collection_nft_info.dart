class CollectionNftInfo {
  String? collectionId;
  String? coverCid;
  String? description;
  String? fileCid;
  int? mintingFeeNumber;
  String? mintingFeeToken;
  String? fileType;
  String? name;
  List<Properties>? properties;
  String? royalties;

  CollectionNftInfo({
    this.collectionId,
    this.coverCid,
    this.description,
    this.fileCid,
    this.mintingFeeNumber,
    this.mintingFeeToken,
    this.fileType,
    this.name,
    this.properties,
    this.royalties,
  });



  CollectionNftInfo.fromJson(Map<String, dynamic> json) {
    collectionId = json['collection_id'];
    coverCid = json['cover_cid'];
    description = json['description'];
    fileCid = json['file_cid'];
    mintingFeeNumber = json['minting_fee_number'];
    mintingFeeToken = json['minting_fee_token'];
    fileType = json['file_type'];
    name = json['name'];
    if (json['properties'] != null) {

      properties as List<Properties>;
      json['properties'].forEach((v) {
        properties!.add(Properties.fromJson(v));
      });
    }
    royalties = json['royalties'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['collection_id'] = this.collectionId;
    data['cover_cid'] = this.coverCid;
    data['description'] = this.description;
    data['file_cid'] = this.fileCid;
    data['minting_fee_number'] = this.mintingFeeNumber;
    data['minting_fee_token'] = this.mintingFeeToken;
    data['file_type'] = this.fileType;
    data['name'] = this.name;
    if (this.properties != null) {
      data['properties'] = this.properties!.map((v) => v.toJson()).toList();
    }
    data['royalties'] = this.royalties;
    return data;
  }
}


class Properties {
  String? key;
  String? value;

  Properties({this.key, this.value});

  Properties.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['value'] = value;
    return data;
  }
}
