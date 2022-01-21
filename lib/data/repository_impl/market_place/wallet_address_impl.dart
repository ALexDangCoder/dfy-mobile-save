import 'package:Dfy/data/response/wallet_address/wallet_address_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/market_place/wallet_address_client.dart';
import 'package:Dfy/domain/model/market_place/wallet_address_model.dart';
import 'package:Dfy/domain/repository/market_place/wallet_address_respository.dart';

class WalletAddressImpl implements WalletAddressRepository {
  final WalletAddressClient _client;

  WalletAddressImpl(this._client);

  @override
  Future<Result<List<WalletAddressModel>>> getListWalletAddress() {
    return runCatchingAsync<ListWalletAddressResponse,
        List<WalletAddressModel>>(
      () => _client.getListWalletAddress(),
      (response) => response.data?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}
