import 'package:Dfy/domain/model/home_pawn/crypto_pawn_model.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';

abstract class BorrowListMyAccState extends Equatable {}

class BorrowListMyAccInitial extends BorrowListMyAccState {
  @override
  List<Object?> get props => [];
}

class BorrowListMyAccLoading extends BorrowListMyAccState {
  @override
  List<Object?> get props => [];
}

class BorrowListMyAccSuccess extends BorrowListMyAccState {
  final int id = DateTime.now().millisecond;
  final CompleteType completeType;
  final List<CryptoPawnModel>? list;
  final String? message;

  BorrowListMyAccSuccess(
    this.completeType, {
    this.list,
    this.message,
  });

  @override
  List<Object?> get props => [id, completeType, list, message];
}

class BorrowListMyAccNFTLoading extends BorrowListMyAccState {
  @override
  List<Object?> get props => [];
}

class BorrowListMyAccNFTSuccess extends BorrowListMyAccState {
  final int id = DateTime.now().millisecond;
  final CompleteType completeType;
  final List<CryptoPawnModel>? listNFT;
  final String? message;

  BorrowListMyAccNFTSuccess(
    this.completeType, {
    this.listNFT,
    this.message,
  });

  @override
  List<Object?> get props => [id, completeType, listNFT, message];
}
