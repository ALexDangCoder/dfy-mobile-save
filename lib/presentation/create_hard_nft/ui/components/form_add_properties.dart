import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/bloc/provide_hard_nft_info/provide_hard_nft_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/components/form_properties.dart';
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
  @override
  void initState() {
    super.initState();
    if (widget.cubit.propertiesData.isEmpty) {
      widget.cubit.propertiesData.add(
        PropertyModel(value: '', property: ''),
      );
    } else {}
  }

  void _addFormWidget() {
    setState(() {
      widget.cubit.propertiesData.add(
        PropertyModel(value: '', property: ''),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 333.h,
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
                    S.current.add,
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
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cubit.propertiesData.length,
                    itemBuilder: (context, index) {
                      return FormProperties(
                        data: widget.cubit.propertiesData[index],
                        cubit: widget.cubit,
                      );
                    },
                  ),
                ),
                spaceH18,
                Container(
                  padding: EdgeInsets.only(left: 26.w),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: Image.asset(
                          ImageAssets.addFormProperties,
                        ),
                      ),
                      spaceW6,
                      InkWell(
                        onTap: _addFormWidget,
                        child: Text(
                          S.current.add_more,
                          style: textNormalCustom(
                            AppTheme.getInstance().fillColor(),
                            16,
                            FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                spaceH24,
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
                      widget.cubit.checkPropertiesWhenSave();
                      widget.cubit.dataStep1.properties =
                          widget.cubit.propertiesData;
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
