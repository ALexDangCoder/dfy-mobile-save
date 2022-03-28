import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ManageLoanPackageList extends StatefulWidget {
  const ManageLoanPackageList({Key? key}) : super(key: key);

  @override
  _ManageLoanPackageListState createState() => _ManageLoanPackageListState();
}

class _ManageLoanPackageListState extends State<ManageLoanPackageList> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget _lenderSettingItem() {
    return Container(
      width: 343.w,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageAssets.bg_manage_loan_package_list),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            child: Column(
              children: [
                Text(
                  S.current.description_manage_loan_1,
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    14,
                    FontWeight.w600,
                  ),
                ),
                Text(
                  S.current.description_manage_loan_2,
                  style: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    14,
                    FontWeight.w600,
                  ),
                ),
                spaceH13,
                Container(
                  width: 165.w,
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    bottom: 10.h,
                    top: 10.h,
                  ),
                  child: ButtonGradient(
                    gradient: RadialGradient(
                      center: const Alignment(0.5, -0.5),
                      radius: 4,
                      colors: AppTheme.getInstance().gradientButtonColor(),
                    ),
                    onPressed: () {},
                    child: Text(
                      S.current.add_lend_setting,
                      style: textNormalCustom(
                        AppTheme.getInstance().textThemeColor(),
                        16,
                        FontWeight.w600,
                      ),
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
}
