import 'package:equatable/equatable.dart';

abstract class CategoryState extends Equatable {

}

class CategoryStateInitState extends CategoryState {
  @override
  List<Object?> get props => [];
}
class LoadingCategoryState extends CategoryState {
  @override
  List<Object?> get props => [];
}
class ErrorCategoryState extends CategoryState {
  @override
  List<Object?> get props => [];
}
class LoadedCategoryState extends CategoryState {
  @override
  List<Object?> get props => [];
}
class LoadListCollectionFailState extends CategoryState {
  @override
  List<Object?> get props => [];
}
class LoadingListCollectionState extends CategoryState {
  @override
  List<Object?> get props => [];
}
class LoadListCollectionSuccessState extends CategoryState {
  @override
  List<Object?> get props => [];
}