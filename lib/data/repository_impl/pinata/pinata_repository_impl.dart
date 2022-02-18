import 'package:Dfy/data/request/collection/create_hard_collection_ipfs_request.dart';
import 'package:Dfy/data/request/collection/create_soft_collection_ipfs_request.dart';
import 'package:Dfy/data/request/nft/create_soft_nft_ipfs_request.dart';
import 'package:Dfy/data/response/pinata/pinata_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/pinata/pinata_service.dart';
import 'package:Dfy/data/web3/model/pinana_model.dart';
import 'package:Dfy/domain/repository/pinata/pinata_repository.dart';

class PinataRepositoryImpl implements PinataRepository {
  final PinataClient _client;

  PinataRepositoryImpl(
    this._client,
  );

  @override
  Future<Result<PinataModel>> createSoftNftPinJsonToIpfs(
    CreateSoftNftIpfsRequest request,
  ) {
    return runCatchingAsync<PinataResponse, PinataModel>(
      () => _client.createSoftNftPinJsonToIpfs(request),
      (response) => response.toModel(),
    );
  }

  @override
  Future<Result<PinataModel>> createSoftCollectionPinJsonToIpfs(
    CreateSoftCollectionIpfsRequest request,
  ) {
    return runCatchingAsync<PinataResponse, PinataModel>(
      () => _client.createSoftCollectionPinJsonToIpfs(request),
      (response) => response.toModel(),
    );
  }

  @override
  Future<Result<PinataModel>> createHardCollectionPinJsonToIpfs(
    CreateHardCollectionIpfsRequest request,
  ) {
    return runCatchingAsync<PinataResponse, PinataModel>(
          () => _client.createHardCollectionPinJsonToIpfs(request),
          (response) => response.toModel(),
    );
  }
}
