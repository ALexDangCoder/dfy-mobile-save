import 'package:Dfy/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

final formatValue = NumberFormat('###,###,###.###', 'en_US');

class InformationWallet extends StatelessWidget {
  const InformationWallet({
    Key? key,
    required this.nameWallet,
    required this.fromAddress,
    required this.amount,
    required this.nameToken,
    required this.imgWallet,
  }) : super(key: key);

  final String nameWallet;
  final String fromAddress;
  final double amount;
  final String nameToken;
  final String imgWallet;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      // height: 74.h,
      decoration: BoxDecoration(
        // color: const Color.fromRGBO(255, 255, 255, 0.1),
        borderRadius: BorderRadius.all(Radius.circular(16)),
        border: Border.all(color: const Color.fromRGBO(255, 255, 255, 0.1)),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 12.w,
              top: 16.h,
              bottom: 18.h,
            ),
            child: circularImage(imgWallet),
          ),
          Column(
            children: [
              SizedBox(
                width: 7.35.w,
              ),
              SizedBox(
                height: 2.h,
              ),
              SizedBox(
                width: 8.35.w,
              ),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //hang1
                Padding(
                  padding: EdgeInsets.only(top: 14.h),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          nameWallet,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: const Color.fromRGBO(255, 255, 255, 1),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          fromAddress,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: const Color.fromRGBO(255, 255, 255, 0.5),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                //hang 2
                Text(
                  '${S.current.balance}: ${formatValue.format(amount)} $nameToken',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: const Color.fromRGBO(255, 255, 255, 1),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container circularImage(String img) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // border: Border.all(
        //     color: Colors.teal, width: 10.0, style: BorderStyle.solid),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(img),
        ),
      ),
    );
  }
}
