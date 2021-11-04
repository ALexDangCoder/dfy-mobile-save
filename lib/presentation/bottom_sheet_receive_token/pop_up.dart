import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/presentation/bottom_sheet_receive_token/custom_rect_tween.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/form/item_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopUp extends StatelessWidget {
  const PopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: 'add-todo-hero',
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin!, end: end!);
        },
        child: Material(
          color: const Color(0xff585782),
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
          child: SizedBox(
            width: 312.w,
            height: 225.h,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 20.h,
                    right: 20.w,
                    left: 20.w,
                    bottom: 20.h,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Set amount',
                          style: textNormal(
                            null,
                            20.sp,
                          ).copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      ItemForm(
                        leadPath: ImageAssets.show,
                        hint: 'all',
                        trailingPath: ImageAssets.show,
                        formType: FormType.PASSWORD,
                        isShow: true,
                        controller: TextEditingController(),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Color'),
                    VerticalDivider(
                      color: Colors.white,
                      width: 30.h,
                    ),
                    Text('Color'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
