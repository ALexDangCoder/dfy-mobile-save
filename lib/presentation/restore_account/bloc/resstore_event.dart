import 'package:equatable/equatable.dart';

class NewPassEvent extends Equatable{
  @override
  List<Object?> get props => [];
}
class ShowNewPass extends NewPassEvent{}
class HideNewPass extends NewPassEvent{}