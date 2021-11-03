import 'dart:io';

import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/presentation/login/bloc/login_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controller = TextEditingController();
  final LoginCubit _cubit = LoginCubit();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () =>
          Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              width: 375.sw,
              height: 812.h,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF3C3B54),
                    Color(0xFF171527),
                  ],
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 113.h,
                    ),
                    const Image(
                      image: AssetImage('assets/images/symbol.png'),
                    ),
                    SizedBox(
                      height: 28.h,
                    ),
                    const Image(
                      image: AssetImage('assets/images/Centered.png'),
                    ),
                    SizedBox(
                      height: 68.h,
                    ),
                    Container(
                      width: 323.w,
                      height: 64.h,
                      decoration: const BoxDecoration(
                        color: Color(0xFFA7A7A7),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 19.w,
                          right: 19.w,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 12.h),
                                child: const Icon(
                                  Icons.lock_outline,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                              SizedBox(
                                width: 20.5.w,
                              ),
                              Expanded(
                                child: TextFormField(
                                  cursorColor: Colors.white,
                                  style: TextStyle(fontSize: 18.sp),
                                  controller: controller,
                                  obscureText: _cubit.hidePass,
                                  decoration: const InputDecoration(
                                    hintText: 'Password',
                                    border: InputBorder.none,
                                  ),
                                  // onFieldSubmitted: ,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 12.h),
                                child: GestureDetector(
                                  onTap: () =>
                                      setState(() {
                                        _cubit.hidePassword();
                                      }),
                                  child: _cubit.hidePass
                                      ? const Icon(
                                    Icons.visibility_off_outlined,
                                    color: Colors.white30,
                                  )
                                      : const Icon(
                                    Icons.visibility_outlined,
                                    color: Colors.white30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 36.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        _cubit.checkPass(controller.value.text);
                      },
                      child: Container(
                        height: 64.h,
                        width: 298.w,
                        decoration: BoxDecoration(
                          gradient: const RadialGradient(
                            center: Alignment(0.5, -0.5),
                            radius: 4,
                            colors: [
                              Color(0xFFFFE284),
                              Color(0xFFE4AC1A),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    BlocListener<LoginCubit, LoginState>(
                      bloc: _cubit,
                      listener: (context, state) {
                        if(state is LoginSuccess) {
                          Navigator.pushNamed(context, AppRouter.wallet,);
                        }
                      },
                      child: GestureDetector(
                        onTap: () {
                          _cubit.authenticate();
                        },
                        child: Platform.isIOS
                            ? const Image(
                          image: AssetImage('assets/images/face_id_icon.png'),
                        )
                            : const Image(
                          image: AssetImage('assets/images/finger_icon.png'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 44.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'New wallet',
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16.h,
                        ),
                        Container(
                          height: 4.h,
                          width: 4.w,
                          decoration: const BoxDecoration(
                            color: Color(0xFFD4D4D4),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(
                          width: 16.h,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Import Seed phrase',
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
