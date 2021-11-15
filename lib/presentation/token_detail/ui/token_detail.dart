import 'dart:developer';
import 'dart:math' hide log;

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/token_detail/bloc/token_detail_bloc.dart';
import 'package:Dfy/presentation/token_detail/ui/transaction_detail.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/views/default_sub_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TokenDetail extends StatelessWidget {
  final int tokenData;
  final TokenDetailBloc bloc;
  final String title;

  const TokenDetail(
      {Key? key,
      required this.tokenData,
      required this.bloc,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bloc.checkData();
    return DefaultSubScreen(
      title: title,
      mainWidget: Column(
        children: [
          SizedBox(
            height: 308.h,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 24.h,
                    bottom: 8.h,
                  ),
                  child: SizedBox(
                    height: 54.h,
                    width: 54.h,
                    child: Image.asset(
                      ImageAssets.symbol,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Text(
                  customCurrency(
                    amount: '5157.415478951',
                    type: 'DFY',
                    digit: 8,
                  ),
                  style: tokenDetailAmount(
                    color: AppTheme.getInstance().textThemeColor(),
                  ),
                ),
                Text(
                  customCurrency(
                    amount: '5157.415478951',
                    type: '\$',
                    digit: 2,
                  ),
                  style: tokenDetailAmount(
                    color: AppTheme.getInstance().currencyDetailTokenColor(),
                    weight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 24.h,
                    bottom: 28.h,
                    left: 115.h,
                    right: 115.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          log('On Receive Token Tap');
                        },
                        child: sizedPngImage(
                          w: 48,
                          h: 48,
                          image: ImageAssets.btnReceiveToken,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          log('On Send Token Tap');
                        },
                        child: sizedPngImage(
                          w: 48,
                          h: 48,
                          image: ImageAssets.btnSendToken,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    log('On tap Create Collateral');
                  },
                  child: Container(
                    height: 48.h,
                    width: 210.h,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      border: Border.all(
                        color: AppTheme.getInstance().fillColor(),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        S.current.create_collateral,
                        style: tokenDetailAmount(
                          color: AppTheme.getInstance().fillColor(),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: AppTheme.getInstance().divideColor(),
          ),
          StreamBuilder<List<String>>(
            initialData: const [],
            stream: bloc.transactionListStream,
            builder: (context, snapshot) {
              if (snapshot.data?.isNotEmpty ?? false) {
                final dataLen = snapshot.data?.length ?? 0;
                return Expanded(
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      physics: const ScrollPhysics(),
                      child: Column(
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: dataLen * 66.h,
                            ),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: dataLen,
                              itemBuilder: (context, index) {
                                return transactionRow(
                                  context: context,
                                  transactionTitle: bloc.mockData[index],
                                  time: bloc.mockDate[index],
                                  status: bloc.mockStatus[index],
                                  amount: bloc.mockAmount[index],
                                  type: bloc.mockType[index],
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
                                    height: 60.h,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          color: AppTheme.getInstance()
                                              .divideColor(),
                                        ),
                                        bottom: BorderSide(
                                          color: AppTheme.getInstance()
                                              .divideColor(),
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          ImageAssets.expand,
                                          color: AppTheme.getInstance()
                                              .fillColor(),
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
                            color: AppTheme.getInstance()
                                .currencyDetailTokenColor(),
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget transactionRow({
    required BuildContext context,
    required String transactionTitle,
    required DateTime time,
    required TransactionStatus status,
    required TransactionType type,
    required int amount,
  }) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return TransactionDetail(
                detailTransaction: tokenData == 1 ? '158.2578' : '13.25',
                amount: amount,
                status: status,
              );
            },
          ),
        );
      },
      child: Container(
        height: 66.h,
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
                    transactionTitle,
                    style: tokenDetailAmount(
                      color: AppTheme.getInstance().whiteColor(),
                      fontSize: 16,
                    ),
                  ),
                ),
                sizedPngImage(
                  w: 20,
                  h: 20,
                  image: status.statusImage,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topRight,
                    child: transactionAmountText(
                      status: status,
                      amount: amount,
                      type: type,
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
                  time.stringFromDateTime,
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

  Widget sizedPngImage({
    required double w,
    required double h,
    required String image,
  }) {
    return SizedBox(
      height: h.h,
      width: w.h,
      child: Image.asset(
        image,
        fit: BoxFit.fill,
      ),
    );
  }
}
