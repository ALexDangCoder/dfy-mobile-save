import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/home_pawn/bloc/home_pawn_cubit.dart';
import 'package:Dfy/presentation/pawn/borrow_lend/bloc/borrow_lend_bloc.dart';
import 'package:Dfy/presentation/pawn/borrow_lend/ui/select_type.dart';
import 'package:Dfy/presentation/pawn/borrow_result/ui/borrow_result.dart';
import 'package:Dfy/presentation/pawn/collateral_result/ui/collateral_result.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'borrow_item.dart';

class BorrowLendScreen extends StatefulWidget {
  final TYPE_BORROW_OR_LEND type;

  const BorrowLendScreen({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  _BorrowLendScreenState createState() => _BorrowLendScreenState();
}

class _BorrowLendScreenState extends State<BorrowLendScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late BorrowLendBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BorrowLendBloc();
    _tabController = TabController(length: 2, vsync: this);
    _bloc.getTokenInf();
    if (widget.type == TYPE_BORROW_OR_LEND.LEND) {
      _tabController.index = 1;
    } else {
      _tabController.index = 0;
    }
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
      text: ImageAssets.ic_close,
      title: _tabController.index == 0 ? S.current.borrow : S.current.lend,
      onRightClick: () {},
      isImage: true,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              SizedBox(
                height: 44.h,
                width: 230.w,
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: const Color(0xFF9997FF),
                  indicatorColor: const Color(0xFF6F6FC5),
                  labelStyle: textNormalCustom(
                    Colors.grey.shade400,
                    14,
                    FontWeight.w600,
                  ),
                  tabs: [
                    Tab(
                      text: S.current.borrow,
                    ),
                    Tab(
                      text: S.current.lend,
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
                      margin: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 40.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.current.what_you_can_borrow,
                            style: textNormalCustom(
                              null,
                              20,
                              FontWeight.w700,
                            ),
                          ),
                          spaceH20,
                          Text(
                            S.current.what_is_your_collateral,
                            style: textNormalCustom(
                              null,
                              16,
                              FontWeight.w400,
                            ),
                          ),
                          spaceH16,
                          SelectType(
                            bloc: _bloc,
                          ),
                          StreamBuilder<TypeLend>(
                              stream: _bloc.typeScreen,
                              builder: (context, snapshot) {
                                return SizedBox(
                                  child: snapshot.data == TypeLend.CRYPTO
                                      ? BorrowItem(
                                          bloc: _bloc,
                                        )
                                      : const SizedBox.shrink(),
                                );
                              }),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 40.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.current.what_you_can_borrow,
                            style: textNormalCustom(
                              null,
                              20,
                              FontWeight.w700,
                            ),
                          ),
                          spaceH20,
                          Text(
                            S.current.what_is_your_collateral,
                            style: textNormalCustom(
                              null,
                              16,
                              FontWeight.w400,
                            ),
                          ),
                          spaceH16,
                          SelectType(
                            bloc: _bloc,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: 38.h,
            ),
            child: GestureDetector(
              onTap: () {
                if (_tabController.index == 0) {
                  if (_bloc.typeScreen.value == TypeLend.CRYPTO) {
                    if (_bloc.isAmount.value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BorrowResult(
                            nameToken: _bloc.tokenSymbol.value,
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BorrowResult(
                            nameToken: _bloc.tokenSymbol.value,
                            amount: _bloc.textAmount.value,
                          ),
                        ),
                      );
                    }
                  } else {
                    print('cho vay and nft');
                  }

                } else {
                  if (_bloc.typeScreen == TypeLend.CRYPTO) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CollateralResultScreen(),
                      ),
                    );
                  } else {
                    print('cho vay and nft');
                  }
                }
              },
              child: ButtonGold(
                title: S.current.view_result,
                isEnable: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
