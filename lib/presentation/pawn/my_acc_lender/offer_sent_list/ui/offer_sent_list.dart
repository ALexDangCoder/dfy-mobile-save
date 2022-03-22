import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            height: 812.h,
            margin: EdgeInsets.only(top: 26.h,),
            decoration: BoxDecoration(
              color: AppTheme.getInstance().bgBtsColor(),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.h),
                topRight: Radius.circular(30.h),
              ),
            ),
            child: Column(

            ),
          ),
        ),
      ),
    );
  }
}
