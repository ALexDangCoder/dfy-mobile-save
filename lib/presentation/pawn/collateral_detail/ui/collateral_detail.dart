import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/pawn/detail_collateral.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/collateral_detail/bloc/collateral_detail_bloc.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollateralDetailScreen extends StatefulWidget {
  final String id;

  const CollateralDetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _CollateralDetailScreenState createState() => _CollateralDetailScreenState();
}

class _CollateralDetailScreenState extends State<CollateralDetailScreen> {
  late CollateralDetailBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = CollateralDetailBloc(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
      title: S.current.collateral_detail,
      isImage: true,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          spaceH8,
          Container(
            padding: EdgeInsets.all(16.w),
            child: StreamBuilder<CollateralDetail>(
              stream: bloc.objCollateral,
              builder: (context, snapshot) {
                final obj = snapshot.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.current.collateral_of_bda,
                      style: textNormalCustom(
                        null,
                        20,
                        FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    spaceH8,
                    Row(
                      children: [
                        Text(
                          '${S.current.borrower}:',
                          style: textNormalCustom(
                            AppTheme.getInstance().getGray3(),
                            16,
                            FontWeight.w400,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        spaceW8,
                        Text(
                          (obj?.walletAddress?.length ?? 0) > 10
                              ? (obj?.walletAddress ?? '')
                                  .formatAddressActivityFire()
                              : obj?.walletAddress ?? '',
                          style: textNormalCustom(
                            AppTheme.getInstance().blueColor(),
                            16,
                            FontWeight.w400,
                          ).copyWith(
                            decoration: TextDecoration.underline,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    spaceH8,
                    Row(
                      children: [
                        Text(
                          '${S.current.borrower}:',
                          style: textNormalCustom(
                            AppTheme.getInstance().bgBtsColor(),
                            16,
                            FontWeight.w400,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        spaceW8,
                        RichText(
                          text: TextSpan(
                            text: '',
                            style: textNormal(
                              null,
                              16,
                            ),
                            children: [
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Image.asset(
                                  ImageAssets.img_star,
                                  width: 16.sp,
                                  height: 16.sp,
                                ),
                              ),
                              WidgetSpan(
                                child: SizedBox(
                                  width: 4.w,
                                ),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: StreamBuilder<String>(
                                  stream: bloc.rate,
                                  builder: (context, snapshot) {
                                    return Text(
                                      snapshot.data ?? '',
                                      style: textNormal(
                                        null,
                                        16,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    spaceH20,
                    GestureDetector(
                      onTap: () {
                        //todo
                      },
                      child: Center(
                        child: Container(
                          width: 122.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: AppTheme.getInstance().bgBtsColor(),
                            border: Border.all(
                              width: 1.w,
                              color: AppTheme.getInstance().fillColor(),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              S.current.view_profile,
                              maxLines: 1,
                              style: textNormalCustom(
                                AppTheme.getInstance().fillColor(),
                                16,
                                FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ),
                    spaceH16,
                    line,
                    spaceH16,
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            '${S.current.collateral}:',
                            maxLines: 1,
                            style: textNormalCustom(
                              AppTheme.getInstance().getGray3(),
                              16,
                              FontWeight.w400,
                            ),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            '${formatPrice.format(obj?.collateralAmount ?? 0)} '
                            ' ${obj?.collateralSymbol}',
                            maxLines: 1,
                            style: textNormalCustom(
                              null,
                              16,
                              FontWeight.w400,
                            ),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    spaceH4,
                    Row(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: SizedBox.shrink(),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            '${formatPrice.format(obj?.estimatePrice ?? 0)}  USD',
                            maxLines: 1,
                            style: textNormalCustom(
                              AppTheme.getInstance()
                                  .whiteWithOpacitySevenZero(),
                              16,
                              FontWeight.w400,
                            ),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    spaceH16,
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            '${S.current.loan_token}:',
                            maxLines: 1,
                            style: textNormalCustom(
                              AppTheme.getInstance().getGray3(),
                              16,
                              FontWeight.w400,
                            ),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: RichText(
                            text: TextSpan(
                              text: '',
                              style: textNormalCustom(
                                null,
                                16,
                                FontWeight.w400,
                              ),
                              children: [
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Image.network(
                                    ImageAssets.getSymbolAsset(
                                      obj?.loanSymbol ?? '',
                                    ),
                                    width: 16.sp,
                                    height: 16.sp,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                      color:
                                          AppTheme.getInstance().bgBtsColor(),
                                      width: 16.sp,
                                      height: 16.sp,
                                    ),
                                  ),
                                ),
                                WidgetSpan(
                                  child: SizedBox(
                                    width: 4.w,
                                  ),
                                ),
                                TextSpan(
                                  text: obj?.loanSymbol ?? '',
                                  style: textNormalCustom(
                                    null,
                                    16,
                                    FontWeight.w400,
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
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            '${S.current.duration}:',
                            maxLines: 1,
                            style: textNormalCustom(
                              AppTheme.getInstance().getGray3(),
                              16,
                              FontWeight.w400,
                            ),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            bloc.getTime(
                              type: obj?.durationType ?? 0,
                              time: obj?.durationQty ?? 0,
                            ),
                            maxLines: 1,
                            style: textNormalCustom(
                              null,
                              16,
                              FontWeight.w400,
                            ),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              //todo
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: 38.h),
              child: ButtonGold(
                isEnable: true,
                title: S.current.view_evaluation,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
