import 'package:equatable/equatable.dart';

abstract class StringState extends Equatable{
  @override
  List<Object> get props => [];
}
class StringInitial extends StringState {
  final String key;

  StringInitial(this.key);

}
class StringSelect extends StringState {
  final String key;
  StringSelect(this.key);
}

class StringSelectSeed extends StringState {
  final String key;
  StringSelectSeed(this.key);
}
class StringSelectPrivate extends StringState {
  final String key;
  StringSelectPrivate(this.key);
}
class Show extends StringState{
  final bool show;
  Show({this.show= true});
}
class Hide extends StringState{
  final bool show;
  Hide({this.show = false});
}
