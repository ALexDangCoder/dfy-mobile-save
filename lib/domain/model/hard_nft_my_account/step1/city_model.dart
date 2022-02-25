import 'package:Dfy/utils/extensions/map_extension.dart';

class CityModel {
  int? id;
  String? name;
  int? countryID;
  int? latitude;
  int? longitude;

  CityModel(
      {this.id, this.name, this.countryID, this.latitude, this.longitude});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'countryID': countryID,
      };

  CityModel.fromJson(Map<String, dynamic> json)
      : name = json.stringValueOrEmpty('name'),
        id = json.intValue('id'),
        countryID = json.intValue('countryID');
}
