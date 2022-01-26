import 'package:json_annotation/json_annotation.dart';

part 'put_on_pawn_request.g.dart';

@JsonSerializable()
class PutOnPawnRequest {

  final int durationType;
  final int nftStandard;
  final int numberOfCopies;
  final int totalOfCopies;
  final String beNftId;
  final String collectionAddress;
  final String collectionName;
  final String durationQuantity;
  final String loanAmount;
  final String loanSymbol;
  final String networkName;
  final String nftMediaCid;
  final String nftMediaType;
  final String nftName;
  final String nftType;
  final String txnHash;
  final String userId;
  final bool collectionIsWhitelist;

  PutOnPawnRequest({
    required this.nftType,
    required this.durationType,
    required this.numberOfCopies,
    required this.collectionAddress,
    required this.txnHash,
    required this.beNftId,
    required this.collectionIsWhitelist,
    required this.collectionName,
    required this.durationQuantity,
    required this.loanAmount,
    required this.loanSymbol,
    required this.networkName,
    required this.nftMediaCid,
    required this.nftMediaType,
    required this.nftName,
    required this.nftStandard,
    required this.totalOfCopies,
    required this.userId,
  });

  factory PutOnPawnRequest.fromJson(Map<String, dynamic> json) =>
      _$PutOnPawnRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PutOnPawnRequestToJson(this);
}