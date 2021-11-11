import 'dart:developer';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/token_detail/bloc/token_detail_bloc.dart';
import 'package:Dfy/presentation/token_detail/ui/transaction_detail.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/views/default_sub_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TokenDetail extends StatelessWidget {
  final int tokenData;
  final TokenDetailBloc bloc;

  const TokenDetail({Key? key, required this.tokenData, required this.bloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultSubScreen(
      title: 'DFY',
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
                      amount: '5157.415478951', type: 'DFY', digit: 8,),
                  style: tokenDetailAmount(
                    color: AppTheme.getInstance().textThemeColor(),
                  ),
                ),
                Text(
                  customCurrency(
                      amount: '5157.415478951', type: '\$', digit: 2,),
                  style: tokenDetailAmount(
                    color: AppTheme.getInstance().currencyDetailTokenColor(),
                    weight: FontWeight.w400,
                    fontSize: 16.h,
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
                          fontSize: 16.h,
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
                return Container();
              } else {
                return Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        sizedPngImage(
                          w: 94,
                          h: 94,
                          image: ImageAssets.icNoTransaction,),
                        Text(
                          S.current.no_transaction,
                          style: tokenDetailAmount(
                            color: AppTheme.getInstance()
                                .currencyDetailTokenColor(),
                            fontSize: 20,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return TransactionDetail(
                                    detailTransaction:
                                    tokenData == 1 ? '158.2578' : '13.25',
                                  );
                                },
                              ),
                            );
                          },
                          child: const Text('Click'),
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

  Widget sizedPngImage({
    required double w,
    required double h,
    required String image,
  }) {
    return SizedBox(
      height: w.h,
      width: w.h,
      child: Image.asset(
        image,
        fit: BoxFit.fill,
      ),
    );
  }
}
