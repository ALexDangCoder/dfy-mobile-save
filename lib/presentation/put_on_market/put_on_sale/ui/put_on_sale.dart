import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PutOnSale extends StatefulWidget {
  const PutOnSale({Key? key}) : super(key: key);

  @override
  _PutOnSaleState createState() => _PutOnSaleState();
}

class _PutOnSaleState extends State<PutOnSale> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          final FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          margin: const EdgeInsets.only(top: 48),
          decoration: BoxDecoration(
            color: AppTheme.getInstance().bgBtsColor(),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              header(),
              Divider(
                thickness: 1,
                color: AppTheme.getInstance().divideColor(),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                '${S.current.sale_items} :',
                                style: textNormal(
                                  AppTheme.getInstance()
                                      .whiteColor()
                                      .withOpacity(0.7),
                                  14.sp,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Text(
                                " 1 of 5",
                                style: textNormal(
                                  AppTheme.getInstance().whiteColor(),
                                  16.sp,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                '${S.current.price_per_1} :',
                                style: textNormal(
                                  AppTheme.getInstance()
                                      .whiteColor()
                                      .withOpacity(0.7),
                                  14.sp,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Text(
                                '150,000 DFY',
                                style: textNormalCustom(
                                    AppTheme.getInstance().fillColor(),
                                    20.sp,
                                    FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                        const SizedBox (height : 19 ),
                        RichText(
                          text:  TextSpan(
                              text:
                                  'Listing is free. The the time of the sale, ',
                              style: textNormal(
                                AppTheme.getInstance()
                                    .whiteColor()
                                    .withOpacity(0.7),
                                14.sp,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '2.5%',
                                  style:  textNormal(
                                    AppTheme.getInstance()
                                        .failTransactionColors()
                                        .withOpacity(0.7),
                                    14.sp,
                                  ),
                                ),
                                TextSpan(
                                  text: ' value of each copy will be deducted',
                                  style:  textNormal(
                                    AppTheme.getInstance()
                                        .whiteColor()
                                        .withOpacity(0.7),
                                    14.sp,
                                  ),
                                ),

                              ]),
                        ),
                        const SizedBox (height : 20),
                        Divider(
                          thickness: 1,
                          color: AppTheme.getInstance().divideColor(),
                        ),
                        const SizedBox (height : 16),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      child: ButtonGold(
                        title: S.current.continue_s,
                        isEnable: false,
                        fixSize: false,
                      ),
                      onTap: () {},
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      child: ButtonGold(
                        fixSize: false,
                        title: S.current.continue_s,
                        isEnable: true,
                      ),
                      onTap: () {},
                    ),
                  )
                ],
              ),
              const SizedBox(height: 38)
            ],
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Container(
      height: 40,
      // height: 28.h,
      margin: const EdgeInsets.only(
        top: 16,
        // bottom: 20.h,
        left: 16,
        right: 16,
      ),
      // EdgeInsets.only(left: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(ImageAssets.ic_back),
          ),

          // Text(
          //   S.current.put_on_sale,
          //   style: textNormal(AppTheme.getInstance().textThemeColor(), 20.sp)
          //       .copyWith(fontWeight: FontWeight.w700),
          // )
        ],
      ),
    );
  }
}
