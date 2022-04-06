import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TypeFilter { HIGH_TO_LOW, LOW_TO_HIGH }

class DialogFilter extends StatefulWidget {
  final String title;
  final TypeFilter type;

  const DialogFilter({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);

  @override
  _DialogFilterState createState() => _DialogFilterState();
}

class _DialogFilterState extends State<DialogFilter> {
  late TypeFilter _type;

  @override
  void initState() {
    super.initState();
    _type = widget.type;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
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
                    width: 28.w,
                    height: 28.h,
                  ),
                  Text(
                    widget.title,
                    style: textNormalCustom(
                      null,
                      20.sp,
                      FontWeight.w700,
                    ).copyWith(
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
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
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Row(
                  children: [
                    SizedBox(
                      width: 24.w,
                      height: 24.h,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor:
                              AppTheme.getInstance().whiteColor(),
                        ),
                        child: Radio<TypeFilter>(
                          value: TypeFilter.LOW_TO_HIGH,
                          activeColor: AppTheme.getInstance().fillColor(),
                          groupValue: _type,
                          onChanged: (TypeFilter? value) {
                            setState(() {
                              _type = value ?? TypeFilter.LOW_TO_HIGH;
                              Navigator.pop(context, _type);
                            });
                          },
                        ),
                      ),
                    ),
                    spaceW4,
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _type = TypeFilter.LOW_TO_HIGH;
                          Navigator.pop(context, _type);
                        });
                      },
                      child: Text(
                        S.current.low_to_high,
                        style: textNormalCustom(
                          null,
                          16,
                          null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              spaceH20,
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Row(
                  children: [
                    SizedBox(
                      width: 24.w,
                      height: 24.h,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor:
                              AppTheme.getInstance().whiteColor(),
                        ),
                        child: Radio<TypeFilter>(
                          value: TypeFilter.HIGH_TO_LOW,
                          activeColor: AppTheme.getInstance().fillColor(),
                          groupValue: _type,
                          onChanged: (TypeFilter? value) {
                            setState(() {
                              _type = value ?? TypeFilter.HIGH_TO_LOW;
                              Navigator.pop(context, _type);
                            });
                          },
                        ),
                      ),
                    ),
                    spaceW4,
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _type = TypeFilter.HIGH_TO_LOW;
                          Navigator.pop(context, _type);
                        });
                      },
                      child: Text(
                        S.current.high_to_low,
                        style: textNormalCustom(
                          null,
                          16,
                          null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
