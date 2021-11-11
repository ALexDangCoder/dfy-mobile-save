import 'package:Dfy/presentation/send_token_nft/bloc/send_token_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Dfy/generated/l10n.dart';

class HideCustomizeFee extends StatelessWidget {
  //todo show warning text
  const HideCustomizeFee({
    required this.nameToken,
    required this.sendTokenCubit,
    required this.balance,
    required this.gasFee,
    Key? key,
  }) : super(key: key);
  final String nameToken;
  final SendTokenCubit sendTokenCubit;
  final double balance;
  final double gasFee;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 26.w, right: 26.w),
      child: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              // minHeight: 78.h,
            ),
            child: Container(
              width: 323.w,
              height: 83.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16.r)),
                border:
                    Border.all(color: const Color.fromRGBO(255, 255, 255, 0.1)),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 8.h,
                  bottom: 13.h,
                  left: 12.w,
                  right: 12.h,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.current.estimate_gas_fee,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        StreamBuilder(
                          // initialData: gasFee < balance,
                          stream: sendTokenCubit.isSufficientTokenStream,
                          builder: (context, AsyncSnapshot<bool> snapshot) {
                            return snapshot.data ?? gasFee < balance
                                //if sufficient will not show warning red text
                                ? Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        //todo handle amount ??
                                        StreamBuilder<String>(
                                          initialData: gasFee.toString(),
                                          stream: sendTokenCubit
                                              .formEstimateGasFeeStream,
                                          builder: (context, snapshot) {
                                            return Text(
                                              '${snapshot.data} $nameToken',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.sp,
                                                color: Colors.white,
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                      ],
                                    ),
                                  )
                                //else will show warning read text
                                : Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        StreamBuilder<String>(
                                          initialData: gasFee.toString(),
                                          stream: sendTokenCubit
                                              .formEstimateGasFeeStream,
                                          builder: (context, snapshot) {
                                            return Text(
                                              '${snapshot.data} $nameToken',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.sp,
                                                color: Colors.red,
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Text(
                                          S.current.insufficient_balance,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: btnShow(),
                        onTap: () =>
                            sendTokenCubit.isShowCustomizeFee(isShow: true),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 275.h,
          ),
        ],
      ),
    );
  }

  Text btnShow() {
    return Text(
      S.current.customize_fee,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
        color: const Color.fromRGBO(70, 188, 255, 1),
      ),
    );
  }
}
