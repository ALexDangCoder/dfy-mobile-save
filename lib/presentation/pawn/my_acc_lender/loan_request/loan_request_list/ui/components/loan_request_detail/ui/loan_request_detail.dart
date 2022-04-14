import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/loan_request/loan_request_list/ui/components/loan_request_detail/bloc/loan_request_detail_cubit.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/loan_request/loan_request_list/ui/components/send_offfer/ui/confirm_reject_loan_request.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/loan_request/loan_request_list/ui/components/send_offfer/ui/loan_send_offer.dart';
import 'package:Dfy/presentation/pawn/other_profile/ui/view_other_profile.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/utils/screen_controller.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

//todo màn này còn vấn đề về estimate giá,
//todo và send off,, rejecgt

enum TypeDetail {
  CRYPTO,
  NFT,
}

final formatValue = NumberFormat('###,###,###.###', 'en_US');

class LoanRequestDetail extends StatefulWidget {
  const LoanRequestDetail({
    Key? key,
    required this.typeDetail,
    required this.walletAddress,
    required this.id,
  }) : super(key: key);
  final TypeDetail typeDetail;
  final String walletAddress;
  final String id;

  @override
  _LoanRequestDetailState createState() => _LoanRequestDetailState();
}

class _LoanRequestDetailState extends State<LoanRequestDetail> {
  late LoanRequestDetailCubit cubit;

