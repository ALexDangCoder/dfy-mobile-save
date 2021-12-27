import 'package:Dfy/presentation/receive_token/ui/receive_token.dart';

class DetailHistoryTransaction {
  final String? quantity;
  final String? status;
  final String? gasFee;
  final String? dateTime;
  final String? txhID;
  final String? from;
  final String? to;
  final String? nonce;
  final String? name;
  final String? walletAddress;
  final String? smartContract;
  final String? NFTId;
  final String? collectionId;
  final TokenType? type;

  DetailHistoryTransaction({
    this.quantity,
    this.status,
    this.gasFee,
    this.dateTime,
    this.txhID,
    this.from,
    this.to,
    this.nonce,
    this.name,
    this.walletAddress,
    this.smartContract,
    this.NFTId,
    this.collectionId,
    this.type,
  });
}
