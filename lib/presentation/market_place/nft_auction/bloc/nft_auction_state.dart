import 'package:equatable/equatable.dart';

abstract class AuctionState extends Equatable {
  @override
  List<Object> get props => [];
}
class AuctionInitial extends AuctionState{}