import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Dfy/generated/l10n.dart';

class FormAddFtAmount extends StatelessWidget {
  const FormAddFtAmount({
    required this.amount,
    required this.from,
    required this.to,
    Key? key,
  }) : super(key: key);
  final String from;
  final String to;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 26.w,
        right: 99.w,
        top: 24.h,
        bottom: 20.h,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 250.w,
          minHeight: 93.h,
        ),
        child: SizedBox(
          // width: 250.w,
          // height: 93.h,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${S.current.from}:',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      '${S.current.to}:',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                    SizedBox(
                      height: 17.h,
                    ),
                    Text(
                      '${S.current.amount}:',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 30.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    from,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: const Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    to,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: const Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Text(
                    amount,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                      color: const Color.fromRGBO(228, 172, 26, 1),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
