import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/create_hard_nft/bloc/provide_hard_nft_info/provide_hard_nft_cubit.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/components/circle_status_provide_nft.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/components/form_drop_down.dart';
import 'package:Dfy/presentation/market_place/login/connect_wallet_dialog/ui/connect_wallet_dialog.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/pick_media_file.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/form/custom_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'components/dashed_btn_add_img_vid.dart';
import 'components/form_add_properties.dart';

enum CircleStatus {
  IS_CREATING,
  IS_NOT_CREATE,
}

List<String> brands = ['gucci, luis vuituoi, prada, zara,'];

List<String> countries = ['Viet nam', 'UK', 'England'];

class ProvideHardNftInfo extends StatefulWidget {
  const ProvideHardNftInfo({Key? key}) : super(key: key);

  @override
  _ProvideHardNftInfoState createState() => _ProvideHardNftInfoState();
}

class _ProvideHardNftInfoState extends State<ProvideHardNftInfo> {
  late Token firstValueDropdown;
  late String firstPhoneNumDropdown;
  late String cityFirstValue;
  late ProvideHardNftCubit cubit;
  String hardNftName = '';
  String additionalInfo = '';

  @override
  void initState() {
    super.initState();
    cubit = ProvideHardNftCubit();
    firstValueDropdown = tokens[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getInstance().bgBtsColor(),
      body: GestureDetector(
        onTap: () {
          final FocusScopeNode currentFocus = FocusScope.of(context);
          cubit.showHideDropDownBtn();
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: BaseBottomSheet(
          bottomBar: Container(
            padding: EdgeInsets.only(bottom: 38.h),
            color: AppTheme.getInstance().bgBtsColor(),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => Dialog(
                    backgroundColor: Colors.transparent,
                    child: FormAddProperties(
                      cubit: cubit,
                    ),
                  ),
                );
              },
              child: const ButtonGold(
                title: 'NEXT',
                isEnable: true,
              ),
            ),
          ),
          resizeBottomInset: true,
          title: 'Provide Hard NFT info',
          child: SingleChildScrollView(
            child: Column(
              children: [
                spaceH24,
                const CircleStatusProvideHardNft(),
                spaceH32,
                textShowWithPadding(
                  textShow: 'Hard NFT picture/ video',
                  txtStyle: textNormalCustom(
                    AppTheme.getInstance().unselectedTabLabelColor(),
                    14,
                    FontWeight.w400,
                  ),
                ),
                spaceH20,
                InkWell(
                  onTap: () async {},
                  child: ButtonDashedAddImageFtVid(),
                ),
                spaceH32,
                textShowWithPadding(
                  textShow: 'DOCUMENTS',
                  txtStyle: textNormalCustom(
                    AppTheme.getInstance().unselectedTabLabelColor(),
                    14,
                    FontWeight.w400,
                  ),
                ),
                divider,
                spaceH20,
                btnAddFtAddMoreProperties(),
                spaceH20,
                divider,
                spaceH32,
                textShowWithPadding(
                  textShow: 'HARD NFT INFORMATION',
                  txtStyle: textNormalCustom(
                    AppTheme.getInstance().unselectedTabLabelColor(),
                    14,
                    FontWeight.w400,
                  ),
                ),
                spaceH20,
                textShowWithPadding(
                  textShow: 'Select NFT type',
                  txtStyle: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    14,
                    FontWeight.w400,
                  ),
                ),
                spaceH8,
                Container(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      btnSelectNftType(
                        image: ImageAssets.diamond,
                        textNftType: 'Jewelry',
                      ),
                      btnSelectNftType(
                        image: ImageAssets.artWork,
                        textNftType: 'Artwork',
                      ),
                      btnSelectNftType(
                        image: ImageAssets.car,
                        textNftType: 'Car',
                      ),
                      btnSelectNftType(
                        image: ImageAssets.watch,
                        textNftType: 'Watch',
                      )
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
                      btnSelectNftType(
                        image: ImageAssets.house,
                        textNftType: 'House',
                      ),
                      spaceW28,
                      btnSelectNftType(
                        image: ImageAssets.others,
                        textNftType: 'Others',
                      ),
                    ],
                  ),
                ),
                spaceH24,
                textShowWithPadding(
                  textShow: 'Hard NFT name',
                  txtStyle: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    16,
                    FontWeight.w400,
                  ),
                ),
                spaceH4,
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  child: CustomForm(
                    textValue: (value) {
                      hardNftName = value;
                    },
                    hintText: 'Enter name nft',
                    suffix: null,
                    inputType: null,
                  ),
                ),
                spaceH16,
                textShowWithPadding(
                  textShow: 'Condition',
                  txtStyle: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    16,
                    FontWeight.w400,
                  ),
                ),
                spaceH4,

                ///form select condition
                FormDropDown(
                  typeDrop: TYPE_FORM_DROPDOWN.CONDITION,
                ),
                spaceH16,
                textShowWithPadding(
                  textShow: 'Expecting price',
                  txtStyle: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    16,
                    FontWeight.w400,
                  ),
                ),
                spaceH4,

                ///form expecting price
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  child: CustomForm(
                    textValue: (value) {
                      print(value);
                    },
                    hintText: 'Enter price',
                    suffix: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 1.w,
                          height: 32.h,
                          color: AppTheme.getInstance().whiteDot2(),
                        ),
                        FormDropDown(typeDrop: TYPE_FORM_DROPDOWN.PRICE),
                      ],
                    ),
                    inputType: null,
                  ),
                ),
                spaceH16,
                textShowWithPadding(
                  textShow: 'Additional information',
                  txtStyle: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    16,
                    FontWeight.w400,
                  ),
                ),
                spaceH4,

                ///form add information
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  child: CustomForm(
                    textValue: (value) {
                      additionalInfo = value;
                      print(additionalInfo);
                    },
                    hintText: 'Enter information',
                    suffix: null,
                    inputType: null,
                  ),
                ),
                spaceH24,
                textShowWithPadding(
                  textShow: 'Properties',
                  txtStyle: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    16,
                    FontWeight.w400,
                  ),
                ),
                //todo check
                item_properties(),
                spaceH10,
                divider,
                spaceH20,
                btnAddFtAddMoreProperties(),
                spaceH20,
                divider,
                spaceH32,
                textShowWithPadding(
                  textShow: 'Contact information',
                  txtStyle: textNormalCustom(
                    AppTheme.getInstance().unselectedTabLabelColor(),
                    14,
                    FontWeight.w400,
                  ),
                ),
                spaceH20,
                textShowWithPadding(
                  textShow: 'Name',
                  txtStyle: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    16,
                    FontWeight.w400,
                  ),
                ),
                spaceH4,

                ///form enter name
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  child: CustomForm(
                    textValue: (value) {
                      print(value);
                    },
                    hintText: 'Enter name',
                    suffix: null,
                    inputType: null,
                  ),
                ),
                spaceH16,
                textShowWithPadding(
                  textShow: 'Email',
                  txtStyle: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    16,
                    FontWeight.w400,
                  ),
                ),
                spaceH4,

                ///form enter email
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  child: CustomForm(
                    textValue: (value) {
                      print(value);
                    },
                    hintText: 'Enter email',
                    suffix: null,
                    inputType: null,
                  ),
                ),
                spaceH16,
                textShowWithPadding(
                  textShow: 'Phone number',
                  txtStyle: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    16,
                    FontWeight.w400,
                  ),
                ),
                spaceH4,

                ///FORM NUMBER
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  child: Row(
                    children: [
                      FormDropDown(typeDrop: TYPE_FORM_DROPDOWN.PHONE),
                      Expanded(
                        child: CustomForm(
                          isSelectNumPrefix: true,
                          textValue: (value) {
                            print(value);
                          },
                          hintText: 'Enter phone number',
                          suffix: null,
                          prefix: null,
                          inputType: null,
                        ),
                      ),
                    ],
                  ),
                ),
                spaceH16,
                textShowWithPadding(
                  textShow: 'Country',
                  txtStyle: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    16,
                    FontWeight.w400,
                  ),
                ),
                spaceH4,
                FormDropDown(
                  typeDrop: TYPE_FORM_DROPDOWN.COUNTRY,
                ),
                spaceH16,
                textShowWithPadding(
                  textShow: 'City',
                  txtStyle: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    16,
                    FontWeight.w400,
                  ),
                ),
                spaceH4,
                FormDropDown(
                  typeDrop: TYPE_FORM_DROPDOWN.CITY,
                ),
                spaceH16,
                textShowWithPadding(
                  textShow: 'Address',
                  txtStyle: textNormalCustom(
                    AppTheme.getInstance().whiteColor(),
                    16,
                    FontWeight.w400,
                  ),
                ),
                spaceH4,
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  child: CustomForm(
                    textValue: (value) {
                      print(hardNftName);
                    },
                    hintText: 'Enter address',
                    suffix: null,
                    inputType: null,
                  ),
                ),
                spaceH32,
                textShowWithPadding(
                  textShow: 'WALLET AND COLLECTION',
                  txtStyle: textNormalCustom(
                    AppTheme.getInstance().unselectedTabLabelColor(),
                    14,
                    FontWeight.w400,
                  ),
                ),
                spaceH14,
                btnConnectWallet(),
                spaceH16,
                textShowWithPadding(
                  textShow: 'Collection',
                  txtStyle: textNormalCustom(
                    AppTheme.getInstance().whiteOpacityDot5(),
                    16,
                    FontWeight.w600,
                  ),
                ),
                spaceH4,
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  child: CustomForm(
                    textValue: (value) {
                      print(value);
                    },
                    hintText: 'Connect wallet to get collection list',
                    suffix: null,
                    inputType: null,
                  ),
                ),
                SizedBox(
                  height: 48.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell btnConnectWallet() {
    return InkWell(
      onTap: () {
        // showDialog(
        //   context: context,
        //   builder: (ctx) => ConnectWalletDialog(
        //     isRequireLoginEmail: false,
        //   ),
        // );
      },
      child: textShowWithPadding(
        textShow: 'Connect wallet',
        txtStyle: textNormalCustom(
          AppTheme.getInstance().fillColor(),
          16,
          FontWeight.w600,
        ),
      ),
    );
  }

  Container item_properties() {
    return Container(
      padding: EdgeInsets.only(left: 16.w),
      child: Wrap(
        alignment: WrapAlignment.start,
        runSpacing: 10.h,
        children: [
          itemProperty(
            property: 'artist',
            value: 'someone',
          ),
          spaceW20,
          itemProperty(
            property: 'lorem ipsum',
            value: 'lorem ipsum',
          ),
          spaceW20,
          itemProperty(
            property: 'artist',
            value: 'someone',
          ),
          itemProperty(
            property: 'lorem ipsum',
            value: 'lorem ipsum',
          ),
        ],
      ),
    );
  }

  Widget btnSelectNftType({
    required String image,
    required String textNftType,
  }) {
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
              textNftType,
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

  Row btnAddFtAddMoreProperties() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 20.w,
          height: 20.h,
          child: Image.asset(
            ImageAssets.addPropertiesNft,
          ),
        ),
        spaceW8,
        Text(
          'Add',
          style: textNormalCustom(
            AppTheme.getInstance().fillColor(),
            16,
            FontWeight.w400,
          ),
        )
      ],
    );
  }

  //todo refactor stl
  Container itemProperty({
    required String property,
    required String value,
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
          Image.asset(
            ImageAssets.closeProperties,
          ),
        ],
      ),
    );
  }

  Container textShowWithPadding({
    required String textShow,
    required TextStyle txtStyle,
  }) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.w,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          textShow,
          style: txtStyle,
        ),
      ),
    );
  }
}
