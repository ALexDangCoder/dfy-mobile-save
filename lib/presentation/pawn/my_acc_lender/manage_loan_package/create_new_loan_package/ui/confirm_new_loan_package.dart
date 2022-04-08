import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/lend_contract/ui/components/tab_crypto/lender_contract_crypto_item.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmNewLoanPackage extends StatefulWidget {
  const ConfirmNewLoanPackage({Key? key}) : super(key: key);

  @override
  _ConfirmNewLoanPackageState createState() => _ConfirmNewLoanPackageState();
}

final List<String> fakeToken = [
  'DFY',
  'BNB',
  'USDT',
  'DFY',
  'BNB',
];

class _ConfirmNewLoanPackageState extends State<ConfirmNewLoanPackage> {
  void closeKey() {
    final FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getInstance().blackColor(),
      resizeToAvoidBottomInset: false,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 812.h,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: AppTheme.getInstance().bgBtsColor(),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              GestureDetector(
                onTap: () {
                  closeKey();
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 64.h,
                      child: SizedBox(
                        height: 28.h,
                        width: 343.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 2,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: SizedBox(
                                  height: 30.h,
                                  width: 30.w,
                                  child: Image.asset(ImageAssets.ic_back),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 6,
                              child: Align(
                                child: Text(
                                  'Confirm new loan package',
                                  textAlign: TextAlign.center,
                                  style: titleText(
                                    color:
                                        AppTheme.getInstance().textThemeColor(),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: SizedBox(
                                height: 30.h,
                                width: 30.w,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: AppTheme.getInstance().divideColor(),
                    ),
                    spaceH24,
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                          ),
                          child: Column(
                            children: [
                              _rowItem(
                                  title: 'Type', description: 'Auto package'),
                              spaceH16,
                              _rowItem(
                                title: 'Message',
                                description:
                                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                              ),
                              spaceH16,
                              _rowItem(
                                title: 'Loan amount',
                                description: '',
                                isCustomDes: true,
                                widgetCustom: Row(
                                  children: [
                                    SizedBox(
                                      height: 20.h,
                                      width: 20.w,
                                      child: Image.network(
                                          ImageAssets.getUrlToken('DFY')),
                                    ),
                                    spaceW5,
                                    Text(
                                      '${formatPrice.format(1000)} - ${formatPrice.format(10000)} DFY',
                                      style: textNormalCustom(
                                        AppTheme.getInstance().whiteColor(),
                                        16,
                                        FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              spaceH16,
                              _collateralTokens(),
                              spaceH16,
                              _rowItem(
                                  title: 'Interest rate (%APR)',
                                  description: '10%'),
                              spaceH16,
                              _rowItem(
                                  title: 'Repayment token',
                                  description: '',
                                  isCustomDes: true,
                                  widgetCustom: Row(
                                    children: [
                                      SizedBox(
                                        width: 20.w,
                                        height: 20.h,
                                        child: Image.network(
                                            ImageAssets.getUrlToken('DFY')),
                                      ),
                                      spaceW5,
                                      Text('DFY', style: textNormalCustom(
                                        AppTheme.getInstance().whiteColor(),
                                        16,
                                        FontWeight.w400,
                                      ),),
                                    ],
                                  )),
                              spaceH16,
                              _rowItem(title: 'Duration', description: '1-3 months'),
                              spaceH16,
                              _rowItem(title: 'Loan to value', description: '15%'),
                              spaceH16,
                              _rowItem(title: 'LTV Liquidation threshold', description: '15%')
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Positioned(
              //   bottom: 0,
              //   child:
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Row _collateralTokens() {
    return _rowItem(
      title: 'Collateral',
      description: '',
      isCustomDes: true,
      widgetCustom: (fakeToken.length < 5)
          ? SizedBox(
              height: 20.h,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: fakeToken.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: Image.network(
                          ImageAssets.getUrlToken(
                            fakeToken[index],
                          ),
                        ),
                      ),
                      spaceW5,
                    ],
                  );
                },
              ),
            )
          : SizedBox(
              height: 20.h,
              child: Row(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          SizedBox(
                            height: 20.h,
                            width: 20.w,
                            child: Image.network(
                              ImageAssets.getUrlToken(
                                fakeToken[index],
                              ),
                            ),
                          ),
                          spaceW5,
                        ],
                      );
                    },
                  ),
                  Text(
                    '& ${fakeToken.length - 5} mores',
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Row _rowItem({
    required String title,
    required String description,
    bool? isCustomDes = false,
    Widget? widgetCustom,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title.withColon(),
            style: textNormalCustom(
              AppTheme.getInstance().pawnItemGray(),
              16,
              FontWeight.w400,
            ),
          ),
        ),
        if (isCustomDes ?? false)
          Expanded(flex: 6, child: widgetCustom ?? Container())
        else
          Expanded(
            flex: 6,
            child: Text(
              description,
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                16,
                FontWeight.w400,
              ),
            ),
          )
      ],
    );
  }
}
