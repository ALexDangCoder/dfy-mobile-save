import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/bloc/provide_hard_nft_info/provide_hard_nft_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormAddProperties extends StatefulWidget {
  const FormAddProperties({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final ProvideHardNftCubit cubit;

  @override
  _FormAddPropertiesState createState() => _FormAddPropertiesState();
}

class _FormAddPropertiesState extends State<FormAddProperties> {
  String property = '';
  String valueForm = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 312.w,
            padding: EdgeInsets.only(
              top: 21.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(36.r),
                topLeft: Radius.circular(36.r),
              ),
              color: AppTheme.getInstance().bgTranSubmit(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 26.w),
                  child: Text(
                    S.current.add_more_properties,
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      24,
                      FontWeight.w700,
                    ),
                  ),
                ),
                spaceH20,
                Container(
                  padding: EdgeInsets.only(left: 26.w),
                  child: Text(
                    S.current.description_add_properties,
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                ),
                spaceH20,
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.getInstance().bgBtsColor(),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.r),
                    ),
                  ),
                  margin:
                      EdgeInsets.only(bottom: 18.h, left: 20.w, right: 20.w),
                  padding: EdgeInsets.only(
                    top: 6.h,
                    bottom: 6.h,
                    left: 13.w,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        initialValue: property,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if ((value ?? '').length > 30) {
                            return S.current.maximum_30;
                          }
                          return null;
                        },
                        onChanged: (value) {
                          property = value;
                        },
                        cursorColor: AppTheme.getInstance().textThemeColor(),
                        style: textNormal(
                          AppTheme.getInstance().textThemeColor(),
                          16.sp,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: S.current.properties,
                          hintStyle: textNormalCustom(
                            AppTheme.getInstance().whiteOpacityDot5(),
                            16,
                            FontWeight.w400,
                          ),
                          contentPadding: EdgeInsets.only(
                            top: 10.h,
                            bottom: 10.h,
                          ),
                          filled: true,
                        ),
                      ),
                      Container(
                        width: 248.w,
                        height: 1,
                        color: AppTheme.getInstance().divideColor(),
                      ),
                      TextFormField(
                        initialValue: valueForm,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if ((value ?? '').length > 30) {
                            return S.current.maximum_30;
                          }
                          return null;
                        },
                        onChanged: (value) {
                          valueForm = value;
                        },
                        cursorColor: AppTheme.getInstance().textThemeColor(),
                        style: textNormal(
                          AppTheme.getInstance().textThemeColor(),
                          16.sp,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: S.current.value,
                          hintStyle: textNormalCustom(
                            AppTheme.getInstance().whiteOpacityDot5(),
                            16,
                            FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 312.w,
            height: 1.h,
            color: AppTheme.getInstance().whiteOpacityDot5(),
          ),
          //btn cancel and save
          Container(
            height: 65.h,
            width: 312.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36.r),
                bottomRight: Radius.circular(36.r),
              ),
              color: AppTheme.getInstance().bgTranSubmit(),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        S.current.cancel,
                        style: textNormalCustom(
                          AppTheme.getInstance().whiteColor(),
                          20,
                          FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1.w,
                  height: 65.h,
                  color: AppTheme.getInstance().whiteOpacityDot5(),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      widget.cubit.checkPropertiesWhenSave(
                        value: valueForm,
                        property: property,
                      );
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        S.current.save,
                        style: textNormalCustom(
                          AppTheme.getInstance().fillColor(),
                          20,
                          FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
