import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/model/collection_nft_info.dart';

mixin CollectionRepository {
  Future<Result<CollectionNftInfo>> getCollection();
}
