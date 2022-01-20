import 'package:Dfy/domain/model/market_place/wallet_address_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wallet_address_response.g.dart';

@JsonSerializable()
class ListWalletAddressResponse extends Equatable {
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'role')
  String? role;
  @JsonKey(name: 'traceId')
  String? traceId;
  @JsonKey(name: 'data')
  List<WalletAddressResponse>? data;

  ListWalletAddressResponse(this.code, this.role, this.traceId, this.data);

  factory ListWalletAddressResponse.fromJson(Map<String, dynamic> json) =>
      _$ListWalletAddressResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListWalletAddressResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class WalletAddressResponse extends Equatable {
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

  WalletAddressResponse(
      this.userId,
      this.email,
      this.walletAddress,
      this.reputationBorrower,
      this.reputationLender,
      this.isActive,
      this.createAt);

  factory WalletAddressResponse.fromJson(Map<String, dynamic> json) =>
      _$WalletAddressResponseFromJson(json);

  WalletAddressModel toDomain() => WalletAddressModel(
        createAt: createAt,
        walletAddress: walletAddress,
        email: email,
        isActive: isActive,
        reputationBorrower: reputationBorrower,
        reputationLender: reputationLender,
        userId: userId,
      );

  @override
  List<Object?> get props => [];
}
