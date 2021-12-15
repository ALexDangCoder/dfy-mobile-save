import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/model_token.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/receive_token/ui/receive_token.dart';
import 'package:Dfy/presentation/send_token_nft/ui/send_token/send_token.dart';
import 'package:Dfy/presentation/token_detail/bloc/token_detail_bloc.dart';
import 'package:Dfy/presentation/token_detail/ui/transaction_list.dart';
import 'package:Dfy/presentation/transaction_submit/transaction_submit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/blur_popup/blur_overlay.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TokenDetail extends StatelessWidget {
  final ModelToken token;
  final TokenDetailBloc bloc;
  final String walletAddress;

  const TokenDetail({
    Key? key,
    required this.bloc,
    required this.token,
    required this.walletAddress,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    bloc.getToken(token);
    return StreamBuilder<bool>(
      stream: bloc.showLoadingStream,
      initialData: false,
      builder: (context, snapshot) {
        final isShow = snapshot.data ?? false;
        if (isShow) {
          bloc.getHistory(token.tokenAddress);
          return Blur(
            blur: 1,
            colorOpacity: 0.1,
            overlay: const TransactionSubmit(),
            child: bottomSheet(context),
          );
        } else {
          bloc.getHistory(token.tokenAddress);
          return bottomSheet(context);
        }
      },
    );
  }

  Widget bottomSheet(BuildContext context) {
    return StreamBuilder<ModelToken>(
      stream: bloc.tokenStream,
      builder: (context, snapshot) {
        final modelToken = snapshot.data ?? token;
        return BaseBottomSheet(
          title: modelToken.nameShortToken,
          child: Column(
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  await bloc.getToken(token);
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Container(
                    height: 308.h,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppTheme.getInstance().divideColor(),
                        ),
                      ),
                    ),
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
                            child: Image.network(modelToken.iconToken),
                          ),
                        ),
                        Text(
                          customCurrency(
                            amount: modelToken.balanceToken.toString(),
                            type: modelToken.nameShortToken,
                            digit: 8,
                          ),
                          style: tokenDetailAmount(
                            color: AppTheme.getInstance().textThemeColor(),
                          ),
                        ),
                        Text(
                          customCurrency(
                            amount: (modelToken.balanceToken *
                                    modelToken.exchangeRate)
                                .toString(),
                            type: '\$',
                            digit: 2,
                          ),
                          style: tokenDetailAmount(
                            color: AppTheme.getInstance()
                                .currencyDetailTokenColor(),
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Receive(
                                        walletAddress: walletAddress,
                                        type: TokenType.DFY,
                                        nameToken: modelToken.nameToken,
                                        symbol: modelToken.nameShortToken,
                                        price: modelToken.exchangeRate,
                                      ),
                                    ),
                                  );
                                },
                                child: sizedSvgImage(
                                  w: 48,
                                  h: 48,
                                  image: ImageAssets.ic_btn_receive_token_svg,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (_) {
                                      return SendToken(
                                        walletAddress: walletAddress,
                                      );
                                    },
                                  ).then(
                                    (value) => {
                                      if (value)
                                        bloc.checkShowLoading()
                                      else
                                        null
                                    },
                                  );
                                },
                                child: sizedSvgImage(
                                  w: 48,
                                  h: 48,
                                  image: ImageAssets.ic_btn_send_token_svg,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 48.h,
                            width: 210.h,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(16),
                              ),
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
                ),
              ),
              TransactionList(
                shortName: modelToken.nameShortToken,
                bloc: bloc,
              ),
            ],
          ),
        );
      },
    );
  }
}
