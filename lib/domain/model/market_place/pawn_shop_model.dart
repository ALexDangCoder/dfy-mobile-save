import 'package:Dfy/data/response/create_hard_nft/list_appointment_response.dart';

class AppointmentModel {
  EvaluatorResponse? evaluator;
  int? status;
  String? id;
  int? appointmentTime;
  int? acceptedTime;
  int? bcAppointmentId;
  String? rejectedReason;

  AppointmentModel({
    this.evaluator,
    this.status,
    this.id,
    this.appointmentTime,
    this.acceptedTime,
    this.bcAppointmentId,
    this.rejectedReason,
  });
}

class Evaluator {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  PhoneCodeResponse? phoneCode;
  String? avatarCid;

  Evaluator({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.phoneCode,
    this.avatarCid,
  });
}

class PhoneCode {
  int? id;
  String? name;
  String? code;

  PhoneCode({
    this.id,
    this.name,
    this.code,
  });
}
