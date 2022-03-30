import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/contract_detail/bloc/contract_detail_bloc.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common/info_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LTVTAB extends StatefulWidget {
  const LTVTAB({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final ContractDetailBloc bloc;

  @override
  _LTVTABState createState() => _LTVTABState();
}

class _LTVTABState extends State<LTVTAB>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _controller;
  late double decimal; // %
  late double decimalTotal; // %
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 900,
      ),
      // lowerBound: 0.25,
    );
    decimalTotal =
        (widget.bloc.objDetail?.contractTerm?.estimateUsdLoanAmount ?? 0) *
            100 /
            (widget.bloc.objDetail?.cryptoCollateral?.estimateUsdAmount ?? 0);
    if (decimalTotal > 120) {
      decimal = 120;
    } else {
      decimal = decimalTotal;
    }
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        spaceH60,
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                ImageAssets.imgLtv,
                height: 129.h,
                width: 210.w,
              ),
            ),
            Positioned(
              top: 170,
              child: SizedBox(
                width: 100.w,
                child: Text(
                  S.current.your_current_ltv,
                  style: textNormalCustom(
                    null,
                    14,
                    FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              top: 70,
              child: RotationTransition(
                turns: Tween(begin: -0.25, end: -0.25 + (0.0041666 * decimal))
                    .animate(_controller),
                child: Image.asset(
                  ImageAssets.imgLtv2,
                ),
              ),
            ),
            Positioned(
              top: 30,
              right: 0,
              child: SizedBox(
                width: 75.w,
                child: Text(
                  S.current.ltv_liquidation_threshold,
                  style: textNormalCustom(
                    AppTheme.getInstance().redColor(),
                    12,
                    FontWeight.w400,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 110,
              right: 0,
              child: SizedBox(
                width: 70,
                child: Text(
                  S.current.risker,
                  style: textNormalCustom(
                    null,
                    14,
                    FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              top: 110,
              left: 5,
              child: Center(
                child: SizedBox(
                  width: 70,
                  child: Text(
                    S.current.safer,
                    style: textNormalCustom(
                      null,
                      14,
                      FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 300,
              left: 0,
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 343.w,
                        child: RichText(
                          text: TextSpan(
                            text: '',
                            style: textNormalCustom(
                              AppTheme.getInstance().getGray3(),
                              16,
                              FontWeight.w400,
                            ),
                            children: [
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: SizedBox(
                                  width: 90.w,
                                  child: Text(
                                    S.current.your_current_ltv,
                                    style: textNormalCustom(
                                      null,
                                      14,
                                      FontWeight.w400,
                                    ),
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
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => InfoPopup(
                                        name: S.current.ltv_liquid_thres,
                                        content: S.current.ltv_liquid_thres,
                                      ),
                                    ); //todo
                                  },
                                  child: Image.asset(
                                    ImageAssets.ic_about_2,
                                    height: 17.sp,
                                    width: 17.sp,
                                    color: AppTheme.getInstance().getGray3(),
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
                                  ' = ',
                                  style: textNormalCustom(
                                    null,
                                    14,
                                    FontWeight.w400,
                                  ),
                                ),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Column(
                                  children: [
                                    Text(
                                      '${formatPrice.format(widget.bloc.objDetail?.contractTerm?.estimateUsdLoanAmount ?? 0)} x 100',
                                      style: textNormalCustom(
                                        null,
                                        14,
                                        FontWeight.w400,
                                      ),
                                    ),
                                    Container(
                                      width: 7.w *
                                          ((formatPrice.format(
                                                    widget
                                                            .bloc
                                                            .objDetail
                                                            ?.contractTerm
                                                            ?.estimateUsdLoanAmount ??
                                                        0,
                                                  )).length +
                                                  5)
                                              .w,
                                      height: 1.h,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      formatPrice.format(
                                        widget.bloc.objDetail?.contractTerm
                                                ?.estimateUsdAmount ??
                                            0,
                                      ),
                                      style: textNormalCustom(
                                        null,
                                        14,
                                        FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Text(
                                  ' = ',
                                  style: textNormalCustom(
                                    null,
                                    14,
                                    FontWeight.w400,
                                  ),
                                ),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Text(
                                  ' ${formatPrice.format(
                                    decimalTotal,
                                  )}% ',
                                  style: textNormalCustom(
                                    null,
                                    14,
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
                  spaceH32,
                  SizedBox(
                    width: 343.w,
                    child: Text(
                      S.current.your_current_ltv_is,
                      style: textNormalCustom(
                        AppTheme.getInstance().redColor(),
                        14,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
