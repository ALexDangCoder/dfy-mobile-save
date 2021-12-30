import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:flutter/material.dart';
import 'content.dart';
import 'launchUrl.dart';
import 'nav.dart';

class BodyDetailCollection extends StatelessWidget {
  final String owner;
  final String contract;
  final String nftStandard;
  final String category;
  final String title;
  final String bodyText;
  final String items;
  final String owners;
  final String volumeTraded;
  final String urlFace;
  final String urlInstagram;
  final String urlTelegram;
  final String urlTwitter;
  final DetailCollectionBloc detailCollectionBloc;

  const BodyDetailCollection({
    Key? key,
    required this.owner,
    required this.contract,
    required this.nftStandard,
    required this.category,
    required this.title,
    required this.bodyText,
    required this.detailCollectionBloc,
    required this.items,
    required this.owners,
    required this.volumeTraded,
    required this.urlFace,
    required this.urlInstagram,
    required this.urlTelegram,
    required this.urlTwitter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ContentDetailCollection(
          contract: contract,
          title: title,
          bodyText: bodyText,
          category: category,
          nftStandard: nftStandard,
          owner: owner,
          detailCollectionBloc: detailCollectionBloc,
        ),
        LaunchUrl(
          urlFace: urlFace,
          urlInstagram: urlInstagram,
          urlTelegram: urlTelegram,
          urlTwitter: urlTwitter,
        ),
        NavCollection(
          items: items,
          owners: owners,
          volumeTraded: volumeTraded,
        ),
        line,
      ],
    );
  }
}
