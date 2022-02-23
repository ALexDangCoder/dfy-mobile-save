part of 'hard_nft_mint_request_cubit.dart';

@immutable
abstract class HardNftMintRequestState extends Equatable {}

class HardNftMintRequestInitial extends HardNftMintRequestState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ListMintRequestSuccess extends HardNftMintRequestState {

  final List<MintRequestModel> list;

  ListMintRequestSuccess(this.list);

  @override
  List<Object?> get props => [list];

}

class ListMintRequestLoadMoreSuccess extends HardNftMintRequestState {

  final List<MintRequestModel> list;

  ListMintRequestLoadMoreSuccess(this.list);

  @override
  List<Object?> get props => [list];

}

class ListMintRequestRefreshSuccess extends HardNftMintRequestState {

  final List<MintRequestModel> list;

  ListMintRequestRefreshSuccess(this.list);

  @override
  List<Object?> get props => [list];
}
