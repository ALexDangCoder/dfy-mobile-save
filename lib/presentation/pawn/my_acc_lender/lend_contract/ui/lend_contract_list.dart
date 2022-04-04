import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/lend_contract/bloc/lender_contract_cubit.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/lend_contract/ui/components/filter_lender_contract.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/lend_contract/ui/components/tab_crypto/lender_contract_crypto.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/lend_contract/ui/components/tab_nft/lender_contract_nft.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LenderContractList extends StatefulWidget {
  const LenderContractList({Key? key}) : super(key: key);

  @override
  _LenderContractListState createState() => _LenderContractListState();
}

class _LenderContractListState extends State<LenderContractList>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int initIndexTab = 0;
  late LenderContractCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = LenderContractCubit();
    _tabController =
        TabController(initialIndex: initIndexTab, length: 2, vsync: this);
    _tabController.index;
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
            margin: EdgeInsets.only(
              top: 26.h,
            ),
            decoration: BoxDecoration(
              color: AppTheme.getInstance().bgBtsColor(),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.h),
                topRight: Radius.circular(30.h),
              ),
            ),
            child: Column(
              children: [
                _header(),
                Divider(
                  color: AppTheme.getInstance().divideColor(),
                ),
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
                          onTap: (index) {
                            //todo
                          },
                          tabs: [
                            Tab(
                              child: Text(
                                S.current.crypto.capitalize(),
                                style: textNormalCustom(
                                  AppTheme.getInstance().whiteColor(),
                                  14,
                                  FontWeight.w600,
                                ),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'NFT',
                                style: textNormalCustom(
                                  AppTheme.getInstance().whiteColor(),
                                  14,
                                  FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      spaceH24,
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            ///Tab crypto
                            LenderContractCrypto(
                              cubit: cubit,
                            ),

                            ///Tab Nft
                            LenderContractNft(
                              cubit: cubit,
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

  Widget _header() {
    return SizedBox(
      height: 64.h,
      child: SizedBox(
        height: 28.h,
        width: 343.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: InkWell(
                onTap: () {},
                child: SizedBox(
                  height: 30.h,
                  width: 30.w,
                  child: Image.asset(ImageAssets.ic_menu),
                ),
              ),
            ),
            Flexible(
              flex: 6,
              child: Align(
                child: Text(
                  S.current.lender_contract_list,
                  textAlign: TextAlign.center,
                  style: titleText(
                    color: AppTheme.getInstance().textThemeColor(),
                  ),
                ),
              ),
            ),
            Flexible(
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (ctx) => FilterLenderContract(
                      cubit: cubit,
                      indexTab: _tabController.index,
                    ),
                  );
                },
                child: Image.asset(ImageAssets.ic_filter),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
