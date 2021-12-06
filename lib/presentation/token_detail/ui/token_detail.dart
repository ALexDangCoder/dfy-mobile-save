import 'dart:developer';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/token_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/receive_token/ui/bts_receive_dfy.dart';
import 'package:Dfy/presentation/send_token_nft/ui/send_token/send_token.dart';
import 'package:Dfy/presentation/token_detail/bloc/token_detail_bloc.dart';
import 'package:Dfy/presentation/token_detail/ui/transaction_list.dart';
import 'package:Dfy/presentation/transaction_submit/transaction_submit.dart';
import 'package:Dfy/presentation/wallet/ui/custom_tween.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:Dfy/widgets/views/default_sub_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TokenDetail extends StatelessWidget {
  final ModelToken token;
  final TokenDetailBloc bloc;

  const TokenDetail({
    Key? key,
    required this.bloc,
    required this.token,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    bloc.getHistory();
    return Stack(
      alignment: Alignment.center,
      children: [
        DefaultSubScreen(
          title: token.nameShortToken,
          mainWidget: Column(
            children: [
              Container(
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
                        child: Image.memory(token.iconToken),
                      ),
                    ),
                    Text(
                      customCurrency(
                        amount: token.balanceToken.toString(),
                        type: token.nameShortToken,
                        digit: 8,
                      ),
                      style: tokenDetailAmount(
                        color: AppTheme.getInstance().textThemeColor(),
                      ),
                    ),
                    Text(
                      customCurrency(
                        amount: (token.balanceToken * 0.2).toString(),
                        type: '\$',
                        digit: 2,
                      ),
                      style: tokenDetailAmount(
                        color:
                            AppTheme.getInstance().currencyDetailTokenColor(),
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
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return const Receive(
                                    walletAddress: 'afafafa',
                                    type: TokenType.DFY,
                                  );
                                },
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
                                builder: (context) {
                                  return const SendToken();
                                },
                              ).then((value) => {
                                log('>>>>>>>>>>>>>>>>>>> $value')
                              },);
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
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
              TransactionList(shortName: token.nameShortToken, bloc: bloc)
            ],
          ),
        ),
        StreamBuilder<bool>(
          stream: bloc.showLoadingStream,
          initialData: false,
          builder: (context, snapshot) {
            return Visibility(
              visible: snapshot.data ?? false,
              child: popMenu(),
            );
          },
        ),
      ],
    );
  }

  Widget popMenu() => Scaffold(
        backgroundColor: Colors.white.withOpacity(0.15),
        body: Center(
          child: Hero(
            tag: '',
            createRectTween: (begin, end) {
              return CustomRectTween(begin: begin!, end: end!);
            },
            child: buildBlur(
              borderRadius: BorderRadius.circular(20.r),
              child: Material(
                color: AppTheme.getInstance().bgBtsColor(),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: const TransactionSubmit(),
              ),
            ),
          ),
        ),
      );

  Widget buildBlur({
    required Widget child,
    BorderRadius borderRadius = BorderRadius.zero,
    double sigmaX = 5,
    double sigmaY = 5,
  }) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: sigmaX,
          sigmaY: sigmaY,
        ),
        child: child,
      ),
    );
  }
}
