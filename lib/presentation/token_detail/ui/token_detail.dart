import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/receive_token/ui/bts_receive_dfy.dart';
import 'package:Dfy/presentation/send_token_nft/ui/send_token/send_token.dart';
import 'package:Dfy/presentation/token_detail/bloc/token_detail_bloc.dart';
import 'package:Dfy/presentation/token_detail/ui/transaction_list.dart';
import 'package:Dfy/presentation/transaction_submit/transaction_submit.dart';
import 'package:Dfy/utils/animate/custom_rect_tween.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/enum_ext.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:Dfy/widgets/views/default_sub_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TokenDetail extends StatelessWidget {
  final int tokenData;
  final TokenDetailBloc bloc;
  final EnumTokenType tokenType;
  final bool isSubmitting;

  const TokenDetail({
    Key? key,
    required this.tokenData,
    required this.bloc,
    required this.tokenType,
    this.isSubmitting = false,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    bloc.checkData();
    final title = tokenType.nameToken;
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
                  child:
                      sizedSvgImage(w: 54, h: 54, image: tokenType.imageToken),
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
                  onTap: () {},
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

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("My title"),
      content: Text("This is my message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  Center popMenu() => Center(
    child: Hero(
      tag: '',
      createRectTween: (begin, end) {
        return CustomRectTween(begin: begin!, end: end!);
      },
      child: buildBlur(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: AppTheme.getInstance().bgBtsColor(),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: const TransactionSubmit(),
        ),
      ),
    ),
  );

  Widget buildBlur({
    required Widget child,
    BorderRadius borderRadius = BorderRadius.zero,
    double sigmaX = 4,
    double sigmaY = 4,
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
