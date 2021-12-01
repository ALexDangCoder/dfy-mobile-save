import 'package:equatable/equatable.dart';

abstract class AlertState extends Equatable {

}
class AlertInitial extends AlertState {
  @override
  List<Object?> get props => [];

}
class EraseSuccess extends AlertState {
  final String type;

  EraseSuccess(this.type);
  @override
  List<Object?> get props => [];
}
class EraseFail extends AlertState {
  @override
  List<Object?> get props => [];
}
