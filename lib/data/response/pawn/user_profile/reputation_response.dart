import 'package:Dfy/domain/model/pawn/reputation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reputation_response.g.dart';

@JsonSerializable()
class ReputationResponse {
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'userId')
  int? userId;
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

  ReputationResponse(
      this.email,
      this.userId,
      this.walletAddress,
      this.reputationBorrower,
      this.reputationLender,
      this.isActive,
      this.createAt);
  factory ReputationResponse.fromJson(Map<String, dynamic> json) =>
      _$ReputationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReputationResponseToJson(this);
  Reputation toDomain() => Reputation(
    userId: userId,
    email: email,
    walletAddress: walletAddress,
    reputationBorrower: reputationBorrower,
    reputationLender: reputationLender,
    isActive: isActive,
    createAt: createAt,
  );
}
