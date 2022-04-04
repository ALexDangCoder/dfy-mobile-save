import 'package:json_annotation/json_annotation.dart';

part 'review_create_request.g.dart';

@JsonSerializable()
class ReviewCreateRequest {
  String? content;
  int? contractId;
  int? createdAt;
  int? id;
  int? point;
  int? type;
  String? wallet;
  ReviewerRequest? reviewer;
  ReviewerRequest? reviewee;

  ReviewCreateRequest({
    this.content,
    this.contractId,
    this.createdAt,
    this.id,
    this.point,
    this.type,
    this.wallet,
    this.reviewer,
    this.reviewee,
  });

  factory ReviewCreateRequest.fromJson(Map<String, dynamic> json) =>
      _$ReviewCreateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewCreateRequestToJson(this);
}

@JsonSerializable()
class ReviewerRequest {
  String? email;
  int? id;
  bool? isKYC;
  String? name;
  String? walletAddress;

  ReviewerRequest({
    this.email,
    this.id,
    this.isKYC,
    this.name,
    this.walletAddress,
  });

  factory ReviewerRequest.fromJson(Map<String, dynamic> json) =>
      _$ReviewerRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewerRequestToJson(this);
}
