import 'package:Dfy/domain/model/pawn/offer_detail_my_acc.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';

abstract class OfferDetailMyAccState extends Equatable {}

class OfferDetailMyAccInitial extends OfferDetailMyAccState {
  @override
  List<Object?> get props => [];
}

class OfferDetailMyAccLoading extends OfferDetailMyAccState {
  @override
  List<Object?> get props => [];
}

class OfferDetailMyAccSuccess extends OfferDetailMyAccState {
  final int id = DateTime.now().millisecond;
  final CompleteType completeType;
  final OfferDetailMyAcc? obj;
  final String? message;

  OfferDetailMyAccSuccess(
    this.completeType, {
    this.obj,
    this.message,
  });

  @override
  List<Object?> get props => [id, completeType, obj, message];
}
