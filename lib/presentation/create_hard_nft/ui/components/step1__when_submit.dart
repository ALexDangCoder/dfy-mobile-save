import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/bloc/provide_hard_nft_info/provide_hard_nft_cubit.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/components/circle_status_provide_nft.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

enum NFT_TYPE {
  JEWELRY,
  ARTWORK,
  CAR,
  WATCH,
  HOUSE,
  OTHER,
}

final formatValue = NumberFormat('###,###,###.###', 'en_US');

class Step1WhenSubmit extends StatelessWidget {
  const Step1WhenSubmit({
    Key? key,
    required this.cubit,
    required this.typeNftSelect,
    required this.modelPassing,
  }) : super(key: key);
  final ProvideHardNftCubit cubit;
  final NFT_TYPE typeNftSelect;
  final Step1PassingModel modelPassing;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          spaceH24,
          const Center(child: CircleStatusProvideHardNft()),
          spaceH32,
          textShowWithPadding(
            textShow: 'Hard NFT ${S.current.picture}/ video',
            txtStyle: textNormalCustom(
              AppTheme.getInstance().unselectedTabLabelColor(),
              14,
              FontWeight.w400,
            ),
          ),
          //todo WIDGET ẢNH
          spaceH32,
          textShowWithPadding(
            textShow: S.current.documents,
            txtStyle: textNormalCustom(
              AppTheme.getInstance().unselectedTabLabelColor(),
              14,
              FontWeight.w400,
            ),
          ),
          // spaceH20,
          ListView.builder(
            shrinkWrap: true,
            itemCount: cubit.documents.length,
            itemBuilder: (ctx, index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  textShowWithPadding(
                    textShow: cubit.documents[index].title,
                    typeFile: cubit.documents[index].typeFile,
                    txtStyle: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                  if (index == cubit.documents.length) spaceH32 else spaceH16,
                ],
              );
            },
          ),
          textShowWithPadding(
            textShow: S.current.hard_nft_info,
            txtStyle: textNormalCustom(
              AppTheme.getInstance().unselectedTabLabelColor(),
              14,
              FontWeight.w400,
            ),
          ),
          spaceH16,
          //icon feat name
          Container(
            padding: EdgeInsets.only(
              left: 16.w,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  imageNftByTypeSelect(typeNftSelect: typeNftSelect),
                  spaceW4,
                  Text(
                    modelPassing.hardNftName,
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      24,
                      FontWeight.w700,
                    ),
                  )
                ],
              ),
            ),
          ),
          spaceH8,
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(
                left: 16.w,
              ),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: [
                  Text(
                    modelPassing.nameNftType,
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w700,
                    ),
                  ),
                  spaceW4,
                  Container(
                    width: 1.w,
                    height: 12.h,
                    color: AppTheme.getInstance().whiteColor(),
                  ),
                  spaceW5,
                  Text(
                    modelPassing.conditionNft.name ?? '',
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w700,
                    ),
                  ),
                  spaceW4,
                  Container(
                    width: 1.w,
                    height: 12.h,
                    color: AppTheme.getInstance().whiteColor(),
                  ),
                  spaceW5,
                  Text(
                    S.current.expecting_price,
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w700,
                    ),
                  ),
                  spaceW4,
                  SizedBox(
                    width: 16.w,
                    height: 16.h,
                    //todo
                    // child: Image.asset(modelPassing.imageToken),
                  ),
                  spaceW4,
                  Text(
                    formatValue.format(modelPassing.amountToken),
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
          ),
          spaceH8,
          textShowWithPadding(
            textShow: cubit.dataStep1.informationNft,
            txtStyle: textNormalCustom(
              AppTheme.getInstance().whiteOpacityDot5(),
              16,
              FontWeight.w400,
            ),
          ),
          spaceH12,
          //item properties
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(
                left: 16.w,
              ),
              child: Wrap(
                runSpacing: 10.h,
                children: cubit.dataStep1.properties.map((e) {
                  final int index = cubit.dataStep1.properties.indexOf(e);
                  return itemProperty(
                    property: e.property,
                    value: e.value,
                    index: index,
                  );
                }).toList(),
              ),
            ),
          ),
          spaceH20,
          textShowWithPadding(
            textShow: S.current.contact_info,
            txtStyle: textNormalCustom(
              AppTheme.getInstance().unselectedTabLabelColor(),
              14,
              FontWeight.w400,
            ),
          ),
          spaceH12,
          informationContactWidget(
            title: cubit.dataStep1.nameContact,
            image: ImageAssets.profileStep1,
          ),
          spaceH15,
          informationContactWidget(
            title: cubit.dataStep1.emailContact,
            image: ImageAssets.mailStep1,
          ),
          spaceH15,
          informationContactWidget(
            title: cubit.dataStep1.phoneContact,
            image: ImageAssets.callStep1,
          ),
          spaceH15,
          informationContactWidget(
            title: cubit.dataStep1.addressContact,
            image: ImageAssets.locationStep1,
          ),
          spaceH32,
          textShowWithPadding(
            textShow: S.current.wallet_and_collection,
            txtStyle: textNormalCustom(
              AppTheme.getInstance().unselectedTabLabelColor(),
              14,
              FontWeight.w400,
            ),
          ),
          spaceH16,
          widgetShowCollectionFtWallet(
              isWallet: true, walletAddress: '0xcd...1029'),
          spaceH18,
          widgetShowCollectionFtWallet(
            nameCollection: 'Collection of HUYTQ',
            isWallet: false,
          ),
          spaceH46,
        ],
      ),
    );
  }

  Container textShowWithPadding({
    required String textShow,
    required TextStyle txtStyle,
    String? typeFile,
  }) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.w,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          '$textShow.${typeFile ??= ''}',
          style: txtStyle,
        ),
      ),
    );
  }

  SizedBox imageNftByTypeSelect({required NFT_TYPE typeNftSelect}) {
    String imageNFT = '';
    switch (typeNftSelect) {
      case NFT_TYPE.ARTWORK:
        imageNFT = ImageAssets.artWork;
        break;
      case NFT_TYPE.CAR:
        imageNFT = ImageAssets.car;
        break;
      case NFT_TYPE.HOUSE:
        imageNFT = ImageAssets.house;
        break;
      case NFT_TYPE.JEWELRY:
        imageNFT = ImageAssets.diamond;
        break;
      case NFT_TYPE.WATCH:
        imageNFT = ImageAssets.watch;
        break;
      default:
        //case other
        imageNFT = ImageAssets.others;
        break;
    }
    return SizedBox(
      width: 24.w,
      height: 24.h,
      child: Image.asset(imageNFT),
    );
  }

  Container itemProperty({
    bool isHaveClose = false,
    required String property,
    required String value,
    required int index,
  }) {
    return Container(
      height: 44.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.r),
        ),
        border: Border.all(
          color: AppTheme.getInstance().whiteDot2(),
        ),
      ),
      margin: EdgeInsets.only(right: 20.w),
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 3.h,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                property,
                style: textNormalCustom(
                  AppTheme.getInstance().whiteOpacityDot5(),
                  12,
                  FontWeight.w400,
                ),
              ),
              Text(
                value,
                style: textNormalCustom(
                  AppTheme.getInstance().whiteColor(),
                  14,
                  FontWeight.w400,
                ),
              )
            ],
          ),
          Visibility(
            visible: isHaveClose ? true : false,
            child: InkWell(
              onTap: () {
                cubit.propertiesData.removeAt(index);
                cubit.checkPropertiesWhenSave();
              },
              child: Image.asset(
                ImageAssets.closeProperties,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container informationContactWidget({
    required String title,
    required String image,
  }) {
    return Container(
      padding: EdgeInsets.only(left: 16.w),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 24.h,
                width: 24.h,
                child: Image.asset(image),
              ),
              spaceW6,
              Text(
                title,
                style: textNormalCustom(
                  AppTheme.getInstance().whiteColor(),
                  16,
                  FontWeight.w400,
                ),
              )
            ],
          ),
          spaceH15,
        ],
      ),
    );
  }

  Container widgetShowCollectionFtWallet({
    required bool isWallet,
    String? walletAddress,
    String? nameCollection,
  }) {
    return isWallet
        ? Container(
            padding: EdgeInsets.only(
              left: 16.w,
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 24.h,
                  width: 24.w,
                  child: Image.asset(
                    ImageAssets.walletStep1,
                  ),
                ),
                spaceW6,
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      text: '${S.current.wallet} ',
                      style: textNormalCustom(
                        AppTheme.getInstance().whiteColor(),
                        16,
                        FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: walletAddress,
                          style: textNormalCustom(
                            AppTheme.getInstance().blueText(),
                            16,
                            FontWeight.w500,
                          ).copyWith(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(
                          text: ' ${S.current.will_receive_nft}',
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        : Container(
            padding: EdgeInsets.only(
              left: 16.w,
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 24.h,
                  width: 24.w,
                  child: Image.asset(
                    ImageAssets.collectionStep1,
                  ),
                ),
                spaceW6,
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      text: '${S.current.hard_nft_will_be_create} ',
                      style: textNormalCustom(
                        AppTheme.getInstance().whiteColor(),
                        16,
                        FontWeight.w400,
                      ),
                      children: [
                        TextSpan(
                          text: nameCollection,
                          style: textNormalCustom(
                            AppTheme.getInstance().blueText(),
                            16,
                            FontWeight.w500,
                          ).copyWith(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
