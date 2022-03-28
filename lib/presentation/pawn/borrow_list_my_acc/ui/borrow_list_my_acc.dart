import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/borrow_list_my_acc/bloc/borrow_list_my_acc_bloc.dart';
import 'package:Dfy/presentation/pawn/borrow_list_my_acc/ui/tab/borrow_tab.dart';
import 'package:Dfy/presentation/pawn/borrow_list_my_acc/ui/tab/crypto_tab.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'filter_borrow.dart';

class BorrowListMyAccScreen extends StatefulWidget {
  const BorrowListMyAccScreen({Key? key}) : super(key: key);

  @override
  _BorrowListMyAccScreenState createState() => _BorrowListMyAccScreenState();
}

class _BorrowListMyAccScreenState extends State<BorrowListMyAccScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int initIndexTab = 0;
  late BorrowListMyAccBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BorrowListMyAccBloc();
    _tabController =
        TabController(initialIndex: initIndexTab, length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        bloc.type = BorrowListMyAccBloc.CRYPTO_TYPE;
      } else {
        bloc.type = BorrowListMyAccBloc.NFT_TYPE;
      }
    });
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
            final FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Container(
            height: 812.h,
            decoration: BoxDecoration(
              color: AppTheme.getInstance().bgBtsColor(),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.h),
                topRight: Radius.circular(30.h),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spaceH16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 16.w,
                        ),
                        width: 28.w,
                        height: 28.h,
                        child: Image.asset(
                          ImageAssets.ic_back,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 270.w,
                      child: Text(
                        S.current.borrow_contract_list,
                        style: textNormalCustom(
                          null,
                          20.sp,
                          FontWeight.w700,
                        ).copyWith(
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) => FilterBorrowMyAcc(
                            bloc: bloc,
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 16.w),
                        width: 24.w,
                        height: 24.h,
                        child: Image.asset(ImageAssets.ic_filter),
                      ),
                    ),
                  ],
                ),
                spaceH20,
                line,
                spaceH12,
                Flexible(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: TabBar(
                          unselectedLabelColor: const Color(0xFF9997FF),
                          labelColor: Colors.white,
                          indicatorColor: const Color(0xFF6F6FC5),
                          controller: _tabController,
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelStyle: textNormalCustom(
                            Colors.red,
                            14,
                            FontWeight.w600,
                          ),
                          onTap: (index) {
                            //todo
                          },
                          tabs: [
                            Tab(
                              text: S.current.crypto,
                            ),
                            Tab(
                              text: S.current.nft,
                            ),
                          ],
                        ),
                      ),
                      spaceH24,
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            CryptoTab(
                              bloc: bloc,
                            ),
                            NFTTab(
                              bloc: bloc,
                            ),
                          ],
                        ),
                      )
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
}
