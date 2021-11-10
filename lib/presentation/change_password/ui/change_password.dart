import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/change_password/ui/components/form_setup_password.dart';
import 'package:Dfy/presentation/change_password/ui/components/header_change_password.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Container(
        width: 375.w,
        height: 764.h,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(62, 61, 92, 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
        ),
        child: Column(
          children: [
            headerChangePW(
              callBack: () {},
            ),
            const Divider(
              thickness: 1,
              color: Color.fromRGBO(255, 255, 255, 0.1),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 24.h,
                    ),
                    formSetupPassWord(
                      controller: TextEditingController(),
                      hintText: S.current.old_password,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    formSetupPassWord(
                      controller: TextEditingController(),
                      hintText: S.current.new_pass,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    formSetupPassWord(
                      controller: TextEditingController(),
                      hintText: S.current.confirm_new_password,
                    ),

                    SizedBox(
                      height: 349.h,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: ButtonGold(
                title: S.current.continue_s,
                isEnable: true,
              ),
              onTap: () {},
            ),
            SizedBox(
              height: 38.h,
            ),
          ],
        ),
      ),
    );
  }
}
