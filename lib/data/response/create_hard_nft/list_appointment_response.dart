import 'package:Dfy/domain/model/market_place/pawn_shop_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_appointment_response.g.dart';

@JsonSerializable()
class ListAppointmentResponse extends Equatable {
  @JsonKey(name: 'rd')
  String? rd;

  @JsonKey(name: 'rc')
  int? rc;

  @JsonKey(name: 'total')
  int? total;

  @JsonKey(name: 'trace-id')
  String? traceId;

  @JsonKey(name: 'rows')
  List<AppointmentsResponse>? rows;

  ListAppointmentResponse(
    this.rd,
    this.rc,
    this.total,
    this.rows,
    this.traceId,
  );

  factory ListAppointmentResponse.fromJson(Map<String, dynamic> json) =>
      _$ListAppointmentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListAppointmentResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class AppointmentsResponse extends Equatable {
  @JsonKey(name: 'evaluator')
  EvaluatorResponse? evaluator;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'appointment_time')
  int? appointmentTime;
  @JsonKey(name: 'bc_appointment_id')
  int? bcAppointmentId;
  @JsonKey(name: 'accepted_time')
  int? acceptedTime;
  @JsonKey(name: 'rejected_reason')
  String? rejectedReason;

  AppointmentsResponse(
    this.evaluator,
    this.status,
    this.id,
    this.appointmentTime,
    this.bcAppointmentId,
    this.acceptedTime,
    this.rejectedReason,
  );

  factory AppointmentsResponse.fromJson(Map<String, dynamic> json) =>
      _$AppointmentsResponseFromJson(json);

  AppointmentModel toDomain() => AppointmentModel(
        id: id,
        status: status,
        acceptedTime: acceptedTime,
        appointmentTime: appointmentTime,
        bcAppointmentId: bcAppointmentId,
        evaluator: evaluator?.toDomain(),
        rejectedReason: rejectedReason,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class EvaluatorResponse extends Equatable {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'phone_code')
  PhoneCodeResponse? phoneCode;
  @JsonKey(name: 'avatar_cid')
  String? avatarCid;

  EvaluatorResponse(
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.phoneCode,
    this.avatarCid,
  );

  factory EvaluatorResponse.fromJson(Map<String, dynamic> json) =>
      _$EvaluatorResponseFromJson(json);

  Evaluator toDomain() => Evaluator(
        email: email,
        address: address,
        name: name,
        avatarCid: avatarCid,
        id: id,
        phone: phone,
        phoneCode: phoneCode?.toDomain(),
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class PhoneCodeResponse extends Equatable {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'code')
  String? code;

  PhoneCodeResponse(
    this.id,
    this.name,
    this.code,
  );

  factory PhoneCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$PhoneCodeResponseFromJson(json);

  PhoneCode toDomain() => PhoneCode(
        id: id,
        name: name,
        code: code,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
