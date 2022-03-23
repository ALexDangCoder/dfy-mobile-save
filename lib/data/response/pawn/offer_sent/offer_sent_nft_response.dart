// import 'package:Dfy/data/response/pawn/borrow/nft_on_request_loan_response.dart';
// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// part 'offer_sent_nft_response.g.dart';
//
// @JsonSerializable()
// class OfferSentNftTotalResponse extends Equatable {
//   @JsonKey(name: 'error')
//   String? error;
//
//   @JsonKey(name: 'code')
//   int? code;
//
//   @JsonKey(name: 'message')
//   dynamic message;
//
//   @JsonKey(name: 'data')
//   OfferSentNftListResponse? data;
//
//   @JsonKey(name: 'trace_id')
//   String? traceId;
//
//
//   factory OfferSentNftTotalResponse.fromJson(Map<String, dynamic> json) =>
//       _$OfferSentNftTotalResponseFromJson(json);
//
//   Map<String, dynamic> toJson() => _$OfferSentNftTotalResponseToJson(this);
//
//   @override
//   List<Object?> get props => [];
// }
//
// @JsonSerializable()
// class OfferSentNftListResponse extends Equatable {
//   @JsonKey(name: 'content')
//   List<NftOnRequestLoanContentResponse>? content;
//
//   factory OfferSentNftListResponse.fromJson(Map<String, dynamic> json) =>
//       _$OfferSentNftListResponseFromJson(json);
//
//   Map<String, dynamic> toJson() => _$OfferSentNftListResponseToJson(this);
//
//   @override
//   List<Object?> get props => [];
// }
//
