import 'package:Dfy/data/request/collection/create_hard_collection_ipfs_request.dart';
import 'package:Dfy/data/request/collection/create_soft_collection_ipfs_request.dart';
import 'package:Dfy/data/request/nft/create_soft_nft_ipfs_request.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/model/pinana_model.dart';

mixin PinataRepository {
  Future<Result<PinataModel>> createSoftNftPinJsonToIpfs(
    CreateSoftNftIpfsRequest request,
  );

  Future<Result<PinataModel>> createSoftCollectionPinJsonToIpfs(
    CreateSoftCollectionIpfsRequest request,
  );

  Future<Result<PinataModel>> createHardCollectionPinJsonToIpfs(
      CreateHardCollectionIpfsRequest request,
      );
}
