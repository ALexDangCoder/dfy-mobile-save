part of 'evaluation_cubit.dart';

@immutable
abstract class EvaluationState extends Equatable{}

class EvaluationInitial extends EvaluationState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class DetailEvaluationResult extends EvaluationState {

  final Evaluation evaluation;
  DetailEvaluationResult(this.evaluation);
  @override
  // TODO: implement props
  List<Object?> get props => [evaluation];
}
