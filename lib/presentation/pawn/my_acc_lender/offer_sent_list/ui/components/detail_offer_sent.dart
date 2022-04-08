import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/offer_sent_list/bloc/extension/offer_sent_crypto_cubit.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/offer_sent_list/bloc/offer_sent_list_cubit.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/offer_sent_list/ui/components/cancel_offer_sent.dart';
import 'package:Dfy/presentation/pawn/other_profile/ui/view_other_profile.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/utils/screen_controller.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:intl/intl.dart';

class DetailOfferSent extends StatefulWidget {
  const DetailOfferSent({
    Key? key,
    required this.cubit,
    required this.idGetDetail,
    this.isNFT = false,
  }) : super(key: key);
  final OfferSentListCubit cubit;
  final int idGetDetail;
  final bool? isNFT;

  @override
  _DetailOfferSentState createState() => _DetailOfferSentState();
}

class _DetailOfferSentState extends State<DetailOfferSent> {
  final formatValue = NumberFormat('###,###,###.###', 'en_US');

  @override
  void initState() {
    widget.cubit.callApiDetailCrypto(id: widget.idGetDetail.toString());
    super.initState();
  }

  // @override
  // void dispose() {
  //   widget.cubit.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OfferSentListCubit, OfferSentListState>(
      listener: (context, state) {
        if (state is GetApiDetalOfferSentCrypto) {
          if (state.completeType == CompleteType.SUCCESS) {
            widget.cubit.showContent();
          } else {
            widget.cubit.messageDetailCrypto = state.message ?? '';
            widget.cubit.showError();
          }
        }
      },
      bloc: widget.cubit,
      builder: (context, state) {
        return StateStreamLayout(
            stream: widget.cubit.stateStream,
            retry: () {
              widget.cubit
                  .callApiDetailCrypto(id: widget.idGetDetail.toString());
            },
            textEmpty: widget.cubit.messageDetailCrypto,
            error:
                AppException(S.current.error, widget.cubit.messageDetailCrypto),
            child: _content(state));
      },
    );
  }

  Widget _content(OfferSentListState state) {
    if (state is GetApiDetalOfferSentCrypto &&
        state.completeType == CompleteType.SUCCESS) {
      return RefreshIndicator(
        onRefresh: () async {
          await widget.cubit
              .callApiDetailCrypto(id: widget.idGetDetail.toString());
        },
        child: BaseDesignScreen(
          bottomBar: _btnCancelOffer(context),
          title: S.current.offer_detail.capitalize(),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                top: 24.h,
                left: 16.w,
                right: 16.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.current.offer_detail.toUpperCase(),
                    style: textNormalCustom(
                      AppTheme.getInstance().unselectedTabLabelColor(),
                      14,
                      FontWeight.w400,
                    ),
                  ),
                  spaceH16,
                  _rowItem(
                    title: S.current.offer_id.capitalize().withColon(),
                    description:
                        widget.cubit.offerSentDetailCrypto.offerId.toString(),
                  ),
                  spaceH16,
                  _rowItem(
                    title: S.current.status.capitalize().withColon(),
                    description: '',
                    isStatus: true,
                    status: widget.cubit.offerSentDetailCrypto.status,
                  ),
                  spaceH16,
                  _rowItem(
                    title: S.current.message.capitalize().withColon(),
                    description:
                        widget.cubit.offerSentDetailCrypto.description ?? '',
                  ),
                  spaceH16,
                  _rowItem(
                    title: S.current.loan_amount.capitalize(),
                    description: formatUSD.format(
                      widget.cubit.offerSentDetailCrypto.loanAmount,
                    ),
                    isLoanAmount: true,
                    urlToken:
                        widget.cubit.offerSentDetailCrypto.supplyCurrencySymbol,
                  ),
                  if (widget.isNFT ?? false) Container() else spaceH16,
                  if (widget.isNFT ?? false)
                    Container()
                  else
                    _rowItem(
                      title: S.current.loan_to_value.capitalize().withColon(),
                      description:
                          '${widget.cubit.offerSentDetailCrypto.loanToValue}%',
                    ),
                  spaceH16,
                  _rowItem(
                    title: S.current.interest_rate.capitalize(),
                    description:
                        '${widget.cubit.offerSentDetailCrypto.interestRate}%',
                  ),
                  if (widget.isNFT ?? false) Container() else spaceH16,
                  if (widget.isNFT ?? false)
                    Container()
                  else
                    _rowItem(
                      title: S.current.liquidation_threshold
                          .capitalize()
                          .withColon(),
                      description:
                          '${widget.cubit.offerSentDetailCrypto.liquidationThreshold}%',
                    ),
                  spaceH16,
                  _rowItem(
                    title: S.current.recurring_interest.capitalize(),
                    description:
                        widget.cubit.offerSentDetailCrypto.durationType == 0
                            ? S.current.week
                            : S.current.monday,
                  ),
                  spaceH16,
                  _rowItem(
                    title: S.current.repayment_token.capitalize().withColon(),
                    description: '',
                    isLoanAmountNoAmount: true,
                    urlToken: widget.cubit.offerSentDetailCrypto.repaymentToken,
                  ),
                  spaceH16,
                  _rowItem(
                    title: S.current.duration.capitalize().withColon(),
                    description: widget.cubit.categoryOneOrMany(
                        durationQty:
                            widget.cubit.offerSentDetailCrypto.durationQty ?? 0,
                        durationType:
                            widget.cubit.offerSentDetailCrypto.durationType ??
                                0),
                  ),
                  spaceH16,
                  _rowItem(
                    title: S.current.offer_create_day.capitalize().withColon(),
                    description: widget.cubit.convertMilisecondsToString(
                        widget.cubit.offerSentDetailCrypto.createdAt ?? 0),
                  ),
                  spaceH32,
                  Text(
                    S.current.collateral_information.toUpperCase(),
                    style: textNormalCustom(
                      AppTheme.getInstance().unselectedTabLabelColor(),
                      14,
                      FontWeight.w400,
                    ),
                  ),
                  spaceH16,
                  _borrowerInformation(widget.cubit),
                  spaceH32,
                  _rowItem(
                    title: S.current.message.capitalize().withColon(),
                    description: widget.cubit.offerSentDetailCryptoCollateral
                            .description ??
                        '',
                  ),
                  spaceH16,
                  _rowItem(
                    title: S.current.collateral.capitalize().withColon(),
                    description: (widget.isNFT ?? false)
                        ? 'Hard NFT'
                        : formatValue.format(widget.cubit
                            .offerSentDetailCryptoCollateral.collateralAmount),
                    urlToken: widget
                        .cubit.offerSentDetailCryptoCollateral.collateralSymbol,
                    isLoanAmount: true,
                  ),
                  if (widget.isNFT ?? false) Container() else spaceH16,
                  if (widget.isNFT ?? false)
                    _rowItem(
                      title: S.current.name_of_nft.capitalize().withColon(),
                      description:
                          '${widget.cubit.offerSentDetailCryptoCollateral}',
                    )
                  else
                    _rowItem(
                      title: S.current.estimate.capitalize().withColon(),
                      description:
                          '~ ${widget.cubit.offerSentDetailCryptoCollateral.estimatePrice}',
                    ),
                  spaceH16,
                  _rowItem(
                    title: S.current.loan_token.capitalize().withColon(),
                    isLoanAmountNoAmount: true,
                    urlToken:
                        widget.cubit.offerSentDetailCryptoCollateral.loanSymbol,
                    description: '',
                  ),
                  spaceH16,
                  _rowItem(
                    title: S.current.duration.capitalize().withColon(),
                    description: widget.cubit.categoryOneOrMany(
                        durationQty: widget.cubit
                                .offerSentDetailCryptoCollateral.durationQty ??
                            0,
                        durationType: widget.cubit
                                .offerSentDetailCryptoCollateral.durationType ??
                            0),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Container(
        color: AppTheme.getInstance().bgBtsColor(),
        child: Center(
          child: CircularProgressIndicator(
            color: AppTheme.getInstance().whiteColor(),
            strokeWidth: 2,
          ),
        ),
      );
    }
  }

  Widget _btnCancelOffer(BuildContext ctx) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => CancelOfferSent(),
          ),
        );
      },
      child: Container(
        color: AppTheme.getInstance().bgBtsColor(),
        padding: EdgeInsets.only(
          bottom: 38.h,
          left: 16.w,
          right: 16.w,
        ),
        child: Container(
          height: 64.h,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30.0)),
            // color: AppTheme.getInstance().bgBtsColor(),
            border: Border.all(color: AppTheme.getInstance().fillColor()),
          ),
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: Text(
                S.current.cancel_offer,
                style: textNormalCustom(
                  AppTheme.getInstance().fillColor(),
                  20,
                  FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _borrowerInformation(OfferSentListCubit cubit) {
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
                      (cubit.offerSentDetailCryptoCollateral.walletAddress ??
                              '')
                          .formatAddress(index: 6),
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
                          cubit.offerSentDetailCryptoCollateral.reputation
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
                      cubit.offerSentDetailCryptoCollateral.userId.toString(),
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

  Row _rowItem({
    int? status,
    String? urlToken,
    required String title,
    bool isLoanAmount = false,
    bool isStatus = false,
    bool isLoanAmountNoAmount = false,
    bool isEstimate = false,
    required String description,
  }) {
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
        if (isLoanAmount)
          Expanded(
            flex: 6,
            child: Row(
              children: [
                SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child:
                      Image.network(ImageAssets.getUrlToken(urlToken ?? DFY)),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  '$description $urlToken',
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    16,
                    FontWeight.w400,
                  ),
                ),
              ],
            ),
          )
        else if (isStatus)
          Expanded(
            flex: 6,
            child: Text(
              OfferSentCryptoExtension.categoryStatus(status ?? 0), //todo
              style: textNormalCustom(
                OfferSentCryptoExtension.getStatusColor(
                    status ?? OfferSentCryptoExtension.PROCESSING_CREATE),
                16,
                FontWeight.w400,
              ),
            ),
          )
        else if (isEstimate)
          Expanded(
            flex: 6,
            child: Text(
              '~ \$$description',
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                16,
                FontWeight.w400,
              ),
            ),
          )
        else if (isLoanAmountNoAmount)
          Expanded(
            flex: 6,
            child: Row(
              children: [
                SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child:
                      Image.network(ImageAssets.getUrlToken(urlToken ?? DFY)),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  urlToken ?? '',
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    16,
                    FontWeight.w400,
                  ),
                ),
              ],
            ),
          )
        else
          Expanded(
            flex: 6,
            child: Text(
              description,
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                16,
                FontWeight.w400,
              ),
            ),
          )
      ],
    );
  }
}
