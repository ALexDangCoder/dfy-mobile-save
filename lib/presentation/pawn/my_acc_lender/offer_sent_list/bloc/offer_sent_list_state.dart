part of 'offer_sent_list_cubit.dart';

abstract class OfferSentListState extends Equatable {
  const OfferSentListState();
}

class OfferSentListInitial extends OfferSentListState {
  @override
  List<Object> get props => [];
}

class LoadCryptoResult extends OfferSentListState {
  final List<OfferSentCryptoModel>? list;
  final CompleteType completeType;
  final String? message;

  LoadCryptoResult(this.completeType, {this.list, this.message});

  @override
  List<Object?> get props => [list, completeType, message];
}

class LoadMoreCrypto extends OfferSentListState {
  @override
  List<Object> get props => [];
}

///detail crypto
class GetApiDetalOfferSentCrypto extends OfferSentListState {
  final OfferSentDetailCryptoModel? detailCrypto;
  final OfferSentDetailCryptoCollateralModel? detailCryptoCollateral;
  final CompleteType completeType;
  final String? message;

  GetApiDetalOfferSentCrypto(
    this.completeType, {
    this.detailCrypto,
    this.detailCryptoCollateral,
    this.message,
  });

  @override
  List<Object?> get props =>
      [detailCrypto, detailCryptoCollateral, message, completeType];
}
