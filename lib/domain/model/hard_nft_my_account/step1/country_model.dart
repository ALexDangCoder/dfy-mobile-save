import 'package:Dfy/utils/extensions/map_extension.dart';

class CountryModel {
  String? id;
  String? name;

  CountryModel({this.id, this.name});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  CountryModel.fromJson(Map<String, dynamic> json)
      : name = json.stringValueOrEmpty('name'),
        id = json.stringValueOrEmpty('id');
}
