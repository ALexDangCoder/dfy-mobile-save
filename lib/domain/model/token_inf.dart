import 'dart:convert';

class TokenInf {
  int? id;
  bool? whitelistCollateral;
  bool? whitelistSupply;
  bool? whiteListAsset;
  double? usdExchange;
  String? symbol;
  String? address;
  String? name;
  String? iconUrl;

  TokenInf({
    this.symbol,
    this.name,
    this.whiteListAsset,
    this.id,
    this.whitelistCollateral,
    this.whitelistSupply,
    this.usdExchange,
    this.address,
    this.iconUrl,
  });

  factory TokenInf.fromJson(Map<String, dynamic> json) {
    return TokenInf(
      address: json['address'],
      symbol: json['symbol'],
      iconUrl: json['iconUrl'],
      usdExchange: json['usdExchange'],
      whiteListAsset: json['whitelistAsset']
    );
  }

  static Map<String, dynamic> toMap(TokenInf tokenInf) => {
        'address': tokenInf.address,
        'symbol': tokenInf.symbol,
        'iconUrl': tokenInf.iconUrl,
        'usdExchange': tokenInf.usdExchange,
        'whitelistAsset': tokenInf.whiteListAsset,
      };

  static String encode(List<TokenInf> listTokens) => json.encode(
        listTokens
            .map<Map<String, dynamic>>((token) => TokenInf.toMap(token))
            .toList(),
      );

  static List<TokenInf> decode(String listTokens) =>
      (json.decode(listTokens) as List<dynamic>)
          .map<TokenInf>((item) => TokenInf.fromJson(item))
          .toList();
}
