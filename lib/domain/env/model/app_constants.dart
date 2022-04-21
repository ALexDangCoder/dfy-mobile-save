import 'package:json_annotation/json_annotation.dart';

part 'app_constants.g.dart';

@JsonSerializable()
class AppConstants {
  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'base_url')
  String baseUrl;

  @JsonKey(name: 'base_url_pinata')
  String baseUrlPinata;

  @JsonKey(name: 'base_custom_url')
  String baseCustomUrl;

  @JsonKey(name: 'base_image_url')
  String baseImageUrl;

  @JsonKey(name: 'rpc_url')
  String rpcUrl;

  @JsonKey(name: 'chain_id')
  String chaninId;

  @JsonKey(name: 'bsc_scan')
  String bscScan;

  @JsonKey(name: 'nft_sales_address')
  String nftSalesAddress;

  @JsonKey(name: 'nft_factory')
  String nftFactory;

  @JsonKey(name: 'nft_auction')
  String nftAuction;

  @JsonKey(name: 'nft_pawn')
  String nftPawn;

  @JsonKey(name: 'hard_nft_factory')
  String hardNftFactory;

  @JsonKey(name: 'eva')
  String eva;

  @JsonKey(name: 'sell_abi')
  String sell_abi;

  @JsonKey(name: 'auction_abi')
  String auction_abi;

  @JsonKey(name: 'default_collection_abi')
  String default_collection_abi;

  @JsonKey(name: 'erc721_abi')
  String erc721_abi;

  @JsonKey(name: 'contract_defy')
  String contract_defy;
  @JsonKey(name: 'base_pawn_url')
  String basePawnUrl;

  @JsonKey(name: 'crypto_pawn_contract')
  String crypto_pawn_contract;

  @JsonKey(name: 'pawn_custom_url')
  String pawn_custom_url;

  @JsonKey(name: 'collateral_contract')
  String collateral_contract;

  @JsonKey(name: 'review_contract')
  String review_contract;

  @JsonKey(name: 'web_socket')
  String web_socket;

  AppConstants(
    this.type,
    this.baseUrl,
    this.baseUrlPinata,
    this.baseCustomUrl,
    this.baseImageUrl,
    this.rpcUrl,
    this.chaninId,
    this.bscScan,
    this.nftSalesAddress,
    this.nftFactory,
    this.nftAuction,
    this.nftPawn,
    this.hardNftFactory,
    this.eva,
    this.sell_abi,
    this.auction_abi,
    this.default_collection_abi,
    this.erc721_abi,
    this.contract_defy,
    this.basePawnUrl,
    this.crypto_pawn_contract,
    this.pawn_custom_url,
    this.collateral_contract,
    this.review_contract,
    this.web_socket,
  );

  factory AppConstants.fromJson(Map<String, dynamic> json) =>
      _$AppConstantsFromJson(json);
}
