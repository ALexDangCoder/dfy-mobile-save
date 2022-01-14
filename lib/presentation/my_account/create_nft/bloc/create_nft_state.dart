part of 'create_nft_cubit.dart';

@immutable
abstract class CreateNftState extends BaseState {}

class CreateNftInitial extends CreateNftState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class TypeNFT extends CreateNftState {
  TypeNFT({this.listSoftNft = const []});

  final List<TypeNFTModel> listSoftNft;

  @override
  List<Object?> get props => [listSoftNft];
}
