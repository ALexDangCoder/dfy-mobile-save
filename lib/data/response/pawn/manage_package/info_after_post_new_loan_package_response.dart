import 'package:Dfy/domain/model/pawn/manage_loan_package/infor_after_post_new_loan_package.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'info_after_post_new_loan_package_response.g.dart';

@JsonSerializable()
class InfoAfterPostNewLoanPackageResponse extends Equatable {
  @JsonKey(name: 'error')
  String? resultAfterPost;

  InfoAfterPostNewLoanPackageResponse(this.resultAfterPost);

  factory InfoAfterPostNewLoanPackageResponse.fromJson(
          Map<String, dynamic> json) =>
      _$InfoAfterPostNewLoanPackageResponseFromJson(json);

  InfoAfterPostNewLoanPackage toModel() => InfoAfterPostNewLoanPackage(
        resultPost: resultAfterPost,
      );

  Map<String, dynamic> toJson() =>
      _$InfoAfterPostNewLoanPackageResponseToJson(this);

  @override
  List<Object?> get props => [];
}
