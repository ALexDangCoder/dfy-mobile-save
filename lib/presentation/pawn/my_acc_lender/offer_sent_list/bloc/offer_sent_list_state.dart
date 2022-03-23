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
