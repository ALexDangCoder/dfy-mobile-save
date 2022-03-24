import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/pawn/offer_detail_my_acc.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/nft_detail/ui/nft_detail.dart';
import 'package:Dfy/presentation/pawn/offer_detail/bloc/offer_detail_my_acc_bloc.dart';
import 'package:Dfy/presentation/pawn/offer_detail/bloc/offer_detail_my_acc_state.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/common_ext.dart';
import 'package:Dfy/utils/extensions/int_extension.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'confirm_accept.dart';
import 'confirm_reject.dart';

class OfferDetailMyAccScreen extends StatefulWidget {
  const OfferDetailMyAccScreen({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  _OfferDetailMyAccScreenState createState() => _OfferDetailMyAccScreenState();
}

class _OfferDetailMyAccScreenState extends State<OfferDetailMyAccScreen> {
  late OfferDetailMyAccBloc bloc;
  OfferDetailMyAcc obj = OfferDetailMyAcc();
  String mes = '';

  @override
  void initState() {
    super.initState();
    bloc = OfferDetailMyAccBloc(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
      title: S.current.offer_detail,
      isImage: true,
      child: BlocConsumer<OfferDetailMyAccBloc, OfferDetailMyAccState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is OfferDetailMyAccSuccess) {
            bloc.showContent();
            if (state.completeType == CompleteType.SUCCESS) {
              obj = state.obj ?? obj;
              bloc.getReputation(obj.walletAddress.toString());
            } else {
              mes = state.message ?? '';
            }
          }
        },
        builder: (context, state) {
          return StateStreamLayout(
            stream: bloc.stateStream,
            retry: () {
              bloc.getOfferDetailMyAcc(
                id: widget.id,
              );
            },
            error: AppException(S.current.error, mes),
            textEmpty: mes,
            child: state is OfferDetailMyAccSuccess
                ? Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                  width: 343.w,
                                  margin: EdgeInsets.only(
                                    bottom: 20.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppTheme.getInstance()
                                        .borderItemColor(),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.r),
                                    ),
                                    border: Border.all(
                                      color:
                                          AppTheme.getInstance().divideColor(),
                                    ),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      right: 16.w,
                                      left: 16.w,
                                      top: 20.h,
                                      bottom: 20.h,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          S.current.lender,
                                          style: textNormalCustom(
                                            null,
                                            20,
                                            FontWeight.w700,
                                          ),
                                        ),
                                        spaceH8,
                                        RichText(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(
                                            text: '',
                                            style: textNormal(
                                              null,
                                              16,
                                            ),
                                            children: [
                                              WidgetSpan(
                                                alignment:
                                                    PlaceholderAlignment.middle,
                                                child: Text(
                                                  '${S.current.address}:',
                                                  style: textNormalCustom(
                                                    AppTheme.getInstance()
                                                        .pawnItemGray(),
                                                    16,
                                                    FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              WidgetSpan(
                                                alignment:
                                                    PlaceholderAlignment.middle,
                                                child: SizedBox(
                                                  width: 4.w,
                                                ),
                                              ),
                                              WidgetSpan(
                                                alignment:
                                                    PlaceholderAlignment.middle,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    launchURL(
                                                      Get.find<
                                                                  AppConstants>()
                                                              .bscScan +
                                                          ApiConstants
                                                              .BSC_SCAN_ADDRESS +
                                                          (obj.walletAddress ??
                                                              ''),
                                                    );
                                                  },
                                                  child: Text(
                                                    checkNullAddressWallet(
                                                      obj.walletAddress ?? '',
                                                    ),
                                                    style: textNormalCustom(
                                                      AppTheme.getInstance()
                                                          .blueMarketColors(),
                                                      16,
                                                      FontWeight.w400,
                                                    ).copyWith(
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        spaceH8,
                                        RichText(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(
                                            text: '',
                                            style: textNormal(
                                              null,
                                              16,
                                            ),
                                            children: [
                                              WidgetSpan(
                                                alignment:
                                                    PlaceholderAlignment.middle,
                                                child: Text(
                                                  '${S.current.address}:',
                                                  style: textNormalCustom(
                                                    AppTheme.getInstance()
                                                        .borderItemColor(),
                                                    16,
                                                    FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              WidgetSpan(
                                                alignment:
                                                    PlaceholderAlignment.middle,
                                                child: Image.asset(
                                                  ImageAssets.ic_star,
                                                  height: 20.h,
                                                  width: 20.w,
                                                ),
                                              ),
                                              WidgetSpan(
                                                alignment:
                                                    PlaceholderAlignment.middle,
                                                child: SizedBox(
                                                  width: 4.w,
                                                ),
                                              ),
                                              WidgetSpan(
                                                alignment:
                                                    PlaceholderAlignment.middle,
                                                child: StreamBuilder<String>(
                                                  stream: bloc.rate,
                                                  builder: (context, snapshot) {
                                                    return Text(
                                                      snapshot.data.toString(),
                                                      style: textNormalCustom(
                                                        null,
                                                        16,
                                                        FontWeight.w400,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        spaceH20,
                                        Center(
                                          child: GestureDetector(
                                            onTap: () {
                                              //todo
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 20.w,
                                                vertical: 10.h,
                                              ),
                                              decoration: BoxDecoration(
                                                color: AppTheme.getInstance()
                                                    .borderItemColor(),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(12.r),
                                                ),
                                                border: Border.all(
                                                  color: AppTheme.getInstance()
                                                      .fillColor(),
                                                ),
                                              ),
                                              child: Text(
                                                S.current.view_profile,
                                                style: textNormalCustom(
                                                  AppTheme.getInstance()
                                                      .fillColor(),
                                                  16,
                                                  FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              spaceH32,
                              richText(
                                value: bloc.getStatusOffer(obj.status ?? 0),
                                fontW: FontWeight.w600,
                                myColor: bloc.getColorOffer(obj.status ?? 0),
                                title: '${S.current.status}:',
                              ),
                              spaceH16,
                              richText(
                                title: '${S.current.message}:',
                                value: obj.description.toString(),
                              ),
                              spaceH16,
                              richText(
                                title: S.current.loan_amount,
                                value:
                                    '${formatPrice.format(obj.loanAmount ?? 0)}'
                                    ' ${obj.supplyCurrencySymbol}',
                                isIcon: true,
                                url: ImageAssets.getSymbolAsset(
                                  obj.supplyCurrencySymbol.toString(),
                                ),
                              ),
                              spaceH16,
                              richText(
                                title: '${S.current.loan_to_value}:',
                                value: '${obj.loanAmount}%',
                              ),
                              spaceH16,
                              richText(
                                title: '${S.current.interest_rate_apr}:',
                                value: '${obj.interestRate}% ',
                              ),
                              spaceH16,
                              richText(
                                title: '${S.current.liquidation_threshold}:',
                                value: '${obj.liquidationThreshold}%',
                              ),
                              spaceH16,
                              richText(
                                title: '${S.current.recurring_interest_pawn}:',
                                value: obj.repaymentCycleType == WEEK
                                    ? S.current.weeks_pawn
                                    : S.current.months_pawn,
                              ),
                              spaceH16,
                              richText(
                                title: '${S.current.repayment_token}:',
                                value: obj.repaymentToken.toString(),
                                url: ImageAssets.getSymbolAsset(
                                  obj.repaymentToken.toString(),
                                ),
                                isIcon: true,
                              ),
                              spaceH16,
                              richText(
                                title: '${S.current.duration}:',
                                value:
                                    '${obj.durationQty} ${obj.durationType == WEEK ? S.current.weeks_pawn : S.current.months_pawn}',
                              ),
                              spaceH16,
                              richText(
                                title: '${S.current.offer_create_day}:',
                                value: 0.formatHourMyPawn(obj.createdAt ?? 0),
                              ),
                              spaceH60,
                              spaceH60,
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: bloc.getCheckStatusBtn(obj.status ?? 0)
                            ? Container(
                                padding: EdgeInsets.only(
                                  bottom: 16.h,
                                ),
                                width: 343.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return ConfirmAccept(
                                                bloc: bloc,
                                              );
                                            },
                                          ),
                                        );
                                        if (PrefsService.getCurrentWalletCore()
                                                .toLowerCase() ==
                                            obj.walletAddress) {
                                          //todo
                                        } else {
                                          // showAlert(
                                          //   context,
                                          //   obj.walletAddress.toString(),
                                          // );//todo
                                        }
                                      },
                                      child: Container(
                                        height: 64.h,
                                        width: 159.w,
                                        decoration: BoxDecoration(
                                          color: AppTheme.getInstance()
                                              .borderItemColor(),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20.r),
                                          ),
                                          border: Border.all(
                                            color: AppTheme.getInstance()
                                                .fillColor(),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            S.current.reject_ed,
                                            style: textNormalCustom(
                                              AppTheme.getInstance()
                                                  .fillColor(),
                                              20,
                                              FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return ConfirmReject(
                                                bloc: bloc,
                                              );
                                            },
                                          ),
                                        );
                                        if (PrefsService.getCurrentWalletCore()
                                                .toLowerCase() ==
                                            obj.walletAddress) {
                                          //todo
                                        } else {
                                          // showAlert(
                                          //   context,
                                          //   obj.walletAddress.toString(),
                                          // );//todo
                                        }
                                      },
                                      child: SizedBox(
                                        width: 159.w,
                                        child: ButtonGold(
                                          isEnable: true,
                                          fixSize: false,
                                          haveMargin: false,
                                          title: S.current.accepted,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

Widget richText({
  required String title,
  String? url,
  required String value,
  Color myColor = Colors.white,
  FontWeight fontW = FontWeight.w400,
  bool isIcon = false,
}) {
  return RichText(
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
          child: Text(
            title,
            style: textNormalCustom(
              AppTheme.getInstance().getGray3(),
              16,
              FontWeight.w400,
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
          child: isIcon
              ? Image.network(
                  url ?? '',
                  height: 20.h,
                  width: 20.w,
                  errorBuilder: (
                    context,
                    error,
                    stackTrace,
                  ) =>
                      Container(
                    height: 20.h,
                    width: 20.w,
                    color: AppTheme.getInstance().backgroundBTSColor(),
                  ),
                )
              : const SizedBox.shrink(),
        ),
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: SizedBox(
            width: 4.w,
          ),
        ),
        TextSpan(
          text: value,
          style: textNormalCustom(
            myColor,
            15,
            fontW,
          ),
        )
      ],
    ),
  );
}
