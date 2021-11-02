import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetupPassWord extends StatefulWidget {
  const SetupPassWord({Key? key}) : super(key: key);

  @override
  _SetupPassWordState createState() => _SetupPassWordState();
}

class _SetupPassWordState extends State<SetupPassWord> {
  bool showPass = false;
  bool showPassConfirm = false;

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
                  SizedBox(
                    height: 16.h,
                  ),
                  formSetupPassWordConfirm(
                    hintText: 'Confirm password',
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  ckcBoxAndTextSetupPass(),
                  SizedBox(
                    height: 256.h,
                  ),
                ],
              ),
            ),
          ),
          btnContinue(),
          SizedBox(
            height: 38.h,
          )
        ],
      ),
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
        child: TextField(
          expands: true,
          maxLines: null,
          cursorColor: Colors.white,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 4.h),
            hintText: 'Confirm password',
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
        child: TextField(
          expands: true,
          maxLines: null,
          cursorColor: Colors.white,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 4.h),
            hintText: 'Confirm password',
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
