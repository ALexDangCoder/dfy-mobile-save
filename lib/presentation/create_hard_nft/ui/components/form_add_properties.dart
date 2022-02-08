import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
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
  late List<Widget> _listForm;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    _listForm = [
      FormProperties(
        cubit: widget.cubit,
        index: 0,
      ),
    ];
  }

  void _addFormWidget() {
    setState(() {
      _listForm.add(
        FormProperties(
          cubit: widget.cubit,
          index: _listForm.length + 1,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
                  'Add properties',
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
                  'Properties provide more information \nabout your hard NFT. This field will be \ndisplayed tab description',
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
                  itemCount: _listForm.length,
                  itemBuilder: (context, index) {
                    return _listForm[index];
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
                        'Add more',
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
                  child: Text(
                    'Cancel',
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      20,
                      FontWeight.w700,
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
                    // widget.cubit.properties.clear();
                    print(widget.cubit.properties);
                  },
                  child: Center(
                    child: Text(
                      'Save',
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
    );
  }

  Container form() {
    return Container(
      width: 272.w,
      height: 116.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Center(child: Text('huy')),
    );
  }
}
