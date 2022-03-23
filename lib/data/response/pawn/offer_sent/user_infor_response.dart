import 'package:Dfy/domain/model/pawn/offer_sent/user_infor_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_infor_response.g.dart';

@JsonSerializable()
class UserInfoResponse extends Equatable {
  @JsonKey(name: 'userId')
  int? userId;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'walletAddress')
  String? walletAddress;
  @JsonKey(name: 'reputationBorrower')
  int? reputationBorrower;
  @JsonKey(name: 'reputationLender')
  int? reputationLender;
  @JsonKey(name: 'isActive')
  bool? isActive;
  @JsonKey(name: 'createAt')
  int? createAt;


  UserInfoResponse(
      this.userId,
      this.email,
      this.walletAddress,
      this.reputationBorrower,
      this.reputationLender,
      this.isActive,
      this.createAt);

  UserInfoModel toModel() => UserInfoModel(userId);

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$UserInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoResponseToJson(this);

  @override
  List<Object?> get props => [];
}
