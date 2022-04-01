import 'dart:async';

import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
import 'package:Dfy/domain/model/pawn/contract_detail_pawn.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/add_more_collateral/bloc/add_more_collateral_bloc.dart';
import 'package:Dfy/presentation/pawn/add_more_collateral/bloc/add_more_collateral_state.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/pop_up_notification.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddMoreCollateral extends StatefulWidget {
  final ContractDetailPawn obj;
  final double totalUnpaid;

  const AddMoreCollateral({
    Key? key,
    required this.obj,
    required this.totalUnpaid,
  }) : super(key: key);

  @override
  _AddMoreCollateralState createState() => _AddMoreCollateralState();
}

class _AddMoreCollateralState extends State<AddMoreCollateral> {
  late AddMoreCollateralBloc bloc;
  late TextEditingController collateralAmount;
  double decimal = 0;

  @override
  void initState() {
    super.initState();
    bloc = AddMoreCollateralBloc();
    collateralAmount = TextEditingController();
    collateralAmount.addListener(() {
      bloc.validateAmount(collateralAmount.text);
      double textAmount = 0;
      final double estimateUsdAmount =
          widget.obj.cryptoCollateral?.estimateUsdAmount ?? 0;
      if (collateralAmount.text.isNotEmpty) {
        textAmount = double.parse(collateralAmount.text);
      }
      bloc.decimalNext //todo tinh sai
          .add((widget.totalUnpaid / (textAmount + estimateUsdAmount)) * 100);
    });
    bloc.getBalanceToken(
      ofAddress: PrefsService.getCurrentBEWallet(),
      tokenAddress: widget.obj.cryptoCollateral?.cryptoAsset?.address ?? '',
    );
    decimal = (widget.obj.contractTerm?.estimateUsdLoanAmount ?? 0) *
        100 /
        (widget.obj.cryptoCollateral?.estimateUsdAmount ?? 0);
    bloc.decimalNext.add(decimal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: BlocBuilder<AddMoreCollateralBloc, AddMoreCollateralState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is AddMoreCollateralSuccess) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                GestureDetector(
                  onTap: () {
                    closeKey(context);
                  },
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 812.h,
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top,
                      ),
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
                              Container(
                                margin: EdgeInsets.only(
                                  left: 16.w,
                                ),
                                width: 24.w,
                                height: 24.h,
                              ),
                              SizedBox(
                                width: 250.w,
                                child: Text(
                                  S.current.add_more_collateral,
                                  style: textNormalCustom(
                                    null,
                                    20.sp,
                                    FontWeight.w700,
                                  ).copyWith(
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 16.w),
                                  width: 24.w,
                                  height: 24.h,
                                  child: Image.asset(ImageAssets.ic_close),
                                ),
                              ),
                            ],
                          ),
                          spaceH20,
                          line,
                          spaceH24,
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                            ),
                            child: Text(
                              S.current.collateral,
                              style: textNormal(
                                AppTheme.getInstance().whiteColor(),
                                16,
                              ),
                            ),
                          ),
                          spaceH4,
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                            ),
                            child: Container(
                              height: 64.h,
                              padding: EdgeInsets.only(right: 15.w, left: 15.w),
                              decoration: BoxDecoration(
                                color:
                                    AppTheme.getInstance().backgroundBTSColor(),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.r)),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                          RegExp(r'^\d+\.?\d{0,5}'),
                                        ),
                                      ],
                                      controller: collateralAmount,
                                      maxLength: 50,
                                      cursorColor:
                                          AppTheme.getInstance().whiteColor(),
                                      style: textNormal(
                                        AppTheme.getInstance().whiteColor(),
                                        16,
                                      ),
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                        decimal: true,
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.zero,
                                        isCollapsed: true,
                                        counterText: '',
                                        hintText: S.current.enter_amount,
                                        hintStyle: textNormal(
                                          Colors.white.withOpacity(0.5),
                                          16,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          collateralAmount.text =
                                              bloc.balanceToken.toString();
                                          bloc.errorCollateral.add('');
                                          closeKey(context);
                                        },
                                        child: Text(
                                          S.current.max,
                                          style: textNormalCustom(
                                            fillYellowColor,
                                            16,
                                            FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      spaceW10,
                                      Row(
                                        children: <Widget>[
                                          SizedBox(
                                            width: 20.w,
                                            height: 20.h,
                                            child: FadeInImage.assetNetwork(
                                              placeholder: ImageAssets.symbol,
                                              image: ImageAssets.getUrlToken(
                                                widget.obj.cryptoCollateral
                                                        ?.cryptoAsset?.symbol
                                                        .toString() ??
                                                    '',
                                              ),
                                            ),
                                          ),
                                          spaceW5,
                                          Text(
                                            widget.obj.cryptoCollateral
                                                    ?.cryptoAsset?.symbol ??
                                                '',
                                            style: textNormal(
                                              null,
                                              16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          spaceH4,
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                            ),
                            child: StreamBuilder<String>(
                              stream: bloc.errorCollateral,
                              builder: (context, snapshot) =>
                                  snapshot.data?.isNotEmpty ?? false
                                      ? Text(
                                          snapshot.data ?? '',
                                          style: textNormalCustom(
                                            AppTheme.getInstance().redColor(),
                                            16,
                                            FontWeight.w400,
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                            ),
                          ),
                          spaceH24,
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${S.current.current_ltv}:',
                                    style: textNormal(
                                      AppTheme.getInstance().whiteColor(),
                                      16,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    '${formatPrice.format(decimal)}%',
                                    style: textNormal(
                                      AppTheme.getInstance().whiteColor(),
                                      16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          spaceH16,
                          StreamBuilder<double>(
                            stream: bloc.decimalNext,
                            builder: (context, snapshot) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${S.current.next_ltv}:',
                                        style: textNormal(
                                          AppTheme.getInstance().whiteColor(),
                                          16,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        '${formatPrice.format(
                                          snapshot.data ?? 0,
                                        )}%',
                                        style: textNormal(
                                          AppTheme.getInstance().whiteColor(),
                                          16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: StreamBuilder<bool>(
                      stream: bloc.isBtn,
                      builder: (context, snapshot) {
                        return GestureDetector(
                          onTap: () async {
                            if (snapshot.data ?? false) {
                              final NavigatorState navigator =
                                  Navigator.of(context);
                              await bloc.getIncreaseCollateralData(
                                bcCollateralId: widget
                                        .obj.cryptoCollateral?.bcCollateralId
                                        .toString() ??
                                    '',
                                bcCollateralAddress: widget.obj.cryptoCollateral
                                        ?.cryptoAsset?.address ??
                                    '',
                                bcContractId:
                                    widget.obj.bcContractId.toString(),
                              );
                              unawaited(
                                navigator.push(
                                  MaterialPageRoute(
                                    builder: (context) => Approve(
                                      textActiveButton:
                                          '${S.current.confirm} ${S.current.add_more_collateral.toLowerCase()}',
                                      spender: Get.find<AppConstants>()
                                          .crypto_pawn_contract,
                                      hexString: bloc.hexString,
                                      tokenAddress: Get.find<AppConstants>()
                                          .contract_defy,
                                      title: S.current.confirm_send_offer,
                                      listDetail: [
                                        DetailItemApproveModel(
                                          title: '${S.current.collateral}: ',
                                          value: '${formatPrice.format(
                                            double.parse(
                                              bloc.amount.value,
                                            ),
                                          )}'
                                              ' ${widget.obj.cryptoCollateral?.cryptoAsset?.symbol.toString() ?? ''}',
                                          urlToken: ImageAssets.getSymbolAsset(
                                            widget.obj.cryptoCollateral
                                                    ?.cryptoAsset?.symbol
                                                    .toString() ??
                                                '',
                                          ),
                                        ),
                                        DetailItemApproveModel(
                                          title: '${S.current.current_ltv}: ',
                                          value: '$decimal%',
                                        ),
                                        DetailItemApproveModel(
                                          title: '${S.current.next_ltv}: ',
                                          value: '${bloc.decimalNext.value}%',
                                        ),
                                      ],
                                      onErrorSign: (context) {},
                                      onSuccessSign: (context, data) {
                                        bloc.putAddMoreCollateral(
                                          symbol: widget.obj.cryptoCollateral
                                                  ?.cryptoAsset?.symbol
                                                  .toString() ??
                                              '',
                                          id: widget.obj.id
                                              .toString(),
                                          amount: double.parse(
                                            bloc.amount.value,
                                          ),
                                          txnHash: data,
                                        );
                                        showLoadSuccess(context).then((value) {
                                          Navigator.of(context)
                                              .popUntil((route) {
                                            return route.settings.name ==
                                                AppRouter
                                                    .contract_detail_my_acc;
                                          });
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          child: Container(
                            color: AppTheme.getInstance().bgBtsColor(),
                            padding: EdgeInsets.only(
                              bottom: 38.h,
                            ),
                            child: ButtonGold(
                              isEnable: snapshot.data ?? false,
                              title: S.current.confirm,
                            ),
                          ),
                        );
                      }),
                ),
              ],
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 100.h,
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

void closeKey(BuildContext context) {
  final FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}
