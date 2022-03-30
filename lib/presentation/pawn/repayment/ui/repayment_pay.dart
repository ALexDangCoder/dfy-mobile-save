import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/pawn/repayment_request_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/add_more_collateral/ui/add_more_collateral.dart';
import 'package:Dfy/presentation/pawn/repayment/bloc/repayment_pay_bloc.dart';
import 'package:Dfy/presentation/pawn/repayment/bloc/repayment_pay_state.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common/info_popup.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'item_repayment.dart';

enum TypeRepayment { LOAN, PENALTY_INTEREST }

class RepaymentPay extends StatefulWidget {
  const RepaymentPay({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  _RepaymentPayState createState() => _RepaymentPayState();
}

class _RepaymentPayState extends State<RepaymentPay> {
  late RepaymentPayBloc bloc;
  late TextEditingController penalty;
  late TextEditingController interest;
  late TextEditingController loan;

  RepaymentRequestModel obj = RepaymentRequestModel.name();
  String mes = '';
  late bool isChoose;

  @override
  void initState() {
    super.initState();
    bloc = RepaymentPayBloc();
    penalty = TextEditingController();
    interest = TextEditingController();
    loan = TextEditingController();
    penalty.addListener(() {
      bloc.penalty.add(penalty.text);
      bloc.validatePenalty(penalty.text);
    });
    interest.addListener(() {
      bloc.interest.add(interest.text);
      bloc.validateInterest(interest.text);
    });
    loan.addListener(() {
      bloc.loan.add(loan.text);
      bloc.validateLoan(loan.text);
    });
    bloc.getRepaymentPay(
      collateralId: widget.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
      title: S.current.repayment,
      text: ImageAssets.ic_close,
      isImage: true,
      onRightClick: () {
        Navigator.pop(context);
      },
      child: BlocConsumer<RepaymentPayBloc, RepaymentPayState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is RepaymentPaySuccess) {
            bloc.showContent();
            if (state.completeType == CompleteType.SUCCESS) {
              obj = state.obj ?? obj;
              if ((obj.penalty?.address.toString().toUpperCase() ==
                      obj.interest?.address.toString().toUpperCase()) &&
                  (obj.penalty?.address.toString().toUpperCase() ==
                      obj.loan?.address.toString().toUpperCase()) &&
                  (obj.loan?.address.toString().toUpperCase() ==
                      obj.interest?.address.toString().toUpperCase())) {
                isChoose = true;
              } else {
                isChoose = false;
              }
              bloc.getBalanceToken(
                type: 0,
                ofAddress: PrefsService.getCurrentBEWallet(),
                tokenAddress: obj.penalty?.address.toString() ?? '',
              );
              bloc.getBalanceToken(
                type: 1,
                ofAddress: PrefsService.getCurrentBEWallet(),
                tokenAddress: obj.interest?.address.toString() ?? '',
              );
              bloc.getBalanceToken(
                type: 2,
                ofAddress: PrefsService.getCurrentBEWallet(),
                tokenAddress: obj.loan?.address.toString() ?? '',
              );
            } else {
              mes = state.message ?? '';
            }
          }
        },
        builder: (context, state) {
          return StateStreamLayout(
            stream: bloc.stateStream,
            retry: () {
              bloc.getRepaymentPay(
                collateralId: widget.id,
              );
            },
            error: AppException(S.current.error, mes),
            textEmpty: mes,
            child: state is RepaymentPaySuccess
                ? GestureDetector(
                    onTap: () => closeKey(context),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          height: 812.h,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                spaceH20,
                                formAddress(
                                  '${S.current.from}:',
                                  (obj.borrowerWalletAddress ?? '')
                                      .formatAddressWalletConfirm(),
                                ),
                                spaceH16,
                                formAddress(
                                  '${S.current.to}:',
                                  (obj.lenderWalletAddress ?? '')
                                      .formatAddressWalletConfirm(),
                                ),
                                spaceH32,
                                if (!isChoose)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 24.w,
                                              height: 24.h,
                                              child: Theme(
                                                data:
                                                    Theme.of(context).copyWith(
                                                  unselectedWidgetColor:
                                                      AppTheme.getInstance()
                                                          .whiteColor(),
                                                ),
                                                child: Radio<TypeRepayment>(
                                                  activeColor:
                                                      AppTheme.getInstance()
                                                          .fillColor(),
                                                  value: TypeRepayment
                                                      .PENALTY_INTEREST,
                                                  groupValue: bloc.type,
                                                  onChanged:
                                                      (TypeRepayment? value) {
                                                    bloc.type = value ??
                                                        TypeRepayment
                                                            .PENALTY_INTEREST;
                                                    setState(() {});
                                                  },
                                                ),
                                              ),
                                            ),
                                            spaceW4,
                                            GestureDetector(
                                              onTap: () {
                                                bloc.type = TypeRepayment
                                                    .PENALTY_INTEREST;
                                                setState(() {});
                                              },
                                              child: Text(
                                                S.current.penalty_interest,
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
                                      Expanded(
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 24.w,
                                              height: 24.h,
                                              child: Theme(
                                                data:
                                                    Theme.of(context).copyWith(
                                                  unselectedWidgetColor:
                                                      AppTheme.getInstance()
                                                          .whiteColor(),
                                                ),
                                                child: Radio<TypeRepayment>(
                                                  activeColor:
                                                      AppTheme.getInstance()
                                                          .fillColor(),
                                                  value: TypeRepayment.LOAN,
                                                  groupValue: bloc.type,
                                                  onChanged:
                                                      (TypeRepayment? value) {
                                                    bloc.type = value ??
                                                        TypeRepayment
                                                            .PENALTY_INTEREST;
                                                    setState(() {});
                                                  },
                                                ),
                                              ),
                                            ),
                                            spaceW4,
                                            GestureDetector(
                                              onTap: () {
                                                bloc.type = TypeRepayment.LOAN;
                                                setState(() {});
                                              },
                                              child: Text(
                                                S.current.loan,
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
                                    ],
                                  ),
                                if (!isChoose) spaceH24,
                                ItemRepayment(
                                  enabled: isChoose
                                      ? isChoose
                                      : bloc.type ==
                                          TypeRepayment.PENALTY_INTEREST,
                                  textController: penalty,
                                  symbol: obj.penalty?.symbol.toString() ?? '',
                                  value:
                                      '${formatPrice.format(obj.penalty?.amountPaid ?? 0)}'
                                      '/${formatPrice.format(obj.penalty?.amount ?? 0)} '
                                      '${obj.penalty?.symbol.toString() ?? ''}',
                                  title: S.current.penalty,
                                  funText: () {},
                                  funMax: () {
                                    penalty.text =
                                        (obj.penalty?.amount ?? 0).toString();
                                    closeKey(context);
                                  },
                                  isCheck: bloc.isPenalty,
                                ),
                                spaceH20,
                                ItemRepayment(
                                  enabled: isChoose
                                      ? isChoose
                                      : bloc.type ==
                                          TypeRepayment.PENALTY_INTEREST,
                                  textController: interest,
                                  symbol: obj.interest?.symbol.toString() ?? '',
                                  value:
                                      '${formatPrice.format(obj.interest?.amountPaid ?? 0)}'
                                      '/${formatPrice.format(obj.interest?.amount ?? 0)} '
                                      '${obj.interest?.symbol.toString() ?? ''}',
                                  title: S.current.interest,
                                  funText: () {},
                                  funMax: () {
                                    interest.text =
                                        (obj.interest?.amount ?? 0).toString();
                                    closeKey(context);
                                  },
                                  isCheck: bloc.isInterest,
                                ),
                                spaceH20,
                                ItemRepayment(
                                  enabled: isChoose
                                      ? isChoose
                                      : bloc.type == TypeRepayment.LOAN,
                                  textController: loan,
                                  symbol: obj.interest?.symbol.toString() ?? '',
                                  value:
                                      '${formatPrice.format(obj.loan?.amountPaid ?? 0)}'
                                      '/${formatPrice.format(obj.loan?.amount ?? 0)} '
                                      '${obj.loan?.symbol.toString() ?? ''}',
                                  title: S.current.loan,
                                  funText: () {},
                                  funMax: () {
                                    loan.text =
                                        (obj.loan?.amount ?? 0).toString();
                                    closeKey(context);
                                  },
                                  isCheck: bloc.isLoan,
                                ),
                                spaceH20,
                                RichText(
                                  text: TextSpan(
                                    text: '',
                                    style: textNormalCustom(
                                      null,
                                      14,
                                      FontWeight.w400,
                                    ),
                                    children: [
                                      WidgetSpan(
                                        child: GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (_) => InfoPopup(
                                                name:
                                                    S.current.ltv_liquid_thres,
                                                content:
                                                    S.current.ltv_liquid_thres,
                                              ),
                                            ); //todo
                                          },
                                          child: Image.asset(
                                            ImageAssets.ic_about_2,
                                            width: 17.sp,
                                            height: 17.sp,
                                          ),
                                        ),
                                      ),
                                      WidgetSpan(
                                        child: spaceW4,
                                      ),
                                      TextSpan(
                                        text: S.current
                                            .in_order_to_repay_the_period_interest,
                                      ),
                                      TextSpan(
                                        text: S.current.max,
                                        style: textNormalCustom(
                                          AppTheme.getInstance().fillColor(),
                                          14,
                                          FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: S.current.to_full_fill,
                                      ),
                                    ],
                                  ),
                                ),
                                spaceH152,
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: GestureDetector(
                            onTap: () {
                              print(
                                '------${bloc.interest.value}${bloc.penalty.value}${bloc.loan.value}',
                              );
                              bloc.postRepaymentPay();
                              // if (PrefsService.getCurrentWalletCore()
                              //         .toLowerCase() ==
                              //     obj.walletAddress) {
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           ConfirmWithDrawCollateral(
                              //         bloc: bloc,
                              //         obj: obj,
                              //       ),
                              //     ),
                              //   ).whenComplete(
                              //     () => bloc.getDetailCollateralMyAcc(
                              //       collateralId: widget.id,
                              //     ),
                              //   );
                              // } else {
                              //   showAlert(
                              //     context,
                              //     obj.walletAddress.toString(),
                              //   );
                              // }
                            },
                            child: Container(
                              color: AppTheme.getInstance().bgBtsColor(),
                              padding: EdgeInsets.only(
                                bottom: 38.h,
                              ),
                              child: ButtonGold(
                                isEnable: true,
                                title: S.current.pay,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

Widget formAddress(String title, String address) {
  return Row(
    children: [
      Expanded(
        child: Text(
          title,
          style: textNormalCustom(
            AppTheme.getInstance().whiteWithOpacitySevenZero(),
            16,
            FontWeight.w400,
          ),
        ),
      ),
      Expanded(
        flex: 3,
        child: Text(
          address,
          style: textNormalCustom(
            null,
            16,
            FontWeight.w400,
          ),
        ),
      ),
    ],
  );
}
