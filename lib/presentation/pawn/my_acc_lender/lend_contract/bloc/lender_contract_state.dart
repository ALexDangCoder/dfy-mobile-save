part of 'lender_contract_cubit.dart';

abstract class LenderContractState extends Equatable {
  const LenderContractState();
}

class LenderContractInitial extends LenderContractState {
  @override
  List<Object> get props => [];
}

class LoadMoreNFT extends LenderContractState {
  @override
  List<Object> get props => [];
}

class LoadCryptoFtNftFail extends LenderContractState {
  @override
  List<Object> get props => [];
}



class LoadCryptoFtNftResult extends LenderContractState {
  final List<CryptoPawnModel>? list;
  final CompleteType completeType;

  LoadCryptoFtNftResult(
    this.completeType, {
    this.list,
  });

  @override
  List<Object?> get props => [
        list,
        completeType,
      ];
}
