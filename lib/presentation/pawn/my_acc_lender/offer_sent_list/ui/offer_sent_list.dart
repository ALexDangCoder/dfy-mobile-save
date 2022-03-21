import 'package:flutter/material.dart';

class OfferSentList extends StatefulWidget {
  const OfferSentList({Key? key}) : super(key: key);

  @override
  _OfferSentListState createState() => _OfferSentListState();
}

class _OfferSentListState extends State<OfferSentList>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int initIndexTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(initialIndex: initIndexTab, length: 2, vsync: this);
  }

  @override
  void dispose() {
    //writeHere
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Al,
      ),
    );
  }
}
