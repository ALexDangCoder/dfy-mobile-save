import 'package:Dfy/domain/model/pawn/reputation_borrower.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_reputation_borrower_response.g.dart';

@JsonSerializable()
class ReputationBorrowerResponse {
  @JsonKey(name: 'userId')
  int? userId;
  @JsonKey(name: 'walletAddress')
  String? walletAddress;
  @JsonKey(name: 'reputationBorrower')
  int? reputationBorrower;
  @JsonKey(name: 'reputationLender')
  int? reputationLender;

  factory ReputationBorrowerResponse.fromJson(Map<String, dynamic> json) =>
      _$ReputationBorrowerResponseFromJson(json);

  ReputationBorrowerResponse(
    this.userId,
    this.walletAddress,
    this.reputationBorrower,
    this.reputationLender,
  );

  ReputationBorrower toDomain() => ReputationBorrower(
        walletAddress: walletAddress,
        userId: userId,
        reputationBorrower: reputationBorrower,
        reputationLender: reputationLender,
      );
}
