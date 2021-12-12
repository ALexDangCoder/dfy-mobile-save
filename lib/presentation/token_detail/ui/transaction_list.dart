import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/web3/model/transaction.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/token_detail/bloc/token_detail_bloc.dart';
import 'package:Dfy/presentation/token_detail/ui/transaction_detail.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionList extends StatelessWidget {
  final String shortName;
  final TokenDetailBloc bloc;

  const TransactionList({
    Key? key,
    required this.shortName,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TransactionHistory>>(
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
                        maxHeight: dataLen * 67.08.h,
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: dataLen,
                        itemBuilder: (context, index) {
                          return transactionRow(
                            context: context,
                            transaction:
                                snapData?[index] ?? TransactionHistory.init(),
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
    required TransactionHistory transaction,
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return TransactionHistoryDetailScreen(
                  bloc: bloc,
                  thxID: 'a',
                  status: transaction.status ?? '',
                );
              },
            ),
          );
        },
        child: Container(
          height: 66.h,
          padding: EdgeInsets.only(
            top: 12.h,
            left: 16.h,
            right: 16.h,
          ),
          child: Column(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    transaction.name ?? '',
                    style: tokenDetailAmount(
                      color: AppTheme.getInstance().whiteColor(),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  sizedSvgImage(
                    w: 20,
                    h: 20,
                    image: getImgStatus(transaction.status ?? ''),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: transactionAmountText(
                        status: transaction.status ?? '',
                        amount: transaction.amount ?? 0,
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
                    DateTime.parse(transaction.dateTime ?? '')
                        .stringFromDateTime,
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
    required double amount,
    required String status,
  }) {
    switch (status) {
      case 'fail':
        return Text(
          '0 $shortName',
          style: tokenDetailAmount(
            color: AppTheme.getInstance().currencyDetailTokenColor(),
            fontSize: 16,
          ),
        );
      case 'success':
        return Text(
          '$amount $shortName',
          style: tokenDetailAmount(
            color: (amount > 0)
                ? AppTheme.getInstance().successTransactionColors()
                : AppTheme.getInstance().currencyDetailTokenColor(),
            fontSize: 16,
          ),
        );
      default:
        return Text(
          '$amount $shortName',
          style: tokenDetailAmount(
            color: AppTheme.getInstance().currencyDetailTokenColor(),
            fontSize: 16,
          ),
        );
    }
  }

  String getImgStatus(String status) {
    switch (status) {
      case 'success':
        return ImageAssets.ic_transaction_success_svg;
      case 'fail':
        return ImageAssets.ic_transaction_fail_svg;
      default:
        return ImageAssets.ic_transaction_pending_svg;
    }
  }
}
