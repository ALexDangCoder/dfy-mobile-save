import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/di/module.dart';
import 'package:Dfy/presentation/create_wallet_first_time/setup_password/bloc/check_pass_cubit.dart';
import 'package:Dfy/presentation/create_wallet_first_time/setup_password/helper/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetupPassWord extends StatefulWidget {
  const SetupPassWord({Key? key}) : super(key: key);

  @override
  _SetupPassWordState createState() => _SetupPassWordState();
}

class _SetupPassWordState extends State<SetupPassWord> {
  late CheckPassCubit isValidPassCubit;

  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  int index = 1;

  @override
  void initState() {
    isValidPassCubit = CheckPassCubit();
    super.initState();
  }

  @override
  void dispose() {
    isValidPassCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          header(),
          const Divider(
            thickness: 1,
            color: Color.fromRGBO(255, 255, 255, 0.1),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  textShowSetupPass(),
                  SizedBox(
                    height: 28.h,
                  ),
                  formSetupPassWord(
                    hintText: 'New password',
                  ),
                  showTextValidatePassword(),
                  SizedBox(
                    height: 16.h,
                  ),
                  formSetupPassWordConfirm(
                    hintText: 'Confirm password',
                  ),
                  showTextValidateMatchPassword(),
                  SizedBox(
                    height: 25.h,
                  ),
                  ckcBoxAndTextSetupPass(),
                  SizedBox(
                    height: 256.h,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            child: btnContinue(),
            onTap: () {
              isValidPassCubit.isValidate(password.text);
              isValidPassCubit.isMatchPW(
                  password: password.text, confirmPW: confirmPassword.text);
            },
          ),
          SizedBox(
            height: 38.h,
          )
        ],
      ),
    );
  }

  Widget showTextValidatePassword() {
    return StreamBuilder(
      stream: isValidPassCubit.validatePWStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return Visibility(
          visible: snapshot.data ?? false,
          child: Column(
            children: [
              SizedBox(
                height: 4.h,
              ),
              SizedBox(
                width: 323.w,
                height: 30.h,
                child: Text(
                  'Password must include at least a number, '
                  'an upper case, a lower\n case and a special '
                  'character',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromRGBO(255, 108, 108, 1),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget showTextValidateMatchPassword() {
    return StreamBuilder(
      stream: isValidPassCubit.matchPWStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Visibility(
          visible: snapshot.data ?? false,
          child: Column(
            children: [
              SizedBox(
                height: 4.h,
              ),
              SizedBox(
                width: 323.w,
                height: 30.h,
                child: Text(
                  'Your password did not match',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color.fromRGBO(255, 108, 108, 1),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Container btnContinue() {
    return Container(
      width: 298.w,
      height: 64.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(22.r)),
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Color.fromRGBO(228, 172, 26, 1),
            Color.fromRGBO(255, 226, 132, 1),
          ],
        ),
      ),
      child: Center(
        child: Text(
          'Continue',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: const Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
      ),
    );
  }

  SizedBox ckcBoxAndTextSetupPass() {
    return SizedBox(
      height: 48.h,
      width: 323.w,
      child: Row(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 24.w,
              height: 24.h,
              child: Checkbox(
                activeColor: const Color.fromRGBO(228, 172, 26, 1),
                // checkColor: const Colors,
                onChanged: (bool? value) {
                  null;
                },
                value: true,
              ),
            ),
          ),
          SizedBox(
            width: 12.w,
          ),
          SizedBox(
            width: 287.w,
            height: 48.h,
            child: Text(
              'I understand DeFi For You will not recover this\n'
              ' password for me',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                color: const Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ConstrainedBox formSetupPassWord({required String hintText}) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 323.w,
        maxHeight: 200.h,
        minHeight: 64.h,
      ),
      child: Container(
        width: 323.w,
        height: 64.h,
        padding: EdgeInsets.only(
          top: 14.h,
          bottom: 14.h,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          color: Color.fromRGBO(167, 167, 167, 0.5),
        ),
        child: StreamBuilder(
          stream: isValidPassCubit.showPWStream,
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            return TextFormField(
              // obscureText: snapshot.data,
              controller: password,
              expands: true,
              maxLines: null,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 4.h),
                hintText: hintText,
                hintStyle: textNormal(
                  Colors.grey,
                  14.sp,
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    if(index == 1) {
                      isValidPassCubit.isShowPW(1);
                      index = 2;
                    } else {
                      isValidPassCubit.isShowPW(0);
                      index = 1;
                    }
                  },
                  child: const ImageIcon(
                    AssetImage('assets/images/Hide.png'),
                    color: Colors.white,
                  ),
                ),
                prefixIcon: const ImageIcon(
                  AssetImage('assets/images/Lock.png'),
                  color: Colors.white,
                ),
                border: InputBorder.none,
              ),
            );
          },
        ),
      ),
    );
  }

  ConstrainedBox formSetupPassWordConfirm({required String hintText}) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 323.w,
        maxHeight: 200.h,
        minHeight: 64.h,
      ),
      child: Container(
        width: 323.w,
        height: 64.h,
        padding: EdgeInsets.only(
          top: 14.h,
          bottom: 14.h,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          color: Color.fromRGBO(167, 167, 167, 0.5),
        ),
        child: TextFormField(
          controller: confirmPassword,
          maxLines: null,
          cursorColor: Colors.white,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 4.h),
            hintText: hintText,
            hintStyle: textNormal(
              Colors.grey,
              14.sp,
            ),
            suffixIcon: const ImageIcon(
              AssetImage('assets/images/Hide.png'),
              color: Colors.white,
            ),
            prefixIcon: const ImageIcon(
              AssetImage('assets/images/Lock.png'),
              color: Colors.white,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Padding textShowSetupPass() {
    return Padding(
      padding: EdgeInsets.only(top: 24.h),
      child: SizedBox(
        width: 323.w,
        height: 72.h,
        child: Text(
          'Please setup your new password!\n'
          'This password will unlock your DeFi For You\n wallet '
          'only on this wallet',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: const Color.fromRGBO(255, 255, 255, 1.0),
          ),
        ),
      ),
    );
  }

  Padding header() {
    return Padding(
      padding:
          EdgeInsets.only(left: 26.w, right: 26.w, top: 16.h, bottom: 20.h),
      child: Row(
        children: [
          Expanded(
            child: IconButton(
              onPressed: () {},
              icon: Image.asset('assets/images/back_arrow.png'),
            ),
          ),
          SizedBox(
            width: 66.w,
          ),
          Text(
            'Create new wallet',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 64.48.w,
          ),
          Expanded(
            child: IconButton(
              onPressed: () {},
              icon: Image.asset('assets/images/Group.png'),
            ),
          )
        ],
      ),
    );
  }
}
