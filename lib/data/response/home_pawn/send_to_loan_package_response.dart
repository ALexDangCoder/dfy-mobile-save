import 'package:Dfy/domain/model/home_pawn/send_to_loan_package_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'send_to_loan_package_response.g.dart';

@JsonSerializable()
class SendToLoanPackageResponse extends Equatable {
  @JsonKey(name: 'data')
  List<DataResponse>? data;

  SendToLoanPackageResponse(this.data);

  factory SendToLoanPackageResponse.fromJson(Map<String, dynamic> json) =>
      _$SendToLoanPackageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SendToLoanPackageResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class DataResponse extends Equatable {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'createdAt')
  int? createdAt;

  DataResponse(
    this.id,
    this.name,
    this.type,
    this.status,
    this.createdAt,
  );

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  SendToLoanPackageModel toDomain() => SendToLoanPackageModel(
        id: id,
        status: status,
        createdAt: createdAt,
        name: name,
        type: type,
      );
}
