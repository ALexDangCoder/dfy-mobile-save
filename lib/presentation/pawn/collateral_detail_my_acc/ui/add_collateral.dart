import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'item_add_collateral.dart';

class AddCollateral extends StatefulWidget {
  const AddCollateral({Key? key}) : super(key: key);

  @override
  _AddCollateralState createState() => _AddCollateralState();
}

class _AddCollateralState extends State<AddCollateral> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 764.h,
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
                      S.current.added_collateral,
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
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                    top: 16.h,
                  ),
                  itemBuilder: (context, index) {
                    return ItemAddCollateral();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
