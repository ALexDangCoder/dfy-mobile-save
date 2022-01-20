import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/wallet_address_model.dart';

mixin WalletAddressRepository {
  Future<Result<List<WalletAddressModel>>> getListWalletAddress();
}
