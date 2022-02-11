import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/hard_nft_type_model.dart';
import 'package:Dfy/presentation/create_hard_nft/bloc/provide_hard_nft_info/provide_hard_nft_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonHardNftType extends StatelessWidget {
  const ButtonHardNftType({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final ProvideHardNftCubit cubit;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<HardNftTypeModel>>(
      stream: cubit.listHardNftTypeBHVSJ,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else {
          List<HardNftTypeModel> hardNftTypes = snapshot.data ?? [];
          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    hardNftTypeWidget(hardNftTypes[0]),
                    hardNftTypeWidget(hardNftTypes[1]),
                    hardNftTypeWidget(hardNftTypes[2]),
                    hardNftTypeWidget(hardNftTypes[3]),
                  ],
                ),
              ),
              spaceH16,
              Container(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                ),
                child: Row(
                  children: [
                    hardNftTypeWidget(hardNftTypes[4]),
                    spaceW28,
                    hardNftTypeWidget(hardNftTypes[5]),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget hardNftTypeWidget(HardNftTypeModel nftType) {
    String image = '';
    switch (nftType.id) {
      case 0:
        image = ImageAssets.diamond;
        break;
      case 1:
        image = ImageAssets.watch;
        break;
      case 2:
        image = ImageAssets.artWork;
        break;
      case 3:
        image = ImageAssets.house;
        break;
      case 4:
        image = ImageAssets.car;
        break;
      default:
        image = ImageAssets.others;
        break;
    }

    return Container(
      width: 64.w,
      height: 64.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppTheme.getInstance().itemBtsColors(),
      ),
      padding: EdgeInsets.only(top: 10.h),
      child: Column(
        children: [
          SizedBox(
            width: 24.w,
            height: 24.h,
            child: Image.asset(image),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Text(
              nftType.name ?? '',
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                14,
                FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}
