// import 'package:Dfy/data/response/collection_respone/collection_list.dart';
// import 'package:Dfy/data/result/result.dart';
// import 'package:Dfy/data/services/collection_service.dart';
// import 'package:Dfy/data/web3/model/collection_nft_info.dart';
// import 'package:Dfy/domain/repository/collection_list_repository.dart';
//
// class CollectionRepositoryImp implements CollectionRepository {
//   final CollectionClient _collectionClient;
//
//   CollectionRepositoryImp(
//     this._collectionClient,
//   );
//
//   @override
//   Future<Result<CollectionNftInfo>> getCollection() {
//     return runCatchingAsync<CollectionResponse, CollectionNftInfo>(
//       () => _collectionClient.getCollectionNft(),
//       (response) => response.toDomain(),
//     );
//   }
// }
