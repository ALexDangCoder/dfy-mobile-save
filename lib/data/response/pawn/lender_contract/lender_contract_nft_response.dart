import 'package:Dfy/data/response/home_pawn/borrow_list_my_acc_response.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lender_contract_nft_response.g.dart';


@JsonSerializable()

class LenderContractNftReponse extends Equatable {
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'data')
  ContentResponse? data;

  LenderContractNftReponse(this.code, this.data);

  factory LenderContractNftReponse.fromJson(Map<String, dynamic> json) =>
      _$LenderContractNftReponseFromJson(json);

  Map<String, dynamic> toJson() => _$LenderContractNftReponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}