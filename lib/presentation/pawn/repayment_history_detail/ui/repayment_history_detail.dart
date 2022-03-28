import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/offer_detail/ui/offer_detail_my_acc.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'item_repayment.dart';

class RepaymentHistoryDetail extends StatefulWidget {
  const RepaymentHistoryDetail({Key? key}) : super(key: key);

  @override
  _RepaymentHistoryDetailState createState() => _RepaymentHistoryDetailState();
}

class _RepaymentHistoryDetailState extends State<RepaymentHistoryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 812.h,
          decoration: BoxDecoration(
            color: AppTheme.getInstance().bgBtsColor(),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.h),
              topRight: Radius.circular(30.h),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spaceH16,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: 16.w,
                    ),
                    width: 24.w,
                    height: 24.h,
                  ),
                  SizedBox(
                    width: 250.w,
                    child: Text(
                      S.current.repayment_history_detail,
                      style: textNormalCustom(
                        null,
                        20.sp,
                        FontWeight.w700,
                      ).copyWith(
                        overflow: TextOverflow.ellipsis,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 16.w),
                      width: 24.w,
                      height: 24.h,
                      child: Image.asset(ImageAssets.ic_close),
                    ),
                  ),
                ],
              ),
              spaceH20,
              line,
              spaceH12,
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      spaceH12,
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 10,
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              ItemRepaymentHistory(),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            line,
                            spaceH20,
                            Text(
                              S.current.total,
                              style: textNormalCustom(
                                null,
                                20,
                                FontWeight.w600,
                              ),
                            ),
                            spaceH16,
                            richText(
                              title: '${S.current.penalty}:',
                              value: 'DFY 3.9',
                              isIcon: true,
                              url: ImageAssets.getUrlToken('DFY'),
                            ),
                            spaceH16,
                            richText(
                              title: '${S.current.interest}:',
                              value: 'DFY 3.9',
                            ),
                            spaceH16,
                            richText(
                              title: '${S.current.loan}:',
                              value: 'DFY 3.9',
                            ),
                            spaceH70,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
