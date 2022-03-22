import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/collateral_detail_my_acc/bloc/collateral_detail_my_acc_bloc.dart';
import 'package:Dfy/presentation/pawn/collateral_detail_my_acc/ui/item_send_to.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'add_collateral.dart';
import 'item_offes_received.dart';
import 'item_wiget_collateral_myacc.dart';

class CollateralDetailMyAcc extends StatefulWidget {
  const CollateralDetailMyAcc({Key? key}) : super(key: key);

  @override
  _CollateralDetailMyAccState createState() => _CollateralDetailMyAccState();
}

class _CollateralDetailMyAccState extends State<CollateralDetailMyAcc> {
  late CollateralDetailMyAccBloc bloc;
  List<bool> openTab = [];

  @override
  void initState() {
    super.initState();
    bloc = CollateralDetailMyAccBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
      title: S.current.collateral_detail,
      child: Stack(
        children: [
          Container(
            height: 764.h,
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  spaceH20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          '${S.current.status}:',
                          style: textNormalCustom(
                            AppTheme.getInstance().pawnItemGray(),
                            16,
                            FontWeight.w400,
                          ),
                        ),
                      ),
                      spaceW4,
                      Expanded(
                        flex: 6,
                        child: Text(
                          'Activit', //todo
                          style: textNormalCustom(
                            null,
                            16,
                            FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  spaceH16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          '${S.current.collateral_id}:',
                          style: textNormalCustom(
                            AppTheme.getInstance().pawnItemGray(),
                            16,
                            FontWeight.w400,
                          ),
                        ),
                      ),
                      spaceW4,
                      Expanded(
                        flex: 6,
                        child: Text(
                          'Activit', //todo
                          style: textNormalCustom(
                            null,
                            16,
                            FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  spaceH16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          '${S.current.message}:',
                          style: textNormalCustom(
                            AppTheme.getInstance().pawnItemGray(),
                            16,
                            FontWeight.w400,
                          ),
                        ),
                      ),
                      spaceW4,
                      Expanded(
                        flex: 6,
                        child: Text(
                          'Activit', //todo
                          style: textNormalCustom(
                            null,
                            16,
                            FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  spaceH16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          '${S.current.collateral}:',
                          style: textNormalCustom(
                            AppTheme.getInstance().pawnItemGray(),
                            16,
                            FontWeight.w400,
                          ),
                        ),
                      ),
                      spaceW4,
                      Expanded(
                        flex: 6,
                        child: RichText(
                          text: TextSpan(
                            text: '',
                            style: textNormal(
                              null,
                              16,
                            ),
                            children: [
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Image.network(
                                  ImageAssets.getSymbolAsset(
                                    'BNB', //todo
                                  ),
                                  width: 16.sp,
                                  height: 16.sp,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                    color: AppTheme.getInstance().bgBtsColor(),
                                    width: 16.sp,
                                    height: 16.sp,
                                  ),
                                ),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: SizedBox(
                                  width: 4.w,
                                ),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Text(
                                  '1000 BNB', //todo
                                  style: textNormalCustom(
                                    null,
                                    16,
                                    FontWeight.w400,
                                  ),
                                ),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: SizedBox(
                                  width: 16.w,
                                ),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => AddCollateral(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    '${S.current.view_all}➞',
                                    style: textNormalCustom(
                                      AppTheme.getInstance().fillColor(),
                                      16,
                                      FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  spaceH16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          '${S.current.total_estimate}:',
                          style: textNormalCustom(
                            AppTheme.getInstance().pawnItemGray(),
                            16,
                            FontWeight.w400,
                          ),
                        ),
                      ),
                      spaceW4,
                      Expanded(
                        flex: 6,
                        child: Text(
                          '\$10000',
                          style: textNormalCustom(
                            null,
                            16,
                            FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  spaceH16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          '${S.current.loan_token}:',
                          style: textNormalCustom(
                            AppTheme.getInstance().pawnItemGray(),
                            16,
                            FontWeight.w400,
                          ),
                        ),
                      ),
                      spaceW4,
                      Expanded(
                        flex: 6,
                        child: RichText(
                          text: TextSpan(
                            text: '',
                            style: textNormal(
                              null,
                              16,
                            ),
                            children: [
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Image.network(
                                  ImageAssets.getSymbolAsset(
                                    'BNB', //todo
                                  ),
                                  width: 16.sp,
                                  height: 16.sp,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                    color: AppTheme.getInstance().bgBtsColor(),
                                    width: 16.sp,
                                    height: 16.sp,
                                  ),
                                ),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: SizedBox(
                                  width: 4.w,
                                ),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Text(
                                  'BNB', //todo
                                  style: textNormalCustom(
                                    null,
                                    16,
                                    FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  spaceH16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          '${S.current.duration_pawn}:',
                          style: textNormalCustom(
                            AppTheme.getInstance().pawnItemGray(),
                            16,
                            FontWeight.w400,
                          ),
                        ),
                      ),
                      spaceW4,
                      Expanded(
                        flex: 6,
                        child: Text(
                          '6 month',
                          style: textNormalCustom(
                            null,
                            16,
                            FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  //todo
                  spaceH36,
                  StreamBuilder<bool>(
                      stream: bloc.isAdd,
                      builder: (context, snapshot) {
                        return ItemWidgetCollateralMyAcc(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 10,
                            shrinkWrap: true,
                            padding: EdgeInsets.only(
                              top: 16.h,
                            ),
                            itemBuilder: (context, index) {
                              return ItemOfferReceived();
                            },
                          ),
                          title: [
                            Text(
                              S.current.offer_received.toUpperCase(),
                              style: textNormalCustom(
                                AppTheme.getInstance().titleTabColor(),
                                16,
                                FontWeight.w400,
                              ),
                            ),
                          ],
                          isBoolAdd: bloc.isAdd,
                        );
                      }),
                  spaceH32,
                  StreamBuilder<bool>(
                      stream: bloc.isAddSend,
                      builder: (context, snapshot) {
                        return ItemWidgetCollateralMyAcc(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 10,
                            shrinkWrap: true,
                            padding: EdgeInsets.only(
                              top: 16.h,
                            ),
                            itemBuilder: (context, index) {
                              return ItemSendTo();
                            },
                          ),
                          title: [
                            Text(
                              S.current.send_to.toUpperCase() +
                                  S.current.loan_package.toUpperCase(),
                              style: textNormalCustom(
                                AppTheme.getInstance().titleTabColor(),
                                16,
                                FontWeight.w400,
                              ),
                            ),
                          ],
                          isBoolAdd: bloc.isAddSend,
                        );
                      }),
                  spaceH152,
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: GestureDetector(
              onTap: () async {},
              child: Container(
                color: AppTheme.getInstance().bgBtsColor(),
                padding: EdgeInsets.only(
                  bottom: 38.h,
                ),
                child: ButtonGold(
                  isEnable: true,
                  title: S.current.withdraw,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
