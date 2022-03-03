import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/collateral_result/bloc/collateral_result_bloc.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'item_become_bank.dart';
import 'item_collateral.dart';

class CollateralResultScreen extends StatefulWidget {
  const CollateralResultScreen({Key? key}) : super(key: key);

  @override
  _CollateralResultScreenState createState() => _CollateralResultScreenState();
}

class _CollateralResultScreenState extends State<CollateralResultScreen> {
  late CollateralResultBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = CollateralResultBloc();
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
            height: 764.h,
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
                    Text(
                      S.current.collateral_result,
                      style: textNormalCustom(
                        null,
                        20.sp,
                        FontWeight.w700,
                      ).copyWith(
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                    GestureDetector(
                      onTap: () {},
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
                StreamBuilder<int>(
                  stream: _bloc.numberListLength,
                  builder: (context, snapshot) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 16.w,
                      ),
                      child: Text(
                        '${snapshot.data} '
                        '${S.current.collateral_offers_match_your_search}',
                        style: textNormalCustom(
                          AppTheme.getInstance().pawnGray(),
                          16,
                          null,
                        ),
                      ),
                    );
                  },
                ),
                spaceH24,
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ItemCollateral(
                          loadToken: 'DFY',
                          duration: '12 months',
                          address: '12341234123434',
                          rate: '1000',
                          iconLoadToken: ImageAssets.ic_dfy,
                          iconBorrower: ImageAssets.ic_dfy,
                          contracts: '100',
                          iconCollateral: ImageAssets.ic_dfy,
                          collateral: '10 ETH',
                        ),
                        ItemCollateral(
                          loadToken: 'DFY',
                          duration: '12 months',
                          address: '12341234123434',
                          rate: '1000',
                          iconLoadToken: ImageAssets.ic_dfy,
                          iconBorrower: ImageAssets.ic_dfy,
                          contracts: '100',
                          iconCollateral: ImageAssets.ic_dfy,
                          collateral: '10 ETH',
                        ),
                        const ItemBecomeBank(),
                        spaceH20,
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (context, index) => ItemCollateral(
                            loadToken: 'DFY',
                            duration: '12 months',
                            address: '12341234123434',
                            rate: '1000',
                            iconLoadToken: ImageAssets.ic_dfy,
                            iconBorrower: ImageAssets.ic_dfy,
                            contracts: '100',
                            iconCollateral: ImageAssets.ic_dfy,
                            collateral: '10 ETH',
                          ),
                        ),
                      ],
                    ),
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
