import 'dart:convert';

import 'package:Dfy/domain/model/pawn/notification.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_response.g.dart';

@JsonSerializable()
class NotificationResponse extends Equatable {
  @JsonKey(name: 'notificationType')
  List<NotificationTypeResponse> noti;

  @JsonKey(name: 'data')
  ContentResponse? data;

  NotificationResponse(this.noti, this.data);

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationResponseToJson(this);

  List<NotificationData> toDomain() => noti.map((e) => e.toDomain()).toList();

  List<NotificationDetail>? toNotificationDetail() => data?.toDomain();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class NotificationTypeResponse extends Equatable {
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'total')
  int? total;

  NotificationTypeResponse(this.type, this.total);

  factory NotificationTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationTypeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationTypeResponseToJson(this);

  NotificationData toDomain() => NotificationData(
        type: type,
        total: total,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class ContentResponse extends Equatable {
  @JsonKey(name: 'content')
  List<DataResponse>? data;

  ContentResponse(this.data);

  factory ContentResponse.fromJson(Map<String, dynamic> json) =>
      _$ContentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContentResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];

  List<NotificationDetail>? toDomain() =>
      data?.map((e) => e.toDomain()).toList();
}

@JsonSerializable()
class DataResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'noti_type')
  int? notiType;
  @JsonKey(name: 'user_type')
  int? user_type;
  @JsonKey(name: 'tx_type')
  int? tx_type;
  @JsonKey(name: 'meta_data')
  String? data;
  @JsonKey(name: 'is_readed')
  bool? is_readed;
  @JsonKey(name: 'is_delete')
  bool? is_delete;
  @JsonKey(name: 'create_at')
  int? create_at;
  @JsonKey(name: 'readed_at')
  int? readed_at;

  DataResponse(this.id, this.notiType, this.user_type, this.tx_type, this.data,
      this.is_readed, this.is_delete, this.create_at, this.readed_at);

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  NotificationDetail toDomain() => NotificationDetail(
        id: id,
        notiType: notiType,
        userType: user_type,
        txType: tx_type,
        metaData: data?.replaceAll('\'', ''),
        isRead: is_readed,
        isDelete: is_delete,
        createAt: create_at,
        readAt: readed_at,
        notiDTO: NotiDTO.fromJson(
          jsonDecode(data?.replaceAll('\'', '') ?? ''),
        ),
      );
}
