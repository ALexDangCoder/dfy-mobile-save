import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/bottom_sheet_receive_token/ui/bts_receive_dfy.dart';
import 'package:Dfy/presentation/send_token_nft/ui/send_token/send_token.dart';
import 'package:Dfy/presentation/token_detail/bloc/token_detail_bloc.dart';
import 'package:Dfy/presentation/token_detail/ui/transaction_list.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:Dfy/widgets/views/default_sub_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TokenDetail extends StatelessWidget {
  final int tokenData;
  final TokenDetailBloc bloc;
  final String title;

  const TokenDetail({
    Key? key,
    required this.tokenData,
    required this.bloc,
    required this.title,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    bloc.checkData();
    return DefaultSubScreen(
      title: title,
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
                    child: Image.asset(
                      ImageAssets.symbol,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Text(
                  customCurrency(
                    amount: '5157.415478951',
                    type: title,
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
                  onTap: () {
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
          TransactionList(title: title, bloc: bloc)
        ],
      ),
    );
  }
}
