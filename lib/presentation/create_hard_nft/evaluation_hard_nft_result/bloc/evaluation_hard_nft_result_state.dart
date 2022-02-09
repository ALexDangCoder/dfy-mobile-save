part of 'evaluation_hard_nft_result_cubit.dart';

@immutable
abstract class EvaluationHardNftResultState extends Equatable{}

class EvaluationHardNftResultInitial extends EvaluationHardNftResultState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NoEvaluationResult extends EvaluationHardNftResultState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EvaluationResultSuccess extends EvaluationHardNftResultState {
  final List<EvaluationResult> list;
  EvaluationResultSuccess(this.list);
  @override
  // TODO: implement props
  List<Object?> get props => [list];
}
class DetailEvaluationResult extends EvaluationHardNftResultState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

