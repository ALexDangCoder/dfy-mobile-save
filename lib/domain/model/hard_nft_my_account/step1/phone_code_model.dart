import 'package:Dfy/utils/extensions/map_extension.dart';

class PhoneCodeModel {
  int? id;
  String? name;
  String? code;

  PhoneCodeModel({this.id, this.name, this.code});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'code': code,
      };

  PhoneCodeModel.fromJson(Map<String, dynamic> json)
      : name = json.stringValueOrEmpty('name'),
        id = json.intValue('id'),
        code = json.stringValueOrEmpty('code');
}
