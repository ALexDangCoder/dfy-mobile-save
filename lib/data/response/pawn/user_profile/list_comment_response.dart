import 'package:Dfy/domain/model/pawn/borrow_available_collateral.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_comment_response.g.dart';
@JsonSerializable()
class ListCommentUser extends Equatable {
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'data')
  ContentResponse? data;

  ListCommentUser(this.code, this.data);

  factory ListCommentUser.fromJson(Map<String, dynamic> json) =>
      _$ListCommentUserFromJson(json);

  Map<String, dynamic> toJson() => _$ListCommentUserToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class ContentResponse extends Equatable {
  @JsonKey(name: 'items')
  List<DataResponse>? data;

  ContentResponse(this.data);

  factory ContentResponse.fromJson(Map<String, dynamic> json) =>
      _$ContentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContentResponseToJson(this);

  List<CommentBorrow>? toDomain() => data?.map((e) => e.toDomain()).toList();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
@JsonSerializable()
class DataResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'content')
  String? content;
  @JsonKey(name: 'point')
  int? point;
  @JsonKey(name: 'createdAt')
  int? createAt;
  @JsonKey(name: 'reviewer')
  UserReviewResponse? userReview;


  DataResponse(
      this.id, this.content, this.point, this.createAt, this.userReview);

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);
  CommentBorrow toDomain() => CommentBorrow(
    id: id,
    createAt: createAt,
    content: content,
    point: point,
    userReview: userReview?.toDomain(),
  );

}

@JsonSerializable()
class UserReviewResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'walletAddress')
  String? walletAddress;
  @JsonKey(name: 'isKYC')
  bool? isKYC;


  UserReviewResponse(
      this.id, this.name, this.email, this.walletAddress, this.isKYC);

  factory UserReviewResponse.fromJson(Map<String, dynamic> json) =>
      _$UserReviewResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserReviewResponseToJson(this);

  UserReview toDomain() => UserReview(
    id: id,
    name: name,
    email: email,
    walletAddress: walletAddress,
    isKYC: isKYC,
  );
}
