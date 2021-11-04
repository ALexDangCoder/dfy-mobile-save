import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendTokenFtNft extends StatefulWidget {
  const SendTokenFtNft({Key? key}) : super(key: key);

  @override
  _SendTokenFtNftState createState() => _SendTokenFtNftState();
}

class _SendTokenFtNftState extends State<SendTokenFtNft> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
          header(nameToken: 'DFY'),
          const Divider(
            thickness: 1,
            color: Color.fromRGBO(255, 255, 255, 0.1),
          ),
          SizedBox(
            height: 24.h,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  formShowFtAddress(
                    hintText: '0xf94138c9...43FE932eA',
                    readOnly: true,
                    prefixImg: ImageAssets.from,
                    suffixImg: '',
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  formShowFtAddress(
                    hintText: 'To address',
                    suffixImg: ImageAssets.code,
                    prefixImg: ImageAssets.to,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  formAmountFtQuantity(
                    hintText: 'Amount',
                    isAmount: true,
                    isQuantity: false,
                    prefixImg: ImageAssets.token,
                  ),
                  SizedBox(
                    height: 353.h,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            child: ButtonGold(
              title: 'Continue',
              isEnable: false,
            ),
            onTap: () {},
          ),
          SizedBox(
            height: 34.h,
          ),
        ],
      ),
    );
  }

  //header
  Padding header({required String nameToken}) {
    return Padding(
      padding:
          EdgeInsets.only(left: 26.w, right: 26.w, top: 16.h, bottom: 20.h),
      child: Row(
        children: [
          SizedBox(
            width: 121.w,
          ),
          Text(
            'Send $nameToken',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 94.w,
          ),
          Expanded(
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset('assets/images/Group.png'),
            ),
          )
        ],
      ),
    );
  }

  Container formShowFtAddress({
    required String hintText,
    bool readOnly = false,
    Function()? callBack,
    required String suffixImg,
    required String prefixImg,
  }) {
    return Container(
      height: 64.h,
      width: 323.w,
      padding: EdgeInsets.only(
        top: 12.h,
        bottom: 12.h,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Color(0xff32324c),
      ),
      child: TextFormField(
        readOnly: readOnly,
        style: textNormal(
          Colors.white,
          16.sp,
        ),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: readOnly
              ? TextStyle(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                )
              : textNormal(
                  Colors.grey,
                  14.sp,
                ),
          suffixIcon: InkWell(
            onTap: callBack,
            child: suffixImg == ''
                ? const SizedBox(
                    width: 0,
                  )
                : ImageIcon(
                    AssetImage(suffixImg),
                    color: Colors.white,
                  ),
          ),
          prefixIcon: ImageIcon(
            AssetImage(prefixImg),
            color: Colors.white,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Container formAmountFtQuantity({
    required String hintText,
    required bool isAmount,
    required bool isQuantity,
    required String prefixImg,
    Function()? callBack,
  }) {
    return Container(
      height: 64.h,
      width: 323.w,
      padding: EdgeInsets.only(
        top: 12.h,
        bottom: 12.h,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Color(0xff32324c),
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        textAlignVertical: TextAlignVertical.center,
        style: textNormal(
          Colors.white,
          16.sp,
        ),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: textNormal(
            Colors.grey,
            14.sp,
          ),
          suffixIcon: InkWell(
            onTap: callBack,
            child: (isAmount && !isQuantity)
                ? Text(
                    'Max',
                    style: TextStyle(
                      color: const Color.fromRGBO(228, 172, 26, 1),
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  )
                : Text(
                    'of 10',
                    style: TextStyle(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
          ),
          prefixIcon: ImageIcon(
            AssetImage(prefixImg),
            color: Colors.white,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

//sau la suffix
//truoc la prefix
}
