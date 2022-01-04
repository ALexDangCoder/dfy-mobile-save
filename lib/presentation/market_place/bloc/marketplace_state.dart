part of 'marketplace_cubit.dart';

@immutable
abstract class MarketplaceState extends Equatable{}

class MarketplaceInitial extends MarketplaceState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class OnSearch extends MarketplaceState {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class OffSearch extends MarketplaceState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadingDataLoading extends MarketplaceState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class LoadingDataSuccess extends MarketplaceState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

class LoadingDataFail extends MarketplaceState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
