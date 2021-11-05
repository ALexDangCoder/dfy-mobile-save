import 'package:Dfy/presentation/send_token_nft/bloc/send_token_cubit.dart';
import 'package:Dfy/presentation/send_token_nft/ui/components/information_wallet.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmBlockchain extends StatefulWidget {
  const ConfirmBlockchain({Key? key}) : super(key: key);

  @override
  _ConfirmBlockchainState createState() => _ConfirmBlockchainState();
}

class _ConfirmBlockchainState extends State<ConfirmBlockchain> {
  late SendTokenCubit sendTokenCubit;

  @override
  void initState() {
    sendTokenCubit = SendTokenCubit();
    super.initState();
  }

  @override
  void dispose() {
    sendTokenCubit.dispose();
    super.dispose();
  }

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
            header(nameToken: 'DFY'),
            const Divider(
              thickness: 1,
              color: Color.fromRGBO(255, 255, 255, 0.1),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    formConfirm(
                      from: '0xFE5788e2...EB7144fd0',
                      to: '0xf94138c9...43FE932eA',
                      amount: '55,240.36 DFY',
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 26.w, right: 26.w),
                      child: const Divider(
                        thickness: 1,
                        color: Color.fromRGBO(255, 255, 255, 0.1),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    const InformationWallet(
                      nameWallet: 'Test wallet',
                      fromAddress: '0xFE5...4fd0',
                      amount: 0.551,
                      nameToken: 'BNB',
                      imgWallet: ImageAssets.hardCoreImgWallet,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    hideCustomizeFeeForm(
                      context,
                      nameToken: 'BNB',
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: const ButtonGold(
                title: 'Approve',
                isEnable: false,
              ),
            ),
            SizedBox(
              height: 38.h,
            ),
          ],
        ),
      ),
    );
  }

  Padding header({required String nameToken}) {
    return Padding(
      padding:
          EdgeInsets.only(left: 26.w, right: 26.w, top: 16.h, bottom: 20.h),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset('assets/images/back_arrow.png'),
          ),
          SizedBox(
            width: 95.w,
          ),
          Text(
            'Send $nameToken',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Padding formConfirm({
    required String from,
    required String to,
    required String amount,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: 26.w,
        right: 99.w,
        top: 24.h,
        bottom: 20.h,
      ),
      child: SizedBox(
        width: 250.w,
        height: 93.h,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'From:',
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
                  'To:',
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
                  'Amount:',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    color: const Color.fromRGBO(255, 255, 255, 1),
                  ),
                )
              ],
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
                  height: 12.h,
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
    );
  }

  Container hideCustomizeFeeForm(BuildContext context,
      {required String nameToken}) {
    return Container(
      width: 323.w,
      height: 78.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
        border: Border.all(color: const Color.fromRGBO(255, 255, 255, 0.1)),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 8.h, bottom: 16.h, left: 12.w, right: 12.h,),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Estimate gas fee:',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    //todo handle amount ??
                    Text(
                      '0.00036 $nameToken',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    )
                  ],
                )
                // StreamBuilder(
                //   stream: sendTokenCubit.isSufficientTokenStream,
                //   builder: (context, AsyncSnapshot<bool> snapshot) {
                //     return snapshot.data ?? false
                //     //if sufficient will not show warning red text
                //         ? Column(
                //       crossAxisAlignment: CrossAxisAlignment.end,
                //       children: [
                //         //todo handle amount ??
                //         Text('0.00036 $nameToken', style: TextStyle(
                //           fontWeight: FontWeight.w600,
                //           fontSize: 16.sp,
                //         ),)
                //       ],
                //     )
                //     //else will show warning read text
                //         : Column(
                //       crossAxisAlignment: CrossAxisAlignment.end,
                //       children: [
                //         Text('0.00036 $nameToken', style: TextStyle(
                //           fontWeight: FontWeight.w600,
                //           fontSize: 16.sp,
                //           color: Colors.red,
                //         ),),
                //         SizedBox(height: 2.h,),
                //         Text('Insufficent balance', style: TextStyle(
                //           fontSize: 12.sp,
                //           fontWeight: FontWeight.w400,
                //         ),),
                //       ],
                //     );
                //   },
                // ),
              ],
            ),
            Expanded(
              child: SizedBox(
                height: 20.h,
              ),
            ),
            Expanded(
              child: Text(
                'Customize fee',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: const Color.fromRGBO(70, 188, 255, 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
