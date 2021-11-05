import 'package:Dfy/config/resources/images.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NFTItemWallet extends StatelessWidget {
  const NFTItemWallet({
    Key? key,
    required this.symbolUrl,
    required this.nameNFT,
  }) : super(key: key);

  final String symbolUrl;
  final String nameNFT;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 67.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            height: 1.h,
            color: const Color(0xFF4b4a60),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              SizedBox(width: 36.w,),
              Icon(
                Icons.arrow_forward_ios,
                size: 18.sp,
                color: Colors.white,
              ),
              SizedBox(width: 11.w,),
              Image(
                width: 28.w,
                height: 28.h,
                image: AssetImage(symbolUrl),
              ),
              SizedBox(
                width: 8.w,
              ),
              Text(
                nameNFT,
                style: textNormalCustom(
                  Colors.white,
                  20.sp,
                  FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
