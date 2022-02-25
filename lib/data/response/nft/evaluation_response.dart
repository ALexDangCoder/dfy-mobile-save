import 'package:Dfy/domain/model/evaluation_hard_nft.dart';
import 'package:Dfy/presentation/market_place/hard_nft/ui/tab_content/related_document_widget.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'evaluation_response.g.dart';

@JsonSerializable()
class EvaluationResponse extends Equatable {
  @JsonKey(name: 'rc')
  int? rc;
  @JsonKey(name: 'rd')
  String? rd;
  @JsonKey(name: 'item')
  EvaluationDetailResponse? item;

  EvaluationResponse(this.rc, this.rd, this.item);

  factory EvaluationResponse.fromJson(Map<String, dynamic> json) =>
      _$EvaluationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EvaluationResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class EvaluationDetailResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'evaluator')
  EvaluatorResponse? evaluator;
  @JsonKey(name: 'evaluated_time')
  int? evaluatedTime;
  @JsonKey(name: 'asset_type')
  AssetTypeResponse? assetType;
  @JsonKey(name: 'authenticity_type')
  int? authenticityType;
  @JsonKey(name: 'additional_info_list')
  List<AdditionalInfoResponse>? properties;
  @JsonKey(name: 'depreciation_percent')
  int? depreciationPercent;
  @JsonKey(name: 'evaluated_price')
  double? evaluatedPrice;
  @JsonKey(name: 'evaluated_price_symbol')
  String? evaluatedPriceSymbol;
  @JsonKey(name: 'media_list')
  List<MediaResponse>? media;
  @JsonKey(name: 'document_list')
  List<DocumentResponse>? document;
  @JsonKey(name: 'asset')
  AssetResponse? assetResponse;
  @JsonKey(name: 'additional_information')
  String? additionalInformation;
  @JsonKey(name: 'bc_txn_hash')
  String? bcTxnHash;

  EvaluationDetailResponse(
    this.evaluatedPriceSymbol,
    this.id,
    this.evaluator,
    this.evaluatedTime,
    this.assetType,
    this.authenticityType,
    this.properties,
    this.depreciationPercent,
    this.evaluatedPrice,
    this.media,
    this.document,
    this.additionalInformation,
    this.bcTxnHash,
    this.assetResponse,
  );

  factory EvaluationDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$EvaluationDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EvaluationDetailResponseToJson(this);

  Evaluation toDomain() => Evaluation(
        id: id,
        evaluator: evaluator?.toDomain(),
        evaluatedTime: evaluatedTime,
        assetType: assetType?.toDomain(),
        authenticityType: authenticityType,
        properties: properties?.map((e) => e.toDomain()).toList(),
        depreciationPercent: depreciationPercent,
        evaluatedPrice: evaluatedPrice,
        evaluatedSymbol: evaluatedPriceSymbol,
        media: media?.map((e) => e.toDomain()).toList(),
        document: document?.map((e) => e.toDomain()).toList(),
        additionalInformation: additionalInformation,
        bcTxnHash: bcTxnHash,
        nameNft: assetResponse?.toDomain(),
      );
}

@JsonSerializable()
class EvaluatorResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'avatar_image')
  String? avatarImage;

  EvaluatorResponse(this.id, this.name, this.avatarImage);

  String getPath(String avatarCid) {
    return ApiConstants.BASE_URL_IMAGE + avatarCid;
  }

  factory EvaluatorResponse.fromJson(Map<String, dynamic> json) =>
      _$EvaluatorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EvaluatorResponseToJson(this);

  Evaluator toDomain() =>
      Evaluator(id: id, name: name, avatarImage: getPath(avatarImage ?? ''));
}

@JsonSerializable()
class AssetTypeResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;

  AssetTypeResponse(this.id, this.name);

  factory AssetTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$AssetTypeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AssetTypeResponseToJson(this);

  AssetType toDomain() => AssetType(id, name);
}

@JsonSerializable()
class AdditionalInfoResponse {
  @JsonKey(name: 'trait_type')
  String? traitType;
  @JsonKey(name: 'value')
  String? value;

  AdditionalInfoResponse(this.traitType, this.value);

  factory AdditionalInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$AdditionalInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdditionalInfoResponseToJson(this);

  AdditionalInfo toDomain() => AdditionalInfo(traitType, value);
}

@JsonSerializable()
class MediaResponse {
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'cid')
  String? urlImage;

  MediaResponse(this.name, this.type, this.urlImage);

  factory MediaResponse.fromJson(Map<String, dynamic> json) =>
      _$MediaResponseFromJson(json);

  String getPath(String avatarCid) {
    return ApiConstants.BASE_URL_IMAGE + avatarCid;
  }

  Map<String, dynamic> toJson() => _$MediaResponseToJson(this);

  TypeImage getTypeImage(String type) {
    if (type.toLowerCase().contains('image')) {
      return TypeImage.IMAGE;
    } else {
      return TypeImage.VIDEO;
    }
  }

  Media toDomain() =>
      Media(name, getTypeImage(type ?? 'video'), getPath(urlImage ?? ''));
}

@JsonSerializable()
class DocumentResponse {
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'cid')
  String? urlDocument;

  DocumentResponse(this.name, this.type, this.urlDocument);

  factory DocumentResponse.fromJson(Map<String, dynamic> json) =>
      _$DocumentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentResponseToJson(this);

  DocumentType getTypeDoc(String type) {
    if (type.toLowerCase().contains('pdf')) {
      return DocumentType.PDF;
    } else if (type.toLowerCase().contains('doc')) {
      return DocumentType.DOC;
    } else {
      return DocumentType.XLS;
    }
  }

  Document toDomain() => Document(
        name,
        getTypeDoc(type ?? ''),
        getPath(urlDocument ?? ''),
      );

  String getPath(String avatarCid) {
    return ApiConstants.BASE_URL_IMAGE + avatarCid;
  }
}

@JsonSerializable()
class AssetResponse {
  @JsonKey(name: 'name')
  String? name;

  AssetResponse(this.name);

  factory AssetResponse.fromJson(Map<String, dynamic> json) =>
      _$AssetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AssetResponseToJson(this);
  NameNft toDomain() => NameNft(name);
}
