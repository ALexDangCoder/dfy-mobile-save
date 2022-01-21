part of 'create_nft_cubit.dart';

@immutable
abstract class CreateNftState extends BaseState {}

class CreateNftInitial extends CreateNftState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class TypeNFT extends CreateNftState {
  final List<TypeNFTModel> listSoftNft;

  TypeNFT({this.listSoftNft = const []});


  @override
  List<Object?> get props => [listSoftNft];
}

class MediaFile extends CreateNftState{
  final File? file;
  MediaFile({this.file});

  @override
  // TODO: implement props
  List<Object?> get props => [file];
}