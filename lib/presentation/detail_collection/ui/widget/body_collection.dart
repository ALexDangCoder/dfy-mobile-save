import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:flutter/material.dart';
import 'content.dart';
import 'nav.dart';

class BodyDetailCollection extends StatefulWidget {
  final String owner;
  final String contract;
  final String nftStandard;
  final String category;
  final String title;
  final String bodyText;
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
  }) : super(key: key);

  @override
  _BodyDetailCollectionState createState() => _BodyDetailCollectionState();
}

class _BodyDetailCollectionState extends State<BodyDetailCollection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ContentDetailCollection(
          contract: widget.contract,
          title: widget.title,
          bodyText: widget.bodyText,
          category: widget.category,
          nftStandard: widget.nftStandard,
          owner: widget.owner,
          detailCollectionBloc: widget.detailCollectionBloc,
        ),
        line,
        const NavCollection(
          items: '1025',
          owners: '326',
          volumeTraded: '\$1,396,175',
        ),
        line,
      ],
    );
  }
}
