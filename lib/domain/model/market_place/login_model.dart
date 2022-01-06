class LoginModel{
  String?  accessToken;
  int? expiresIn;
  String? refreshToken;
  String? scope;
  String? tokenType;

  LoginModel({this.accessToken, this.expiresIn, this.refreshToken, this.scope,
    this.tokenType});
}