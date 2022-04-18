import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/offer_sent_list/bloc/extension/offer_sent_crypto_cubit.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/offer_sent_list/bloc/offer_sent_list_cubit.dart';
import 'package:Dfy/presentation/pawn/other_profile/ui/view_other_profile.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/pop_up_notification.dart';
import 'package:Dfy/utils/screen_controller.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/dialog/cupertino_loading.dart';
import 'package:Dfy/widgets/dialog/modal_progress_hud.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:get/get.dart';
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
          title: 'Offer detail',
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
                    title: 'Offer ID:',
                    description:
                        widget.cubit.offerSentDetailCrypto.offerId.toString(),
                  ),
                  spaceH16,
                  _rowItem(
                    title: 'Status:',
                    description: '',
                    isStatus: true,
                    status: widget.cubit.offerSentDetailCrypto.status,
                  ),
                  spaceH16,
                  _rowItem(
                    title: 'Message:',
                    description:
                        widget.cubit.offerSentDetailCrypto.description ?? '',
                  ),
                  spaceH16,
                  _rowItem(
                    title: 'Loan amount',
                    description: formatPrice.format(
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
                      title: 'Loan to value:',
                      description:
                          '${widget.cubit.offerSentDetailCrypto.loanToValue}%',
                    ),
                  spaceH16,
                  _rowItem(
                    title: 'Interest rate (%APR):',
                    description:
                        '${widget.cubit.offerSentDetailCrypto.interestRate}%',
                  ),
                  if (widget.isNFT ?? false) Container() else spaceH16,
                  if (widget.isNFT ?? false)
                    Container()
                  else
                    _rowItem(
                      title: 'Liquidation threshold:',
                      description:
                          '${widget.cubit.offerSentDetailCrypto.liquidationThreshold}%',
                    ),
                  spaceH16,
                  _rowItem(
                    title: 'Recurring interest:',
                    description:
                        widget.cubit.offerSentDetailCrypto.durationType == 0
                            ? S.current.week
                            : S.current.monday,
                  ),
                  spaceH16,
                  _rowItem(
                    title: 'Repayment token:',
                    description: '',
                    isLoanAmountNoAmount: true,
                    urlToken: widget.cubit.offerSentDetailCrypto.repaymentToken,
                  ),
                  spaceH16,
                  _rowItem(
                    title: 'Duration:',
                    description: widget.cubit.categoryOneOrMany(
                        durationQty:
                            widget.cubit.offerSentDetailCrypto.durationQty ?? 0,
                        durationType:
                            widget.cubit.offerSentDetailCrypto.durationType ??
                                0),
                  ),
                  spaceH16,
                  _rowItem(
                    title: 'Offer created day:',
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
                  // spaceH16,
                  // _borrowerInformation(widget.cubit),
                  spaceH32,
                  _rowItem(
                    title: 'Message:',
                    description: widget.cubit.offerSentDetailCryptoCollateral
                            .description ??
                        '',
                  ),
                  spaceH16,
                  _rowItem(
                    title: 'Collateral:',
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
                      title: 'Name of NFT:',
                      description:
                          '${widget.cubit.offerSentDetailCryptoCollateral}',
                    )
                  else
                    _rowItem(
                      title: 'Estimate',
                      description:
                          '~ ${widget.cubit.offerSentDetailCryptoCollateral.estimatePrice}',
                    ),
                  spaceH16,
                  _rowItem(
                    title: 'Loan token:',
                    isLoanAmountNoAmount: true,
                    urlToken:
                        widget.cubit.offerSentDetailCryptoCollateral.loanSymbol,
                    description: '',
                  ),
                  spaceH16,
                  _rowItem(
                    title: 'Duration:',
                    description: widget.cubit.categoryOneOrMany(
                        durationQty: widget.cubit
                                .offerSentDetailCryptoCollateral.durationQty ??
                            0,
                        durationType: widget.cubit
                                .offerSentDetailCryptoCollateral.durationType ??
                            0),
                  ),
                  spaceH46,
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return ModalProgressHUD(
        inAsyncCall: true,
        progressIndicator: CupertinoLoading(),
        child: SizedBox(),
      );
    }
  }

  Widget? _btnCancelOffer(BuildContext ctx) {
    return ((widget.cubit.offerSentDetailCrypto.status ?? 1) == 3)
        ? InkWell(
            onTap: () async {
              final hexString = await Web3Utils().getCancelCryptoOfferData(
                nftCollateralId: widget
                    .cubit.offerSentDetailCrypto.bcCollateralId
                    .toString(),
                offerId:
                    widget.cubit.offerSentDetailCrypto.bcOfferId.toString(),
              );

              goTo(
                  context,
                  Approve(
                    title: 'Confirm cancel offer',
                    spender: Get.find<AppConstants>().crypto_pawn_contract,
                    textActiveButton: 'Confirm',
                    hexString: hexString,
                    header: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        spaceH24,
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                S.current.loan_amount,
                                style: textNormalCustom(
                                  AppTheme.getInstance()
                                      .whiteWithOpacitySevenZero(),
                                  16,
                                  FontWeight.w400,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Row(
                                children: [
                                  SizedBox(
                                      height: 20.h,
                                      width: 20.w,
                                      child: Image.network(
                                          ImageAssets.getUrlToken(widget
                                                  .cubit
                                                  .offerSentDetailCrypto
                                                  .supplyCurrencySymbol ??
                                              'DFY'))),
                                  spaceW8,
                                  Text(
                                    formatPrice.format(
                                      widget.cubit.offerSentDetailCrypto
                                          .loanAmount,
                                    ),
                                    style: textNormalCustom(
                                      AppTheme.getInstance().whiteColor(),
                                      16,
                                      FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        spaceH32,
                        Text(
                          S.current.description_cancel_offer_sent,
                          style: textNormalCustom(
                            AppTheme.getInstance().whiteColor(),
                            16,
                            FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    onSuccessSign: (context, data) async {
                      Navigator.pop(context);
                      await widget.cubit.putCryptoAfterConfirmBlockChain(
                          id: widget.cubit.offerSentDetailCrypto.offerId
                              .toString());
                      await showLoadSuccess(context).then(
                        (value) {
                          Navigator.pop(context, true);
                          Navigator.pop(context, true);
                        },
                      ).then((value) => widget.cubit
                          .refreshGetListOfferSentCrypto(
                              type: (widget.isNFT ?? false) ? '1' : '0'));
                    },
                    onErrorSign: (context) async {
                      final nav = Navigator.of(context);
                      nav.pop();
                      await showLoadFail(context);
                    },
                  ),);
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     spaceH24,
              //     Row(
              //       children: [
              //         Expanded(
              //           flex: 2,
              //           child: Text(
              //             S.current.loan_amount,
              //             style: textNormalCustom(
              //               AppTheme.getInstance().whiteWithOpacitySevenZero(),
              //               16,
              //               FontWeight.w400,
              //             ),
              //           ),
              //         ),
              //         Expanded(
              //           flex: 4,
              //           child: Row(
              //             children: [
              //               SizedBox(
              //                   height: 20.h,
              //                   width: 20.w,
              //                   child: Image.network(ImageAssets.getUrlToken(
              //                       model.supplyCurrencySymbol ?? 'DFY'))),
              //               spaceW8,
              //               Text(
              //                 formatPrice.format(
              //                   model.loanAmount,
              //                 ),
              //                 style: textNormalCustom(
              //                   AppTheme.getInstance().whiteColor(),
              //                   16,
              //                   FontWeight.w400,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         )
              //       ],
              //     ),
              //     spaceH32,
              //     Text(
              //       S.current.description_cancel_offer_sent,
              //       style: textNormalCustom(
              //         AppTheme.getInstance().whiteColor(),
              //         16,
              //         FontWeight.w400,
              //       ),
              //     )
              //   ],
              // )

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (ctx) => CancelOfferSent(
              //       model: widget.cubit.offerSentDetailCrypto,
              //       cubit: widget.cubit,
              //     ),
              //   ),
              // );
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
          )
        : null;
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
                  'Address:',
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
