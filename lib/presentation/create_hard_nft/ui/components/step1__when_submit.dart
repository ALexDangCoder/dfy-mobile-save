import 'dart:async';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/domain/model/detail_item_approve.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/list_book_evalution/ui/list_book_evaluation.dart';
import 'package:Dfy/utils/pop_up_notification.dart';
import 'package:Dfy/widgets/approve/ui/approve.dart';
import 'package:path/path.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/bloc/provide_hard_nft_info/provide_hard_nft_cubit.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/components/circle_status_provide_nft.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/components/upload_image_widget.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:path/path.dart';

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
  }) : super(key: key);
  final ProvideHardNftCubit cubit;

  @override
  Widget build(BuildContext context) {
    cubit.dataStep1.wallet = cubit.getAddressWallet().formatAddressWallet();
    return BaseDesignScreen(
      title: S.current.provide_hard_nft_info,
      bottomBar: Container(
        padding: EdgeInsets.only(bottom: 38.h),
        color: AppTheme.getInstance().bgBtsColor(),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: ButtonGold(
                  haveGradient: false,
                  textColor: AppTheme.getInstance().yellowColor(),
                  border: Border.all(
                    color: AppTheme.getInstance().yellowColor(),
                  ),
                  radiusButton: 15,
                  textSize: 16,
                  title: S.current.edit_info,
                  isEnable: true,
                  fixSize: false,
                  height: 48.h,
                  haveMargin: false,
                ),
              ),
            ),
            const SizedBox(width: 23),
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  await cubit.postFileMediaFeatDocumentApi();

                  ///
                  final NavigatorState navigator = Navigator.of(context);
                  unawaited(
                    navigator.push(
                      MaterialPageRoute(
                        builder: (context) => Approve(
                          needApprove: true,
                          hexString: cubit.hexStringWeb3,
                          payValue: cubit.dataStep1.amountToken.toString(),
                          tokenAddress: ADDRESS_DFY,
                          //todo
                          title: S.current.book_appointment,
                          listDetail: [
                            DetailItemApproveModel(
                              title: '${S.current.name} :',
                              value: cubit.dataStep1.hardNftName,
                            ),
                            DetailItemApproveModel(
                              title: '${S.current.type} :',
                              value: cubit.dataStep1.hardNftName,
                            ),
                            DetailItemApproveModel(
                              title: '${S.current.collection} :',
                              value: cubit.dataStep1.collection,
                            ),
                          ],
                          onErrorSign: (context) {},
                          onSuccessSign: (context, data) {
                            cubit.bcTxnHashModel.bc_txn_hash = data;
                            cubit.putHardNftBeforeConfirm(
                              cubit.assetId,
                              cubit.bcTxnHashModel,
                            );
                            showLoadSuccess(context).then((value) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ListBookEvaluation(
                                      assetId: cubit.assetId,
                                    ); //todo data
                                  },
                                ),
                              );
                            });
                          },
                          textActiveButton: S.current.request_evaluation,
                          spender: eva_dev2,
                        ),
                      ),
                    ),
                  );
                },
                child: ButtonGold(
                  radiusButton: 15,
                  textSize: 16,
                  title: S.current.submit,
                  isEnable: true,
                  height: 48.h,
                  fixSize: false,
                  haveMargin: false,
                ),
              ),
            ),
          ],
        ),
      ),
      child: SingleChildScrollView(
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
            UploadImageWidget(
              cubit: cubit,
              showAddMore: false,
            ),
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
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cubit.dataStep1.documents.length,
              itemBuilder: (ctx, index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    textShowWithPadding(
                      textShow: basename(cubit.dataStep1.documents[index]),
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
                    imageNftByTypeSelect(
                      id: cubit.dataStep1.hardNftType.id ?? 0,
                    ),
                    spaceW4,
                    Text(
                      cubit.dataStep1.hardNftName,
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
                      cubit.dataStep1.hardNftType.name ?? '',
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
                      cubit.dataStep1.conditionNft.name ?? '',
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
                      child: Image.asset(
                        ImageAssets.getSymbolAsset(
                          cubit.dataStep1.tokenInfo.symbol ?? DFY,
                        ),
                      ),
                    ),
                    spaceW4,
                    Text(
                      formatValue.format(cubit.dataStep1.amountToken),
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
              textShow: cubit.dataStep1.additionalInfo,
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
              title: '${cubit.dataStep1.phoneCodeModel.code} '
                  '${cubit.dataStep1.phoneContact}',
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
              isWallet: true,
              walletAddress: cubit.dataStep1.wallet.formatAddressWallet(),
            ),
            spaceH18,
            widgetShowCollectionFtWallet(
              nameCollection: cubit.dataStep1.collection,
              isWallet: false,
            ),
            spaceH46,
          ],
        ),
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

  SizedBox imageNftByTypeSelect({required int id}) {
    String imageNFT = '';
    switch (id) {
      case 2:
        imageNFT = ImageAssets.artWork;
        break;
      case 4:
        imageNFT = ImageAssets.car;
        break;
      case 3:
        imageNFT = ImageAssets.house;
        break;
      case 0:
        imageNFT = ImageAssets.diamond;
        break;
      case 1:
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
