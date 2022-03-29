import 'package:Dfy/domain/model/pawn/user_profile.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'setting_user_response.g.dart';

@JsonSerializable()
class SettingUserResponse extends Equatable {
  @JsonKey(name: 'code')
  int? code;

  @JsonKey(name: 'data')
  DataResponse? data;

  SettingUserResponse(this.code,this.data);

  factory SettingUserResponse.fromJson(Map<String, dynamic> json) =>
      _$SettingUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SettingUserResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class DataResponse {
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'activitiesEmail')
  bool? activitiesEmail;
  @JsonKey(name: 'notificationEmail')
  bool? notificationEmail;
  @JsonKey(name: 'otherUserEmail')
  bool? otherUserEmail;
  @JsonKey(name: 'hotNewNoti')
  bool? hotNewNoti;
  @JsonKey(name: 'activitiesNoti')
  bool? activitiesNoti;
  @JsonKey(name: 'newSystemNoti')
  bool? newSystemNoti;
  @JsonKey(name: 'warningNoti')
  bool? warningNoti;

  DataResponse(
      this.email,
      this.activitiesEmail,
      this.notificationEmail,
      this.otherUserEmail,
      this.hotNewNoti,
      this.activitiesNoti,
      this.newSystemNoti,
      this.warningNoti);

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  EmailSetting toEmailSetting() => EmailSetting(
    email: email,
    activitiesEmail: activitiesEmail,
    notificationEmail: notificationEmail,
    otherUserEmail: otherUserEmail,
  );

  NotiSetting toNotiSetting() => NotiSetting(
    email: email,
    hotNewNoti: hotNewNoti,
    activitiesNoti: activitiesNoti,
    newSystemNoti: newSystemNoti,
    warningNoti: warningNoti,
  );

}
