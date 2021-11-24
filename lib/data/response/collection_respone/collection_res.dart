import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'collection_res.g.dart';

@JsonSerializable()
class JokeResponse extends Equatable{
  @JsonKey(name: 'text')
  final String text;

  const JokeResponse(this.text);

  factory JokeResponse.fromJson(Map<String,dynamic> json) =>
      _$JokeResponseFromJson(json);


  @override
  List<Object?> get props => [text];
}
