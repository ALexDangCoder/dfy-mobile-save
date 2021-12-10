import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/import_account/bloc/import_cubit.dart';
import 'package:Dfy/presentation/restore_account/bloc/restore_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum FormType { PASS_PHRASE, PASSWORD, PRIVATE_KEY, AMOUNT }
enum PassType { NEW, CON }

class ItemForm extends StatelessWidget {
  const ItemForm({
    Key? key,
    required this.prefix,
    required this.hint,
    required this.suffix,
    required this.formType,
    this.callback,
    required this.isShow,
    required this.controller,
    this.cubit,
    this.passType,
    this.importCubit,
  }) : super(key: key);
  final String prefix;
  final String hint;
  final String suffix;
  final FormType formType;
  final Function()? callback;
  final bool isShow;
  final TextEditingController controller;
  final RestoreCubit? cubit;
  final ImportCubit? importCubit;
  final PassType? passType;

  @override
  Widget build(BuildContext context) {
    if (formType == FormType.PASS_PHRASE) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 64.h,
        ),
        child: Container(
          width: 343.w,
          padding: EdgeInsets.only(
            top: 10.h,
            bottom: 10.h,
            //right: 12.w,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20.r),
            ),
            color: AppTheme.getInstance().itemBtsColors(),
          ),
          child: TextFormField(
            controller: controller,
            style: textNormal(
              Colors.white,
              16,
            ),
            textAlignVertical: TextAlignVertical.center,
            onChanged: (value) {
              cubit?.showTxtWarningSeed(value, FormType.PASS_PHRASE);
              importCubit?.showTxtWarningSeed(value, FormType.PASS_PHRASE);
            },
            minLines: 1,
            maxLines: 10,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: textNormal(
                Colors.grey,
                16,
              ),
              suffixIcon: InkWell(
                onTap: callback,
                child: Padding(
                  padding: EdgeInsets.only(top: 13.h),
                  child: Text(
                    S.current.paste,
                    style: textNormal(AppTheme.getInstance().fillColor(), 16)
                        .copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              prefixIcon: ImageIcon(
                AssetImage(prefix),
                color: Colors.white,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      );
    } else if (formType == FormType.PRIVATE_KEY) {
      return Container(
        height: 64.h,
        width: 343.w,
        padding: EdgeInsets.only(
          top: 10.h,
          bottom: 12.h,
          //right: 10.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20.r),
          ),
          color: AppTheme.getInstance().itemBtsColors(),
        ),
        child: TextFormField(
          controller: controller,
          obscureText: isShow,
          textAlignVertical: TextAlignVertical.center,
          style: textNormal(
            Colors.white,
            16,
          ),
          onChanged: (value) {
            cubit?.showTxtWarningSeed(value, FormType.PRIVATE_KEY);
            importCubit?.showTxtWarningSeed(value, FormType.PRIVATE_KEY);
          },
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: textNormal(
              Colors.grey,
              16,
            ),
            suffixIcon: InkWell(
              onTap: callback,
              child: Padding(
                padding: EdgeInsets.only(top: 13.h),
                child: Text(
                  suffix,
                  style: textNormal(AppTheme.getInstance().fillColor(), 16)
                      .copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            prefixIcon: ImageIcon(
              AssetImage(prefix),
              color: Colors.white,
            ),
            border: InputBorder.none,
          ),
        ),
      );
    } else if (formType == FormType.AMOUNT) {
      return Container(
        height: 64.h,
        width: 343.w,
        padding: EdgeInsets.only(
          top: 12.h,
          bottom: 12.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20.r),
          ),
          color: AppTheme.getInstance().itemBtsColors(),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                controller: controller,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'(^\-?\d*\.?\d*)'))
                ],
                style: textNormal(
                  Colors.white,
                  16,
                ),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: textNormal(
                    Colors.grey,
                    16,
                  ),
                  suffixIcon: InkWell(
                    onTap: callback,
                    child: Padding(
                       padding: EdgeInsets.only(top: 10.h),
                      child: Text(
                        suffix,
                        style: textNormal(
                          Colors.grey,
                          16,
                        ),
                      ),
                    ),
                  ),
                  prefixIcon: ImageIcon(
                    AssetImage(prefix),
                    color: Colors.white,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        height: 64.h,
        width: 343.w,
        padding: EdgeInsets.only(
          top: 10.h,
          bottom: 12.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20.r),
          ),
          color: AppTheme.getInstance().itemBtsColors(),
        ),
        child: TextFormField(
          controller: controller,
          obscureText: isShow,
          textAlignVertical: TextAlignVertical.center,
          style: textNormal(
            Colors.white,
            16,
          ),
          onChanged: passType == PassType.CON
              ? (value) {
                  //cubit?.checkHaveValueConfirmPW(value);
                  cubit?.showTxtWarningConfirmPW(value,
                      newPW: cubit?.newPassword ?? '');
                }
              : (value) {
                  //cubit?.checkHaveValuePW(value);
                  cubit?.showTxtWarningNewPW(value);
                },
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: textNormal(
              Colors.grey,
              16,
            ),
            suffixIcon: InkWell(
              onTap: callback,
              child: ImageIcon(
                AssetImage(suffix),
                color: Colors.grey,
              ),
            ),
            prefixIcon: ImageIcon(
              AssetImage(prefix),
              color: Colors.white,
            ),
            border: InputBorder.none,
          ),
        ),
      );
    }
  }
}