  @override
  void initState() {
    cubit = LoanRequestDetailCubit();
    cubit.getTokenInf();
    if (widget.typeDetail == TypeDetail.CRYPTO) {
      cubit.callAllApi(walletAddress: widget.walletAddress, id: widget.id);
    } else {
      //nft

    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoanRequestDetailCubit, LoanRequestDetailState>(
      // listener: (context, state) {
      //   if (state is LoanRequestDetailLoadApi) {
      //     if (state.completeType == CompleteType.SUCCESS) {
      //       cubit.showContent();
      //     } else {
      //       cubit.showError();
      //     }
      //   }
      // },
      bloc: cubit,
      builder: (context, state) {
        return StateStreamLayout(
          stream: cubit.stateStream,
          textEmpty: S.current.something_went_wrong,
          retry: () {},
          error: AppException(S.current.error, S.current.something_went_wrong),
          child: (state is LoanRequestDetailLoadApi)
              ? BaseDesignScreen(
                  bottomBar:
                      ((cubit.detailLoanRequestCryptoModel.status ?? 0) == 1)
                          ? _buildButton()
                          : null,
                  // _buildButton(),
                  title: S.current.request_detail,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                      ),
                      child: Column(
                        children: [
                          spaceH24,
                          _borrowerInformation(),
                          spaceH32,
                          _buildCrypto(),
                        ],
                      ),
                    ),
                  ),
                )
              : Container(
                  color: AppTheme.getInstance().bgBtsColor(),
                ),
        );
      },
    );
  }

  Widget _buildButton() {
    return Container(
      color: AppTheme.getInstance().bgBtsColor(),
      padding: EdgeInsets.only(bottom: 16.h, left: 16.w, right: 16.w),
      width: 343.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ConfirmRejectLoanRequest(
                            cubit: cubit,
                            id: cubit.detailLoanRequestCryptoModel.id
                                .toString(),
                          )));
            },
            child: Container(
              height: 64.h,
              width: 159.w,
              decoration: BoxDecoration(
                color: AppTheme.getInstance().borderItemColor(),
                borderRadius: BorderRadius.all(
                  Radius.circular(20.r),
                ),
                border: Border.all(
                  color: AppTheme.getInstance().fillColor(),
                ),
              ),
              child: Center(
                child: Text(
                  S.current.reject_request,
                  style: textNormalCustom(
                    AppTheme.getInstance().fillColor(),
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
                    builder: (context) => LoanSendOffer(
                      cubit: cubit,
                      isCryptoElseNft: true,
                      detailCrypto: cubit.detailLoanRequestCryptoModel,
                    ),
                  ));
            },
            child: SizedBox(
              width: 159.w,
              child: ButtonGold(
                isEnable: true,
                fixSize: false,
                haveMargin: false,
                title: S.current.send_offer,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCrypto() {
    return Column(
      children: [
        _rowItem(
          title: S.current.status.capitalize().withColon(),
          description: Text(
            cubit.getStatus(cubit.detailLoanRequestCryptoModel.status ?? 0),
            style: textNormalCustom(
              cubit.getColor(cubit.detailLoanRequestCryptoModel.status ?? 0),
              16,
              FontWeight.w600,
            ),
          ),
        ),
        spaceH16,
        _rowItem(
          title: S.current.message.capitalize().withColon(),
          description: Text(
            cubit.detailLoanRequestCryptoModel.message ?? '',
            style: textNormalCustom(
              AppTheme.getInstance().whiteColor(),
              16,
              FontWeight.w600,
            ),
          ),
        ),
        spaceH16,
        _rowItem(
          title: S.current.collateral.capitalize().withColon(),
          description: Row(
            children: [
              SizedBox(
                width: 20.w,
                height: 20.h,
                child: Image.network(
                  ImageAssets.getUrlToken(
                      cubit.detailLoanRequestCryptoModel.collateralSymbol ??
                          'DFY'),
                ),
              ),
              spaceW4,
              Text(
                '${formatValue.format(cubit.detailLoanRequestCryptoModel.collateralAmount)} ${cubit.detailLoanRequestCryptoModel.collateralSymbol}',
                style: textNormalCustom(
                  AppTheme.getInstance().whiteColor(),
                  16,
                  FontWeight.w400,
                ),
              )
            ],
          ),
        ),
        spaceH16,
        _rowItem(
          title: 'Estimate:',
          description: Text(
            '~ \$${formatValue.format((cubit.detailLoanRequestCryptoModel.collateralAmount ?? 0) * (cubit.getExchangeUSD(symbolToken: cubit.detailLoanRequestCryptoModel.collateralSymbol ?? 'DFY')))}',
            style: textNormalCustom(
              AppTheme.getInstance().whiteColor(),
              16,
              FontWeight.w600,
            ),
          ),
        ),
        spaceH16,
        _rowItem(
          title: S.current.loan_token.capitalize().withColon(),
          description: Row(
            children: [
              SizedBox(
                width: 20.w,
                height: 20.h,
                child: Image.network(
                  ImageAssets.getUrlToken(
                      cubit.detailLoanRequestCryptoModel.loanSymbol ?? ''),
                ),
              ),
              spaceW4,
              Text(
                cubit.detailLoanRequestCryptoModel.loanSymbol ?? '',
                style: textNormalCustom(
                  AppTheme.getInstance().whiteColor(),
                  16,
                  FontWeight.w400,
                ),
              )
            ],
          ),
        ),
        spaceH16,
        _rowItem(
          title: S.current.duration.capitalize().withColon(),
          description: Text(
            cubit.categoryOneOrMany(
                durationQty:
                    cubit.detailLoanRequestCryptoModel.durationQty ?? 0,
                durationType:
                    cubit.detailLoanRequestCryptoModel.durationType ?? 0),
            style: textNormalCustom(
              AppTheme.getInstance().whiteColor(),
              16,
              FontWeight.w400,
            ),
          ),
        ),
        spaceH16,
        _rowItem(
          title: S.current.offer_sent.capitalize().withColon(),
          description: Text(
            '',
            style: textNormalCustom(
              AppTheme.getInstance().whiteColor(),
              16,
              FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget _rowItem({required String title, required Widget description}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title,
            style: textNormalCustom(
              AppTheme.getInstance().pawnItemGray(),
              16,
              FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: description,
        ),
      ],
    );
  }

  Container _borrowerInformation() {
    return Container(
      width: 343.w,
      padding: EdgeInsets.only(
        top: 12.h,
        left: 12.w,
        right: 12.w,
        bottom: 20.h,
      ),
      decoration: BoxDecoration(
        color: AppTheme.getInstance().borderItemColor(),
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
        border: Border.all(
          color: AppTheme.getInstance().divideColor(),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.current.borrower.toUpperCase(),
            style: textNormalCustom(
              AppTheme.getInstance().whiteColor(),
              20,
              FontWeight.w700,
            ),
          ),
          spaceH8,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  S.current.address.capitalize().withColon(),
                  style: textNormalCustom(
                    AppTheme.getInstance().getGray3(),
                    16,
                    FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ((cubit.reputationBorrower[0]).walletAddress ?? '')
                          .formatAddressWalletConfirm(),
                      style: textNormalCustom(
                        AppTheme.getInstance().blueColor(),
                        16,
                        FontWeight.w400,
                      ),
                    ),
                    spaceH8,
                    Row(
                      children: [
                        SizedBox(
                          height: 20.h,
                          width: 20.w,
                          child: Image.asset(ImageAssets.ic_star),
                        ),
                        spaceW5,
                        Text(
                          (cubit.reputationBorrower[0].reputationBorrower)
                              .toString(),
                          style: textNormalCustom(
                            AppTheme.getInstance().whiteColor(),
                            20,
                            FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          spaceH16,
          InkWell(
            onTap: () {
              goTo(
                context,
                OtherProfile(
                  userId:
                  cubit.reputationBorrower[0].userId.toString(),
                  index: 0,
                  pageRouter: PageRouter.MARKET,
                ),
              );
            },
            child: ButtonGold(
              title: S.current.view_profile.toUpperCase(),
              isEnable: true,
              fixSize: false,
            ),
          ),
        ],
      ),
    );
  }
}
