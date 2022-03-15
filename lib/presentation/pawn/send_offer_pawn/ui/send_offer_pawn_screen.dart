import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/send_offer_pawn/bloc/send_offer_pawn_bloc.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common/info_popup.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendOfferPawnScreen extends StatefulWidget {
  const SendOfferPawnScreen({Key? key}) : super(key: key);

  @override
  _SendOfferPawnScreenState createState() => _SendOfferPawnScreenState();
}

class _SendOfferPawnScreenState extends State<SendOfferPawnScreen> {
  late SendOfferPawnBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = SendOfferPawnBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          spaceH8,
          BaseDesignScreen(
            title: S.current.send_offer,
            onRightClick: () {
              //todo
            },
            text: ImageAssets.ic_close,
            isImage: true,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(
                  16.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spaceH8,
                    Text(
                      S.current.message,
                      style: textNormalCustom(
                        null,
                        16,
                        FontWeight.w400,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    spaceH4,
                    //todo
                    spaceH16,
                    RichText(
                      text: TextSpan(
                        text: '',
                        style: textNormalCustom(
                          null,
                          16,
                          FontWeight.w400,
                        ),
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Text(
                              S.current.loan_to_value,
                              style: textNormalCustom(
                                null,
                                16,
                                FontWeight.w400,
                              ),
                            ),
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => InfoPopup(
                                    //todo
                                    name: S.current.total_contract_value,
                                    content: S.current.total_value_of_all,
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  left: 4.w,
                                ),
                                child: Image.asset(
                                  ImageAssets.img_waning,
                                  height: 20.w,
                                  width: 20.w,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    spaceH4,
                    //todo
                    spaceH16,
                    Text(
                      S.current.just_loan_amount,
                      style: textNormalCustom(
                        null,
                        16,
                        FontWeight.w400,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    spaceH4,
                    //todo
                    spaceH16,
                    Text(
                      S.current.liquidation_threshold,
                      style: textNormalCustom(
                        null,
                        16,
                        FontWeight.w400,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    spaceH4,
                    //todo
                    spaceH16,
                    Text(
                      S.current.interest_rate_apr,
                      style: textNormalCustom(
                        null,
                        16,
                        FontWeight.w400,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    spaceH4,
                    //todo
                    spaceH16,
                    Text(
                      S.current.duration,
                      style: textNormalCustom(
                        null,
                        16,
                        FontWeight.w400,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    spaceH4,
                    //todo
                    spaceH16,
                    Text(
                      S.current.repayment_token,
                      style: textNormalCustom(
                        null,
                        16,
                        FontWeight.w400,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    spaceH4,
                    //todo
                    spaceH16,
                    Text(
                      S.current.recurring_interest_pawn,
                      style: textNormalCustom(
                        null,
                        16,
                        FontWeight.w400,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    spaceH4,
                    //todo
                    spaceH16,
                    spaceH60,
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              //todo
            },
            child: Container(
              color: AppTheme.getInstance().bgBtsColor(),
              padding: EdgeInsets.only(
                bottom: 38.h,
              ),
              child: ButtonGold(
                isEnable: true,
                title: S.current.send_offer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
