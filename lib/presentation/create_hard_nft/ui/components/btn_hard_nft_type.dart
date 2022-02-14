import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/hard_nft_type_model.dart';
import 'package:Dfy/generated/l10n.dart';
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
          return CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              AppTheme.getInstance().whiteColor(),
            ),
          );
        } else if ((snapshot.data ?? []).isEmpty) {
          return InkWell(
            onTap: () {
              cubit.getListHardNftTypeApi();
            },
            child: SizedBox(
              height: 54.h,
              width: 54.w,
              child: Image.asset(ImageAssets.reload_nft),
            ),
          );
        } else {
          final List<HardNftTypeModel> hardNftTypes = snapshot.data ?? [];
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
                    hardNftTypeWidget(hardNftTypes[0], 0),
                    hardNftTypeWidget(hardNftTypes[1], 1),
                    hardNftTypeWidget(hardNftTypes[2], 2),
                    hardNftTypeWidget(hardNftTypes[3], 3),
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
                    hardNftTypeWidget(hardNftTypes[4], 4),
                    spaceW28,
                    hardNftTypeWidget(hardNftTypes[5], 5),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget hardNftTypeWidget(
    HardNftTypeModel nftType,
    int id,
  ) {
    String image = '';
    String nameTypeNft = '';
    switch (nftType.id) {
      case 0:
        image = ImageAssets.diamond;
        nameTypeNft = S.current.jewelry;
        break;
      case 1:
        image = ImageAssets.watch;
        nameTypeNft = S.current.watch;
        break;
      case 2:
        image = ImageAssets.artWork;
        nameTypeNft = S.current.art_work;
        break;
      case 3:
        image = ImageAssets.house;
        nameTypeNft = S.current.house;
        break;
      case 4:
        image = ImageAssets.car;
        nameTypeNft = S.current.car;
        break;
      default:
        image = ImageAssets.others;
        nameTypeNft = S.current.others;
        break;
    }

    return StreamBuilder<List<bool>>(
        initialData: cubit.listChangeColorFtChoose,
        stream: cubit.listChangeColorFtChooseBHVSJ,
        builder: (context, snapshot) {
          return InkWell(
            onTap: () {
              cubit.dataStep1.hardNftType.id = id;
              cubit.dataStep1.hardNftType.name = nameTypeNft;
              cubit.chooseTypeNft(index: id,);
            },
            child: Container(
              width: 64.w,
              height: 64.h,
              decoration: BoxDecoration(
                border: (snapshot.data ?? []).elementAt(id)
                    ? Border.all(
                        color: AppTheme.getInstance().yellowColor(),
                      )
                    : null,
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
                      nameTypeNft,
                      style: textNormalCustom(
                        AppTheme.getInstance().whiteColor(),
                        14,
                        FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
