import 'package:Dfy/data/web3/model/pinana_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pinata_response.g.dart';

@JsonSerializable()
class PinataResponse extends Equatable {
  @JsonKey(name: 'IpfsHash')
  String? ipfsHash;

  PinataResponse(
    this.ipfsHash,
  );

  factory PinataResponse.fromJson(Map<String, dynamic> json) =>
      _$PinataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PinataResponseToJson(this);

  @override
  List<Object?> get props => [];

  PinataModel toModel() => PinataModel(ipfsHash: ipfsHash ?? '');
}
