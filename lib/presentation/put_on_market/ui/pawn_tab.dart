import 'dart:async';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/login/connect_wallet_dialog/ui/connect_wallet_dialog.dart';
import 'package:Dfy/presentation/put_on_market/bloc/put_on_market_cubit.dart';
import 'package:Dfy/presentation/put_on_market/model/nft_put_on_market_model.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/pop_up_notification.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/form/input_number_of_quantity.dart';
import 'package:Dfy/widgets/form/input_with_select_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PawnTab extends StatefulWidget {
  final bool? canEdit;
  final int? quantity;
  final PutOnMarketModel putOnMarketModel;

  final PutOnMarketCubit cubit;

  const PawnTab({
    Key? key,
    required this.cubit,
    this.canEdit = false,
    this.quantity = 1,
    required this.putOnMarketModel,
  }) : super(key: key);

  @override
  _PawnTabState createState() => _PawnTabState();
}

class _PawnTabState extends State<PawnTab>
    with AutomaticKeepAliveClientMixin<PawnTab> {
  late double width, height, xPosition, yPosition;
  int chooseIndex = 0;
  late PutOnMarketModel _putOnMarketModel;
  String? errorTextDuration;

  @override
  void initState() {
    _putOnMarketModel = widget.putOnMarketModel;
    _putOnMarketModel.durationType = 0;
    _putOnMarketModel.numberOfCopies = 1;
    widget.cubit.changeTokenPawn(
      indexToken: 0,
    );
    _putOnMarketModel.tokenAddress = widget.cubit.listToken[0].address ?? '';
    _putOnMarketModel.loanSymbol = widget.cubit.listToken[0].symbol ?? '';
    super.initState();
  }

  void checkDuration() {
    final int duration = widget.cubit.valueDuration ?? 0;
    if (widget.cubit.typeDuration == 0 && duration > 5200) {
      setState(() {
        errorTextDuration = S.current.Duration_by_week_cannot_be_greater_than;
      });
      widget.cubit.validateDuration = false;
    } else if (widget.cubit.typeDuration == 1 && duration > 1200) {
      setState(() {
        errorTextDuration = S.current.Duration_by_month_cannot_be_greater_than;
      });
      widget.cubit.validateDuration = false;
    } else if (duration <= 0) {
      setState(() {
        errorTextDuration = null;
      });
      widget.cubit.validateDuration = false;
    } else {
      widget.cubit.validateDuration = true;
      setState(() {
        errorTextDuration = null;
      });
    }
    widget.cubit.updateStreamContinuePawn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppTheme.getInstance().bgBtsColor(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              Center(
                child: Text(
                  S.current.get_a_loan_by_nft_on_pawn_marketplace,
                  style: textNormalCustom(
                    AppTheme.getInstance().textThemeColor(),
                    16,
                    FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 23,
              ),
              Text(
                S.current.expected_loan,
                style: textNormalCustom(
                  AppTheme.getInstance().textThemeColor(),
                  16,
                  FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                S.current.set_the_loan_amount_you_expected_to_have_for_the_nft,
                style: textNormalCustom(
                  AppTheme.getInstance().textThemeColor().withOpacity(0.7),
                  14,
                  FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              InputWithSelectType(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+\.?\d{0,5}'),
                  ),
                ],
                maxSize: 100,
                keyboardType: TextInputType.number,
                typeInput: widget.cubit.listToken
                    .map(
                      (e) => SizedBox(
                        height: 64,
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Image.network(
                                e.iconUrl ?? '',
                                height: 20,
                                width: 20,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                e.symbol ?? '',
                                style: textValueNFT.copyWith(
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                    .toList(),
                hintText: S.current.enter_price,
                onChangeType: (index) {
                  widget.cubit.changeTokenPawn(
                    indexToken: index,
                  );
                  _putOnMarketModel.tokenAddress =
                      widget.cubit.listToken[index].address ?? '';
                  _putOnMarketModel.loanSymbol =
                      widget.cubit.listToken[index].symbol ?? '';
                },
                onchangeText: (value) {
                  widget.cubit.changeTokenPawn(
                    value: value != '' ? double.parse(value) : 0,
                  );
                  _putOnMarketModel.price = value;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                S.current.duration,
                style: textNormalCustom(
                  AppTheme.getInstance().textThemeColor(),
                  16,
                  FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                S.current.Set_a_duration_for_the_desired_loan_term,
                style: textNormalCustom(
                  AppTheme.getInstance().textThemeColor().withOpacity(0.7),
                  14,
                  FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              InputWithSelectType(
                maxSize: 4,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                typeInput: [
                  SizedBox(
                    height: 40,
                    width: 100,
                    child: Center(
                      child: Text(
                        S.current.week,
                        style: textNormalCustom(
                          AppTheme.getInstance().textThemeColor(),
                          16,
                          FontWeight.w400,
                        ).copyWith(decoration: TextDecoration.none),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 100,
                    child: Center(
                      child: Text(
                        S.current.month,
                        style: textNormalCustom(
                          AppTheme.getInstance().textThemeColor(),
                          16,
                          FontWeight.w400,
                        ).copyWith(decoration: TextDecoration.none),
                      ),
                    ),
                  )
                ],
                hintText: S.current.enter_duration,
                onChangeType: (index) {
                  widget.cubit.changeDurationPawn(
                    type: index,
                  );
                  checkDuration();
                  _putOnMarketModel.durationType = index;
                },
                onchangeText: (value) {
                  widget.cubit.changeDurationPawn(
                    value: value != '' ? int.parse(value) : 0,
                  );
                  checkDuration();
                  _putOnMarketModel.duration = value;
                },
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  child: SizedBox(
                    height: errorTextDuration == null ? 0 : 25,
                    child: Text(
                      errorTextDuration ?? '',
                      style: textNormalCustom(
                        AppTheme.getInstance().redColor(),
                        12,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                S.current.quantity_of_collateral,
                style: textNormalCustom(
                  AppTheme.getInstance().textThemeColor(),
                  16,
                  FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                S.current.set_the_nft_quantity_as_collateral,
                style: textNormalCustom(
                  AppTheme.getInstance().textThemeColor().withOpacity(0.7),
                  14,
                  FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              InputNumberOfQuantity(
                maxLength: 5,
                canEdit: widget.canEdit,
                quantity: widget.quantity,
                onchangeText: (value) {
                  widget.cubit.changeQuantityPawn(
                    value: value != '' ? int.parse(value) : 0,
                  );
                  _putOnMarketModel.numberOfCopies =
                      value != '' ? int.parse(value) : 0;
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.getInstance().bgBtsColor(),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder<bool>(
              stream: widget.cubit.canContinuePawnStream,
              builder: (context, snapshot) {
                final data = snapshot.data ?? false;
                return GestureDetector(
                  onTap: () async {
                    if (data) {
                      final hexString =
                          await widget.cubit.getHexStringPutOnPawn(
                        _putOnMarketModel,
                        context,
                      );
                      await showDialog(
                        context: context,
                        builder: (context) => ConnectWalletDialog(
                          navigationTo: Approve(
                            needApprove: true,
                            payValue: _putOnMarketModel.price,
                            tokenAddress: _putOnMarketModel.tokenAddress,
                            putOnMarketModel: _putOnMarketModel,
                            hexString: hexString,
                            title: S.current.put_on_pawn,
                            onSuccessSign: (context, data) async {
                              final nav = Navigator.of(context);
                              final result = await widget.cubit.putOnPawn(
                                txHash: data,
                                putOnMarketModel: _putOnMarketModel,
                              );
                              nav.pop();
                              if (result) {
                                await showLoadSuccess(context).then((value) {
                                  nav.popUntil((route) {
                                    return route.settings.name ==
                                        AppRouter.putOnSale;
                                  });
                                  nav.pop(PUT_ON_PAWN);
                                });
                              } else {
                                await showLoadFail(context);
                              }
                            },
                            onErrorSign: (context) async {
                              final nav = Navigator.of(context);
                              nav.pop();

                              await showLoadFail(context);
                            },
                            listDetail: [
                              DetailItemApproveModel(
                                title: '${S.current.expected_loan} :',
                                value:
                                    '${widget.cubit.valueTokenInputPawn ?? 0} ${_putOnMarketModel.loanSymbol ?? 'DFY'}',
                                isToken: true,
                              ),
                              DetailItemApproveModel(
                                title: '${S.current.duration} :',
                                value:
                                    '${widget.cubit.valueDuration ?? 0} ${(_putOnMarketModel.durationType ?? 0) == 0 ? S.current.week : S.current.month}',
                              ),
                              DetailItemApproveModel(
                                title: '${S.current.price_per_1} :',
                                value:
                                    '${widget.cubit.quantityPawn} of ${widget.quantity ?? 1}',
                              )
                            ],
                            textActiveButton: S.current.put_on_pawn,
                            spender: Get.find<AppConstants>().nftPawn,
                            isPutOnMarket: true,
                          ),
                          isRequireLoginEmail: true,
                        ),
                      );
                    }
                  },
                  child: ButtonGold(
                    title: S.current.continue_s,
                    isEnable: data,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 38,
            )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
