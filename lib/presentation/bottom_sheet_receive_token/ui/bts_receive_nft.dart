import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReceiveNFT extends StatefulWidget {
  const ReceiveNFT({Key? key, required this.walletAddress}) : super(key: key);
  final String walletAddress;

  @override
  _ReceiveNFTState createState() => _ReceiveNFTState();
}

class _ReceiveNFTState extends State<ReceiveNFT> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 764.h,
      width: 375.w,
      decoration: BoxDecoration(
        color: AppTheme.getInstance().bgBtsColor(),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 16.h,
              left: 26.w,
              right: 26.w,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    height: 16.8.h,
                    width: 16.8.w,
                    child: const ImageIcon(
                      AssetImage(ImageAssets.back),
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 75.w,
                ),
                Text(
                  S.current.receive_nft,
                  style: textNormal(null, 20.sp).copyWith(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: AppTheme.getInstance().divideColor(),
          ),
          SizedBox(
            height: 41.h,
          ),
          Container(
            height: 367.h,
            width: 311.w,
            padding: EdgeInsets.only(
              top: 16.h,
              bottom: 12.h,
              right: 40.w,
              left: 40.w,
            ),
            decoration: const BoxDecoration(
              color: Color(0xff585782),
              borderRadius: BorderRadius.all(
                Radius.circular(36),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: 125.w,
                  height: 29.83.h,
                  child: Image.asset(ImageAssets.defiText),
                ),
                SizedBox(
                  height: 13.17.h,
                ),
                QrImage(
                  data: widget.walletAddress,
                  size: 230.w,
                  gapless: false,
                  backgroundColor: Colors.white,
                ),
                SizedBox(
                  height: 12.h,
                ),
                SizedBox(
                  height: 54.h,
                  width: 232.w,
                  child: Text(
                    widget.walletAddress,
                    textAlign: TextAlign.center,
                    style: textNormalCustom(
                      null,
                      18.sp,
                      FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            padding: EdgeInsets.only(
              left: 24.w,
              right: 24.w,
            ),
            width: 311.w,
            height: 76.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildColumnButton(
                  path: ImageAssets.save,
                  label: S.current.save,
                ),
                SizedBox(
                  width: 60.w,
                ),
                _buildColumnButton(
                  path: ImageAssets.share,
                  label: S.current.share,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  GestureDetector _buildColumnButton({
    required String path,
    required String label,
    Function()? callback,
  }) {
    return GestureDetector(
      onTap: callback,
      child: Column(
        children: [
          Container(
            height: 48.h,
            width: 48.h,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color.fromRGBO(255, 255, 255, 0.2),
                image: DecorationImage(image: AssetImage(path))),
          ),
          SizedBox(
            height: 8.h,
          ),
          Expanded(
            child: Text(
              label,
              style: textNormalCustom(null, 16.sp, FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
