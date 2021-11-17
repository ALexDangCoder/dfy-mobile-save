import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/transaction.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/token_detail/bloc/token_detail_bloc.dart';
import 'package:Dfy/presentation/token_detail/ui/transaction_detail.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionList extends StatelessWidget {
  final String title;
  final TokenDetailBloc bloc;
  final int tokenData;

  const TransactionList({
    Key? key,
    required this.title,
    required this.bloc,
    this.tokenData = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Transaction>>(
      initialData: const [],
      stream: bloc.transactionListStream,
      builder: (context, snapshot) {
        if (snapshot.data?.isNotEmpty ?? false) {
          final dataLen = snapshot.data?.length ?? 0;
          final snapData = snapshot.data;
          return Expanded(
            child: Scrollbar(
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: dataLen * 70.h,
                      ),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: dataLen,
                        itemBuilder: (context, index) {
                          return transactionRow(
                            context: context,
                            transaction: snapData?[index] ?? Transaction.init(),
                          );
                        },
                      ),
                    ),
                    StreamBuilder<bool>(
                      initialData: false,
                      stream: bloc.showMoreStream,
                      builder: (ctx, snapshot) {
                        final isShow = snapshot.data!;
                        return Visibility(
                          visible: isShow,
                          child: InkWell(
                            onTap: () {
                              bloc.showMore();
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                right: 16.w,
                                left: 16.w,
                              ),
                              height: 69.h,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppTheme.getInstance().divideColor(),
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    ImageAssets.ic_expanded,
                                    color: AppTheme.getInstance().fillColor(),
                                  ),
                                  SizedBox(
                                    width: 13.15.w,
                                  ),
                                  Text(
                                    S.current.view_more,
                                    style: textNormalCustom(
                                      AppTheme.getInstance().fillColor(),
                                      16,
                                      FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  sizedPngImage(
                    w: 94,
                    h: 94,
                    image: ImageAssets.icNoTransaction,
                  ),
                  Text(
                    S.current.no_transaction,
                    style: tokenDetailAmount(
                      color: AppTheme.getInstance().currencyDetailTokenColor(),
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget transactionRow({
    required BuildContext context,
    required Transaction transaction,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppTheme.getInstance().divideColor(),
          ),
        ),
      ),
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return TransactionDetail(
                transaction: transaction,
              );
            },
          );
        },
        child: Container(
          height: 69.h,
          padding: EdgeInsets.only(
            top: 14.h,
            left: 16.h,
            right: 16.h,
            bottom: 12.h,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      transaction.title,
                      style: tokenDetailAmount(
                        color: AppTheme.getInstance().whiteColor(),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  sizedSvgImage(
                    w: 20,
                    h: 20,
                    image: transaction.status.statusImage,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: transactionAmountText(
                        status:
                            transaction.status,
                        amount: transaction.amount,
                        type: transaction.type,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                children: [
                  Text(
                    transaction.time.stringFromDateTime,
                    style: tokenDetailAmount(
                      color: AppTheme.getInstance().currencyDetailTokenColor(),
                      fontSize: 14,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Text transactionAmountText({
    required int amount,
    required TransactionType type,
    required TransactionStatus status,
  }) {
    switch (status) {
      case TransactionStatus.FAILED:
        return Text(
          '0 $title',
          style: tokenDetailAmount(
            color: AppTheme.getInstance().currencyDetailTokenColor(),
            fontSize: 16,
            weight: FontWeight.w400,
          ),
        );
      case TransactionStatus.SUCCESS:
        return Text(
          type == TransactionType.RECEIVE
              ? '+ $amount $title'
              : '- $amount $title',
          style: tokenDetailAmount(
            color: type == TransactionType.RECEIVE
                ? AppTheme.getInstance().successTransactionColors()
                : AppTheme.getInstance().currencyDetailTokenColor(),
            fontSize: 16,
            weight: FontWeight.w400,
          ),
        );
      case TransactionStatus.PENDING:
        return Text(
          '$amount $title',
          style: tokenDetailAmount(
            color: AppTheme.getInstance().currencyDetailTokenColor(),
            fontSize: 16,
            weight: FontWeight.w400,
          ),
        );
    }
  }
}
