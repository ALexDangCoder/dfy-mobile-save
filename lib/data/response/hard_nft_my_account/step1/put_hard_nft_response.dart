import 'package:Dfy/domain/model/hard_nft_my_account/step1/put_hard_nft_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'put_hard_nft_response.g.dart';

@JsonSerializable()
class PutHardNftResponse extends Equatable {
  @JsonKey(name: 'rd')
  String? rd;

  @JsonKey(name: 'rc')
  int? rc;

  @JsonKey(name: 'trace-id')
  String? traceId;

  @JsonKey(name: 'item')
  PutHardNftItemResponse? item;

  PutHardNftResponse(this.rd, this.rc, this.traceId, this.item);

  factory PutHardNftResponse.fromJson(Map<String, dynamic> json) =>
      _$PutHardNftResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PutHardNftResponseToJson(this);

  PutHardNftModel? toModel() => item?.toModel();

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class PutHardNftItemResponse extends Equatable {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'status')
  int? status;

  PutHardNftItemResponse(this.id, this.status);

  factory PutHardNftItemResponse.fromJson(Map<String, dynamic> json) =>
      _$PutHardNftItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PutHardNftItemResponseToJson(this);

  PutHardNftModel toModel() => PutHardNftModel(
        id,
        status,
      );

  @override
  List<Object?> get props => [];
}
