import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/pawn/contract_detail_pawn.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/add_collateral_list/ui/add_collateral.dart';
import 'package:Dfy/presentation/pawn/contract_detail/bloc/contract_detail_bloc.dart';
import 'package:Dfy/presentation/pawn/contract_detail/ui/contract_detail.dart';
import 'package:Dfy/presentation/pawn/offer_detail/ui/offer_detail_my_acc.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/int_extension.dart';
import 'package:Dfy/widgets/common/info_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContractInfo extends StatefulWidget {
  const ContractInfo({
    Key? key,
    required this.bloc,
  }) : super(key: key);
  final ContractDetailBloc bloc;

  @override
  _ContractInfoState createState() => _ContractInfoState();
}

class _ContractInfoState extends State<ContractInfo>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final obj = widget.bloc.objDetail ?? ContractDetailPawn.name();
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spaceH24,
          richText(
            title: '${S.current.contract_id}:',
            value: obj.id.toString(),
          ),
          if (obj.status == ContractDetailBloc.DEFAULT)
            spaceH16
          else
            const SizedBox.shrink(),
          if (obj.status == ContractDetailBloc.DEFAULT)
            richText(
              title: '${S.current.defaults} '
                  '${S.current.date.toLowerCase()}:',
              value: 0.formatHourMyPawn(obj.defaultDate ?? 0),
            )
          else
            const SizedBox.shrink(),
          spaceH16,
          richText(
            title: '${S.current.status}:',
            value: widget.bloc.getStatus(obj.status ?? 0),
            myColor: widget.bloc.getColor(obj.status ?? 0),
          ),
          spaceH16,
          richText(
            title: '${S.current.interest_rate_pawn}:',
            value: '${obj.contractTerm?.interestRate.toString() ?? '0'}%',
          ),
          spaceH16,
          if (widget.bloc.type == TypeBorrow.CRYPTO_TYPE)
            RichText(
              text: TextSpan(
                text: '',
                style: textNormalCustom(
                  AppTheme.getInstance().getGray3(),
                  16.sp,
                  FontWeight.w400,
                ),
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Text(
                      '${S.current.collateral}:  ',
                      style: textNormalCustom(
                        AppTheme.getInstance().getGray3(),
                        16.sp,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Image.network(
                      obj.cryptoCollateral?.cryptoAsset?.iconUrl.toString() ??
                          '',
                      width: 16.sp,
                      height: 16.sp,
                      errorBuilder: (
                        context,
                        error,
                        stackTrace,
                      ) =>
                          Container(
                        color: AppTheme.getInstance().bgBtsColor(),
                        width: 16.sp,
                        height: 16.sp,
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
                      '${formatPrice.format(
                        obj.cryptoCollateral?.amount ?? 0,
                      )}  ${obj.cryptoCollateral?.cryptoAsset?.symbol.toString().toUpperCase() ?? ''}',
                      style: textNormalCustom(
                        null,
                        16,
                        FontWeight.w400,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: SizedBox(
                      width: 16.w,
                    ),
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddCollateral(
                              estimate: formatPrice.format(
                                obj.cryptoCollateral?.estimateUsdAmount ?? 0,
                              ),
                              id: obj.cryptoCollateral?.id.toString() ?? '',
                            ),
                          ),
                        );
                      },
                      child: Text(
                        '${S.current.view_all}➞',
                        style: textNormalCustom(
                          AppTheme.getInstance().fillColor(),
                          16,
                          FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            RichText(
              text: TextSpan(
                text: '',
                style: textNormalCustom(
                  AppTheme.getInstance().getGray3(),
                  16.sp,
                  FontWeight.w400,
                ),
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Text(
                      '${S.current.collateral}:  ',
                      style: textNormalCustom(
                        AppTheme.getInstance().getGray3(),
                        16.sp,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Image.asset(
                      ImageAssets.ic_hard,
                      width: 16.sp,
                      height: 16.sp,
                      errorBuilder: (
                        context,
                        error,
                        stackTrace,
                      ) =>
                          Container(
                        color: AppTheme.getInstance().bgBtsColor(),
                        width: 16.sp,
                        height: 16.sp,
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
                      (obj.nft?.nftType ?? 0) == SOFT_NFT
                          ? S.current.soft_nft
                          : S.current.hard_NFT,
                      style: textNormalCustom(
                        null,
                        16,
                        FontWeight.w400,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
          spaceH16,
          richText(
            title: '${S.current.total_estimate}:',
            value: '~\$${formatPrice.format(
              obj.cryptoCollateral?.estimateUsdAmount ?? 0,
            )}',
          ),
          spaceH16,
          richText(
            title: S.current.loan_amount,
            value: formatPrice.format(
              obj.remainingLoan ?? 0,
            ),
          ),
          spaceH16,
          richText(
            title: '${S.current.estimate}:',
            value: '~\$${formatPrice.format(
              obj.contractTerm?.estimateUsdLoanAmount ?? 0,
            )}',
          ),
          spaceH16,
          richText(
            title: '${S.current.repayment_token}:',
            value:
                obj.contractTerm?.repaymentCryptoAsset?.symbol.toString() ?? '',
            url: obj.contractTerm?.repaymentCryptoAsset?.iconUrl.toString() ??
                '',
            isIcon: true,
          ),
          spaceH16,
          richText(
            title: '${S.current.recurring_interest_pawn}:',
            value: (obj.contractTerm?.durationType ?? 0) == WEEK
                ? S.current.weekly_pawn
                : S.current.months_pawn,
          ),
          spaceH16,
          richText(
            title: '${S.current.from}:',
            value: 0.formatDateTimeMyGTM(obj.startDate ?? 0),
          ),
          spaceH16,
          richText(
            title: '${S.current.to}:',
            value: 0.formatDateTimeMyGTM(obj.endDate ?? 0),
          ),
          spaceH16,
          richText(
            isSOS: true,
            onClick: () {
              showDialog(
                context: context,
                builder: (_) => InfoPopup(
                  name: S.current.loan_to_value,
                  content: S.current.mess_loan_to_value,
                ),
              );
            },
            title: '${S.current.loan_to_value}:',
            value: '${obj.loanToValue}%',
          ),
          spaceH16,
          richText(
            isSOS: true,
            onClick: () {
              showDialog(
                context: context,
                builder: (_) => InfoPopup(
                  name: S.current.ltv_liquidation_threshold,
                  content: S.current.ltv_liquid_thres,
                ),
              ); //todo
            },
            title: S.current.ltv_liquid_thres,
            value: '${obj.liquidationType}%',
          ),
          spaceH16,
          RichText(
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
                    '${S.current.system_risk}:',
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
                TextSpan(
                  text: S.current.borrower,
                  style: textNormalCustom(
                    null,
                    16.sp,
                    FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text:
                      ' ${obj.contractTerm?.systemRisk ?? 2} ${S.current.tow_times}',
                  style: textNormalCustom(
                    AppTheme.getInstance().redColor(),
                    16.sp,
                    FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: S.current.late_payment_From,
                  style: textNormalCustom(
                    null,
                    16.sp,
                    FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: ((obj.contractTerm?.systemRisk ?? 2) + 1).toString() +
                      S.current.rd_time,
                  style: textNormalCustom(
                    AppTheme.getInstance().redColor(),
                    16.sp,
                    FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: S.current.the_collateral_will_be_liquidated,
                  style: textNormalCustom(
                    null,
                    16.sp,
                    FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          spaceH16,
          if (obj.status == ContractDetailBloc.DEFAULT)
            richText(
              title: '${S.current.default_reason}:',
              value: obj.defaultReason.toString(),
            )
          else
            const SizedBox.shrink(),
          spaceH152,
        ],
      ),
    );
  }
}
