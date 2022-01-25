import 'package:Dfy/domain/model/market_place/user_profile_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class ProfileResponse extends Equatable {
  @JsonKey(name: 'data')
  Map<String, dynamic>? data;

  ProfileResponse();

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);

  ProfileModel toDomain() => ProfileModel(data: data);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
