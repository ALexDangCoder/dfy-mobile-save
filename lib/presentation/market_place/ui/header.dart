import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/bloc/marketplace_cubit.dart';
import 'package:Dfy/presentation/market_place/search/ui/nft_search.dart';
import 'package:Dfy/presentation/menu_account/ui/menu_account.dart';
import 'package:Dfy/presentation/put_on_market/ui/put_on_market_screen.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderMarketPlace extends StatelessWidget {
  const HeaderMarketPlace({Key? key, required this.cubit}) : super(key: key);
  final MarketplaceCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 44.h,
        left: 16.h,
        right: 16.w,
      ),
      child: SizedBox(
        height: 52.h,
        width: 343.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: ImageIcon(
                const AssetImage(ImageAssets.ic_profile),
                size: 28.sp,
                color: AppTheme.getInstance().whiteColor(),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MenuAccount(),
                  ),
                );
              },
            ),
            searchBar(context, cubit),
            GestureDetector(
              child: ImageIcon(
                const AssetImage(ImageAssets.ic_notify),
                size: 28.sp,
                color: AppTheme.getInstance().whiteColor(),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget searchBar(BuildContext context, MarketplaceCubit cubit) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SearchNFT(
              cubit: cubit,
            ),
          ),
        );
      },
      child: Container(
        width: 259.w,
        height: 38.h,
        decoration: BoxDecoration(
          color: const Color(0xff4F4F65),
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 14.w,
            ),
            Image.asset(
              ImageAssets.ic_search,
              width: 15.w,
              height: 15.h,
            ),
            SizedBox(
              width: 10.7.w,
            ),
            Text(
              S.current.search,
              style: textNormal(
                Colors.white54,
                16.sp,
              ),
            )
          ],
        ),
      ),
    );
  }
}
