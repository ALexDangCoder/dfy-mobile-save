import 'package:Dfy/data/request/collection/create_collection_ipfs_request.dart';
import 'package:Dfy/data/request/collection/create_hard_collection_request.dart';
import 'package:Dfy/data/request/create_hard_nft/create_hard_nft_ipfs_request.dart';
import 'package:Dfy/data/request/nft/create_soft_nft_ipfs_request.dart';
import 'package:Dfy/data/response/pinata/pinata_response.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'pinata_service.g.dart';

@RestApi()
abstract class PinataClient {
  @factoryMethod
  factory PinataClient(Dio dio, {String baseUrl}) = _PinataClient;

  @POST(ApiConstants.PIN_JSON_TO_IPFS)
  Future<PinataResponse> createSoftNftPinJsonToIpfs(
    @Body() CreateSoftNftIpfsRequest request,
  );

  @POST(ApiConstants.PIN_JSON_TO_IPFS)
  Future<PinataResponse> createCollectionPinJsonToIpfs(
    @Body() CreateCollectionIpfsRequest request,
  );

  @POST(ApiConstants.PIN_JSON_TO_IPFS)
  Future<PinataResponse> createHardNFTPinFileToIPFS(
    @Body() CreateHardNftIpfsRequest request,
  );
}
