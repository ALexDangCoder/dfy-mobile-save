// import 'package:Dfy/data/web3/model/collection_nft_info.dart';
// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// part 'collection_response.g.dart';
//
// @JsonSerializable()
// class CollectionResponse extends Equatable {
//   @JsonKey(name: 'collectionId')
//   String? collectionId;
//   @JsonKey(name: 'coverCid')
//   String? coverCid;
//   @JsonKey(name: 'description')
//   String? description;
//   @JsonKey(name: 'fileCid')
//   String? fileCid;
//   @JsonKey(name: 'mintingFeeNumber')
//   int? mintingFeeNumber;
//   @JsonKey(name: 'mintingFeeToken')
//   String? mintingFeeToken;
//   @JsonKey(name: 'fileType')
//   String? fileType;
//   @JsonKey(name: 'name')
//   String? name;
//   @JsonKey(name: 'royalties')
//   String? royalties;
//   @JsonKey(name: 'properties')
//   List<Properties>? properties;
//
//   CollectionResponse(
//     this.collectionId,
//     this.coverCid,
//     this.description,
//     this.fileCid,
//     this.mintingFeeNumber,
//     this.mintingFeeToken,
//     this.fileType,
//     this.name,
//     this.royalties,
//     this.properties,
//   );
//
//   factory CollectionResponse.fromJson(Map<String, dynamic> json) =>
//       _$CollectionResponseFromJson(json);
//
//   Map<String, dynamic> toJson() => _$CollectionResponseToJson(this);
//
//   @override
//   List<Object?> get props => [];
//
//   CollectionNftInfo toDomain() => CollectionNftInfo(
//         collectionId: collectionId,
//         coverCid: collectionId,
//         description: description,
//         fileCid: fileCid,
//         mintingFeeNumber: mintingFeeNumber,
//         mintingFeeToken: mintingFeeToken,
//         fileType: fileType,
//         name: name,
//         royalties: royalties,
//         properties: properties,
//       );
// }
