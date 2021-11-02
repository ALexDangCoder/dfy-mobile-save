import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/form/item_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestoreAccount extends StatefulWidget {
  const RestoreAccount({Key? key}) : super(key: key);

  @override
  _RestoreAccountState createState() => _RestoreAccountState();
}

class _RestoreAccountState extends State<RestoreAccount> {
  final List<String> items = [
    'Private key',
    'Private key',
    'Private key',
    'Private key',
    'Private key'
  ];
  String? currentValue = 'Private key';

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
                  'Restore Account',
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
            height: 1.h,
            color: AppTheme.getInstance().divideColor(),
          ),
          SizedBox(
            height: 24.h,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Restore your account with using secret seed phrase',
                  style: textNormal(
                    null,
                    16.sp,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  'Only first account on this wallet will auto load. '
                  'After completing this process, to add additional accounts,'
                  'you can create new account or import account',
                  style: textNormal(
                    null,
                    16.sp,
                  ),
                ),
                SizedBox(
                  height: 44.h,
                ),
                Container(
                  height: 64.h,
                  width: 323.w,
                  padding: EdgeInsets.only(
                    top: 6.h,
                    bottom: 6.h,
                    right: 13.w,
                    left: 13.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: AppTheme.getInstance().itemBtsColor(),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 17.2.h,
                        width: 20.w,
                        child: const ImageIcon(
                          AssetImage(ImageAssets.security),
                          color: Colors.white,
                        ),
                      ),
                      // DropdownButton(
                      //   items: items.map(buildItem).toList(),
                      //   value: currentValue,
                      //
                      // )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                const ItemForm(
                  leadPath: ImageAssets.key,
                  trailingPath: ImageAssets.hide,
                  hint: 'Wallet secret seed phrase',
                ),
                SizedBox(
                  height: 20.h,
                ),
                const ItemForm(
                  leadPath: ImageAssets.lock,
                  trailingPath: ImageAssets.hide,
                  hint: 'New password',
                ),
                SizedBox(
                  height: 20.h,
                ),
                const ItemForm(
                  leadPath: ImageAssets.lock,
                  trailingPath: ImageAssets.hide,
                  hint: 'Confirm password',
                ),
                SizedBox(
                  height: 61.h,
                ),
                ButtonGradient(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    colors: <Color>[
                      Color(0xffE4AC1A),
                      Color(0xffFFE284),
                    ],
                  ),
                  onPressed: () {},
                  child: Text(
                    'Restore',
                    style: textNormal(
                      null,
                      20.sp,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildItem(String value) =>
      DropdownMenuItem(child: Text(value));
}
