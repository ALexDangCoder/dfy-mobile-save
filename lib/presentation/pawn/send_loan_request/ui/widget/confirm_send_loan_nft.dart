import 'dart:async';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/ui/nft_item/ui/nft_item.dart';
import 'package:Dfy/presentation/pawn/send_loan_request/bloc/send_loan_request_cubit.dart';
import 'package:Dfy/presentation/transaction_submit/transaction_submit.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/pop_up_notification.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

final formatValue = NumberFormat('###,###,###.###', 'en_US');

class ConfirmSendLoanNft extends StatelessWidget {
  const ConfirmSendLoanNft({
    Key? key,
    required this.cubit,
    required this.isNftPawn,
  }) : super(key: key);
  final SendLoanRequestCubit cubit;
  final bool isNftPawn;

  @override
  Widget build(BuildContext context) {
    final String duration =
        cubit.nftRequest.durationType == 0 ? 'weeks' : 'months';
    return BlocConsumer<SendLoanRequestCubit, SendLoanRequestState>(
      bloc: cubit,
      listener: (context, state) async {
        if (state is SubmitNftSuccess) {
          if (state.complete == CompleteType.SUCCESS) {
            await showLoadSuccess(context).then(
              (value) => {
                if (isNftPawn)
                  {
                    Navigator.pop(context),
                    Navigator.pop(context),
                    Navigator.pop(context),
                    Navigator.pop(context),
                    Navigator.pop(context),
                  }
                else
                  {
                    Navigator.pop(context),
                    Navigator.pop(context),
                    Navigator.pop(context),
                    Navigator.pop(context),
                  }
              },
            );
          } else {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) {
                return GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: GestureDetector(
                      onTap: () {},
                      child: Center(
                        child: Container(
                          constraints: BoxConstraints(minHeight: 177.h),
                          width: 312.w,
                          decoration: BoxDecoration(
                            color: AppTheme.getInstance().bgBtsColor(),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(36)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 20.0,
                                  bottom: 19,
                                ),
                                child: Text(
                                  S.current.warning,
                                  style: textNormal(
                                    AppTheme.getInstance().redColor(),
                                    20,
                                  ).copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                width: double.maxFinite,
                                padding: const EdgeInsets.only(
                                  right: 35,
                                  bottom: 24,
                                  left: 35,
                                ),
                                child: Text(
                                  cubit.checkPostNft,
                                  style: textNormal(
                                    AppTheme.getInstance().whiteColor(),
                                    16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      width: 1.w,
                                      color: AppTheme.getInstance()
                                          .whiteBackgroundButtonColor(),
                                    ),
                                  ),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    //todo
                                    Navigator.pop(context);
                                  },
                                  behavior: HitTestBehavior.opaque,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 19,
                                      top: 17,
                                    ),
                                    child: Text(
                                      S.current.ok,
                                      style: textNormal(
                                        AppTheme.getInstance().fillColor(),
                                        20,
                                      ).copyWith(fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ).then((value) => {
                  if (isNftPawn)
                    {
                      Navigator.of(context)
                        ..pop()
                        ..pop()
                        ..pop()
                        ..pop()
                        ..pop(),
                    }
                  else
                    {
                      Navigator.of(context)
                        ..pop()
                        ..pop()
                        ..pop()
                        ..pop(),
                    }
                });
          }
        } else {
          unawaited(
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) => const AlertDialog(
                backgroundColor: Colors.transparent,
                content: TransactionSubmit(),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return BaseDesignScreen(
          title: 'Confirm loan request',
          onRightClick: () {
            Navigator.pop(context);
          },
          text: ImageAssets.ic_close,
          bottomBar: Container(
            padding: EdgeInsets.only(bottom: 38.h),
            color: AppTheme.getInstance().bgBtsColor(),
            child: InkWell(
              onTap: () async {
                unawaited(
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => const AlertDialog(
                      backgroundColor: Colors.transparent,
                      content: TransactionSubmit(),
                    ),
                  ),
                );
                await cubit.postNftToServer();
              },
              child: const ButtonGold(
                title: 'Send request',
                isEnable: true,
              ),
            ),
          ),
          isImage: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spaceH24,
              Padding(
                padding: EdgeInsets.only(
                  left: 16.w,
                ),
                child: Text(
                  'Collateral:',
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteWithOpacitySevenZero(),
                    16,
                    FontWeight.w400,
                  ),
                ),
              ),
              spaceH16,
              Padding(
                padding: EdgeInsets.only(
                  left: 110.w,
                ),
                child: NFTItemWidget(nftMarket: cubit.nftMarketConfirm),
              ),
              spaceH20,
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Message:',
                      style: textNormalCustom(
                        AppTheme.getInstance().whiteWithOpacitySevenZero(),
                        16,
                        FontWeight.w400,
                      ),
                    ),
                    spaceW20,
                    Flexible(
                      child: Text(
                        cubit.nftRequest.message ?? '',
                        style: textNormalCustom(
                          AppTheme.getInstance().whiteColor(),
                          16,
                          FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              spaceH20,
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Loan amount:',
                      style: textNormalCustom(
                        AppTheme.getInstance().whiteWithOpacitySevenZero(),
                        16,
                        FontWeight.w400,
                      ),
                    ),
                    spaceW20,
                    SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: Image.network(
                        ImageAssets.getSymbolAsset(
                          cubit.nftRequest.loanSymbol ?? DFY,
                        ),
                      ),
                    ),
                    spaceW5,
                    Flexible(
                      child: Text(
                        formatValue.format(cubit.nftRequest.loanAmount ?? 0),
                        style: textNormalCustom(
                          AppTheme.getInstance().whiteColor(),
                          16,
                          FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              spaceH20,
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Row(
                  children: [
                    Text(
                      'Duration:',
                      style: textNormalCustom(
                        AppTheme.getInstance().whiteWithOpacitySevenZero(),
                        16,
                        FontWeight.w400,
                      ),
                    ),
                    spaceW20,
                    Text(
                      '${cubit.nftRequest.durationTime.toString()} $duration',
                      style: textNormalCustom(
                        null,
                        16,
                        FontWeight.w400,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
