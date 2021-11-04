import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/images.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<WalletScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: () => Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            width: 375.w,
            height: 812.h,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: listBackgroundColor,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 44.h,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.w,
                    right: 10.w,
                  ),
                  child: SizedBox(
                    height: 54.h,
                    width: 323.sw,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.menu,
                            size: 24.sp,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10.h,
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Wallet',
                                style: textNormalCustom(
                                  Colors.white,
                                  20.sp,
                                  FontWeight.w700,
                                ),
                              ),
                              Text(
                                'Smart chain',
                                style: textNormalCustom(
                                  Colors.grey.shade400,
                                  14.sp,
                                  FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.settings_outlined,
                            size: 24.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 14.h,
                ),
                Divider(
                  height: 1.h,
                  color: const Color(0xFF4b4a60),
                ),
                SizedBox(
                  height: 24.h,
                ),
                header(),
                SizedBox(
                  height: 24.h,
                ),
                SizedBox(
                  height: 44.h,
                  width: 230.w,
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.white,
                    unselectedLabelColor: const Color(0xFF9997FF),
                    indicatorColor: const Color(0xFF6F6FC5),
                    labelStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    tabs: const [
                      Tab(
                        text: 'TOKEN',
                      ),
                      Tab(
                        text: 'NFT',
                      ),
                    ],
                    indicatorSize: TabBarIndicatorSize.tab,
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Container(
                        color: Colors.white,
                        child: SingleChildScrollView(
                        ),
                      ),
                      Container(
                        color: Colors.red,
                        child: SingleChildScrollView(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 136.w,
          ),
          child: SizedBox(
            height: 125.h,
            width: 135.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 25.w,
                  ),
                  child: CircleAvatar(
                    radius: 27.sp,
                    child: const Image(
                      image: AssetImage('$baseImg/symbol.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Account 1',
                      style: textNormalCustom(
                        Colors.white,
                        24.sp,
                        FontWeight.w700,
                      ),
                    ),
                    Icon(
                      Icons.edit_outlined,
                      size: 24.sp,
                      color: Colors.white,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 21.w,
                  ),
                  child: Text(
                    '\$ 3,8000',
                    style: textNormalCustom(
                      const Color(0xFFE4AC1A),
                      20.sp,
                      FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 129.w,
          ),
          child: Row(
            children: [
              Container(
                height: 36.h,
                width: 116.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF585769),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    '0xD582...6C99',
                    style: textNormalCustom(
                      Colors.white,
                      16.sp,
                      FontWeight.w400,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const ImageIcon(
                  AssetImage('$baseImg/Code.png'),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
