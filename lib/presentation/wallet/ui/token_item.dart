import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/presentation/token_detail/bloc/token_detail_bloc.dart';
import 'package:Dfy/presentation/token_detail/ui/token_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TokenItem extends StatelessWidget {
  const TokenItem({
    Key? key,
    required this.symbolUrl,
    required this.amount,
    required this.nameToken,
    required this.price,
  }) : super(key: key);

  final String symbolUrl;
  final String amount;
  final String nameToken;
  final String price;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return TokenDetail(
                tokenData: nameToken.isNotEmpty? 159753 : 12345,
                bloc: TokenDetailBloc(),
              );
            },
          ),
        );
      },
      child: Column(
        children: [
          Divider(
            height: 1.h,
            color: const Color(0xFF4b4a60),
          ),
          SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 19.h,
                    left: 20.w,
                  ),
                  child: Image(
                    width: 28.w,
                    height: 28.h,
                    image: AssetImage(symbolUrl),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 20.h,
                    left: 10.w,
                    bottom: 20.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$amount $nameToken',
                        style: textNormalCustom(
                          Colors.white,
                          20.sp,
                          FontWeight.w600,
                        ),
                      ),
                      Text(
                        '\$ $price',
                        style: textNormalCustom(
                          Colors.grey.shade400,
                          16.sp,
                          FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
