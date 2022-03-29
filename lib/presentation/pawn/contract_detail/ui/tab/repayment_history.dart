import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/contract_detail/bloc/contract_detail_bloc.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../item_repayment.dart';

class RepaymentHistory extends StatefulWidget {
  const RepaymentHistory({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final ContractDetailBloc bloc;

  @override
  _RepaymentHistoryState createState() => _RepaymentHistoryState();
}

class _RepaymentHistoryState extends State<RepaymentHistory> with AutomaticKeepAliveClientMixin {
  Widget itemList(
    String title,
    String money,
    Color color,
  ) {
    return Container(
      width: 151.w,
      height: 121.h,
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.only(
        top: 8.h,
        left: 12.w,
        bottom: 15.h,
      ),
      margin: EdgeInsets.only(
        right: 16.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(16.r),
        ),
        border: Border.all(
          color: color,
          width: 1,
        ),
        image: const DecorationImage(
          image: AssetImage(
            ImageAssets.imgMoneyPawn,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: textNormalCustom(
              null,
              14,
              FontWeight.w600,
            ),
          ),
          Text(
            '\$$money',
            maxLines: 1,
            style: textNormalCustom(
              null,
              18,
              FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          spaceH20,
          SizedBox(
            height: 121.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                itemList(
                  S.current.total_loan,
                  formatPrice.format(
                    widget.bloc.objRepayment?.totalLoan ?? 0,
                  ),
                  AppTheme.getInstance().greenMarketColors(),
                ),
                itemList(
                  S.current.total_paid,
                  formatPrice.format(
                    widget.bloc.objRepayment?.totalPaid ?? 0,
                  ),
                  AppTheme.getInstance().blueColor(),
                ),
                itemList(
                  S.current.total_unpaid,
                  formatPrice.format(
                    widget.bloc.objRepayment?.totalUnpaid ?? 0,
                  ),
                  AppTheme.getInstance().redColor(),
                ),
              ],
            ),
          ),
          spaceH32,
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.bloc.listRequest.length,
            itemBuilder: (context, index) => ItemRepayment(
              obj: widget.bloc.listRequest[index],
              index: index + 1,
              bloc: widget.bloc,
            ),
          ),
          spaceH152,
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
