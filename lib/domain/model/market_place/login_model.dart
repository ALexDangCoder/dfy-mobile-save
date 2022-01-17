import 'dart:convert';

LoginModel loginFromJson(String str) => LoginModel.fromLogin(json.decode(str));

String loginToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? accessToken;
  int? expiresIn;
  String? refreshToken;
  String? scope;
  String? tokenType;

  LoginModel({
    this.accessToken,
    this.expiresIn,
    this.refreshToken,
    this.scope,
    this.tokenType,
  });

  LoginModel.init();

  Map<String, dynamic> toJson() => <String, dynamic>{
        'accessToken': accessToken,
        'expiresIn': expiresIn,
        'refreshToken': refreshToken,
        'scope': scope,
        'tokenType': tokenType,
      };

  LoginModel.fromLogin(dynamic json)
      : accessToken = json['accessToken'].toString(),
        expiresIn = json['expiresIn'],
        refreshToken = json['refreshToken'].toString(),
        scope = json['scope'].toString(),
        tokenType = json['tokenType'].toString();
}
