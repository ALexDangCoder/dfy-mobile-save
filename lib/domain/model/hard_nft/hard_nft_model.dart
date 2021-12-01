import 'package:Dfy/domain/model/hard_nft/evaluation_model.dart';

class HardNFTModel {
  String image = '';
  String name = '';
  int amount = 0;
  bool isAuction = false;
  int loan = 0;
  int reservePrice = 0;
  int duration = 0;
  DateTime endTime = DateTime.now();
  String des = '';
  String collection = '';
  String owner = '';
  String contract = '';
  String nftTokenID = '';
  String nftStandard = '';
  String blocChain = '';
  EvaluationModel evaluation = EvaluationModel.init();

  HardNFTModel({
    required this.image,
    required this.name,
    required this.amount,
    required this.isAuction,
    this.loan = 0,
    this.reservePrice = 0,
    this.duration = 0,
    required this.endTime,
    required this.des,
    required this.collection,
    required this.owner,
    required this.contract,
    required this.nftTokenID,
    required this.nftStandard,
    required this.blocChain,
    required this.evaluation,
  });

  HardNFTModel.init();
}
