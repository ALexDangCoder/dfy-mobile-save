import 'package:Dfy/data/request/collection/create_collection_ipfs_request.dart';
import 'package:Dfy/data/request/nft/create_soft_nft_ipfs_request.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/model/pinana_model.dart';

mixin PinataRepository {
  Future<Result<PinataModel>> createSoftNftPinJsonToIpfs(
    CreateSoftNftIpfsRequest request,
  );

  Future<Result<PinataModel>> createCollectionPinJsonToIpfs(
    CreateCollectionIpfsRequest request,
  );
}
