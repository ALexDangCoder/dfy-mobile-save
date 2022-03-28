import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/offer_detail/ui/offer_detail_my_acc.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common/info_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContractInfo extends StatefulWidget {
  const ContractInfo({Key? key}) : super(key: key);

  @override
  _ContractInfoState createState() => _ContractInfoState();
}

class _ContractInfoState extends State<ContractInfo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          spaceH24,
          richText(
            title: '${S.current.contract_id}:',
            value: 'value',
          ),
          spaceH16,
          richText(
            title: '${S.current.defaults} '
                '${S.current.date.toLowerCase()}:',
            value: 'value',
          ),
          spaceH16,
          richText(
            title: '${S.current.status}:',
            value: 'value',
            myColor: Colors.red,
          ),
          spaceH16,
          richText(
            title: '${S.current.interest_rate_pawn}:',
            value: 'value%',
          ),
          spaceH16,
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
                    ImageAssets.getSymbolAsset(
                      'DFY',
                    ),
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
                    '100 DFY',
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
                      //todo
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
          ),
          spaceH16,
          richText(
            title: '${S.current.total_estimate}:',
            value: '~\$value',
          ),
          spaceH16,
          richText(
            title: S.current.loan_amount,
            value: 'value',
          ),
          spaceH16,
          richText(
            title: '${S.current.estimate}:',
            value: '~\$value',
          ),
          spaceH16,
          richText(
            title: '${S.current.repayment_token}:',
            value: 'value',
            url: ImageAssets.getUrlToken('DFY'),
            isIcon: true,
          ),
          spaceH16,
          richText(
            title: '${S.current.recurring_interest_pawn}:',
            value: 'value',
          ),
          spaceH16,
          richText(
            title: '${S.current.from}:',
            value: 'value',
          ),
          spaceH16,
          richText(
            title: '${S.current.to}:',
            value: 'value',
          ),
          spaceH16,
          richText(
            isSOS: true,
            onClick: () {
              print('----------------');
              showDialog(
                context: context,
                builder: (_) => InfoPopup(
                  name: S.current.loan_to_value,
                  content: S.current.loan_to_value,
                ),
              ); //todo
            },
            title: '${S.current.loan_to_value}:',
            value: 'value',
          ),
          spaceH16,
          richText(
            isSOS: true,
            onClick: () {
              showDialog(
                context: context,
                builder: (_) => InfoPopup(
                  name: S.current.ltv_liquid_thres,
                  content: S.current.ltv_liquid_thres,
                ),
              ); //todo
            },
            title: S.current.ltv_liquid_thres,
            value: 'value',
          ),
          spaceH16,
          richText(
            title: '${S.current.system_risk}:',
            value: 'value',
          ),
          spaceH16,
          richText(
            title: '${S.current.default_reason}:',
            value: 'value',
          ),
          spaceH152,
        ],
      ),
    );
  }
}
