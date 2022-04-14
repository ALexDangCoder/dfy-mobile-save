
import 'package:Dfy/presentation/market_place/hard_nft/ui/tab_content/related_document_widget.dart';
import 'package:Dfy/utils/constants/app_constants.dart';

class Evaluation {
  String? id;
  NameNft? nameNft;
  Evaluator? evaluator;
  int? evaluatedTime;
  AssetType? assetType;
  int? authenticityType;
  List<AdditionalInfo>? properties;
  int? depreciationPercent;
  double? evaluatedPrice;
  String? evaluatedSymbol;
  List<Media>? media;
  List<Document>? document;
  String? additionalInformation;
  String? bcTxnHash;
  String? urlToken;
  String? storageLocation;

  Evaluation({
    this.id,
    this.evaluator,
    this.evaluatedTime,
    this.assetType,
    this.authenticityType,
    this.properties,
    this.depreciationPercent,
    this.evaluatedPrice,
    this.evaluatedSymbol,
    this.media,
    this.document,
    this.additionalInformation,
    this.bcTxnHash,
    this.urlToken,
    this.nameNft,
    this.storageLocation,
  });
}

class AdditionalInfo {
  String? traitType;
  String? value;

  AdditionalInfo(this.traitType,this.value);
}

class Evaluator {
  String? id;
  String? name;
  String? avatarImage;

  Evaluator({this.id, this.name, this.avatarImage});
}

class AssetType {
  int? id;
  String? name;

  AssetType(this.id, this.name);
}

class Media {
  String? name;
  TypeImage? type;
  String? urlImage;

  Media(this.name, this.type, this.urlImage);
}
class NameNft {
  String? name;
  NameNft(this.name);
}

class Document {
  String? name;
  DocumentType? type;
  String? urlDocument;

  Document(this.name, this.type, this.urlDocument);
}
