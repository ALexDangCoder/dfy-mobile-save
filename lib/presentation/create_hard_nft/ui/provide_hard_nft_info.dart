import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/create_hard_nft/bloc/provide_hard_nft_info/provide_hard_nft_cubit.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/components/circle_status_provide_nft.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/components/form_add_properties.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/form/custom_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/dashed_btn_add_img_vid.dart';

enum CircleStatus {
  IS_CREATING,
  IS_NOT_CREATE,
}

List<String> brands = ['gucci, luis vuituoi, prada, zara,'];

List<String> countries = ['Viet nam', 'UK', 'England'];

List<String> cities = ['Vinh', 'Hanoi', 'Nam Dinh'];

class Token {
  final String shortName;
  final String image;

  Token(this.shortName, this.image);
}

List<Token> tokens = [
  Token(
    'Dfy',
    ImageAssets.ic_dfy,
  ),
  Token(
    'NFY',
    ImageAssets.ic_dfy,
  ),
  Token(
    'lgf',
    ImageAssets.ic_dfy,
  ),
  Token(
    'fuk',
    ImageAssets.ic_dfy,
  ),
  Token(
    '123',
    ImageAssets.ic_dfy,
  ),
  Token(
    '312',
    ImageAssets.ic_dfy,
  ),
  Token(
    '1',
    ImageAssets.ic_dfy,
  ),
  Token(
    '2',
    ImageAssets.ic_dfy,
  ),
  Token(
    '3',
    ImageAssets.ic_dfy,
  ),
  Token(
    '66',
    ImageAssets.ic_dfy,
  )
];

List<String> phoneNumber = [
  '+84',
  '+11',
  '+44',
  '+23',
  '+10',
];

class ProvideHardNftInfo extends StatefulWidget {
  const ProvideHardNftInfo({Key? key}) : super(key: key);

  @override
  _ProvideHardNftInfoState createState() => _ProvideHardNftInfoState();
}

class _ProvideHardNftInfoState extends State<ProvideHardNftInfo> {
  late Token firstValueDropdown;
  late String firstPhoneNumDropdown;
  late ProvideHardNftCubit cubit;
  String hardNftName = '';
  String additionalInfo = '';

  @override
  void initState() {
    super.initState();
    cubit = ProvideHardNftCubit();
    firstValueDropdown = tokens[0];
    firstPhoneNumDropdown = phoneNumber[1];
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
                // showDialog(
                //   context: context,
                //   builder: (_) => Dialog(
                //     backgroundColor: Colors.transparent,
                //     child: Container(),
                //   ),
                // );
              },
              child: ButtonGold(
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
                const ButtonDashedAddImageFtVid(),
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
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  child: CustomForm(
                    textValue: (value) {
                      print(value);
                    },
                    hintText: 'Select condition',
                    suffix: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          ImageAssets.btnDownArrow,
                        ),
                      ],
                    ),
                    inputType: null,
                  ),
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
                        spaceW10,
                        DropdownButton<Token>(
                          focusColor: ,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.r),
                            bottomRight: Radius.circular(10.r),
                            bottomLeft: Radius.circular(10.r),
                          ),
                          icon: Image.asset(
                            ImageAssets.btnDownArrow,
                          ),
                          dropdownColor: AppTheme.getInstance().itemBtsColors(),
                          underline: const SizedBox(),
                          value: firstValueDropdown,
                          onChanged: (value) {
                            setState(() {
                              FocusScope.of(context).requestFocus(FocusNode());
                              firstValueDropdown = value!;
                            });
                          },
                          items: tokens
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        height: 20.h,
                                        width: 20.w,
                                        child: Image.asset(e.image),
                                      ),
                                      spaceW5,
                                      Text(
                                        e.shortName,
                                        style: textNormalCustom(
                                          AppTheme.getInstance().whiteColor(),
                                          16,
                                          FontWeight.w400,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
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
                      Container(
                        padding: EdgeInsets.only(
                          left: 5.w,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.getInstance().itemBtsColors(),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.r),
                            bottomLeft: Radius.circular(20.r),
                          ),
                        ),
                        height: 64.h,
                        width: 55.w,
                        child: Center(
                          child: DropdownButton<String>(
                            icon: Image.asset(
                              ImageAssets.btnDownArrow,
                            ),
                            dropdownColor:
                                AppTheme.getInstance().itemBtsColors(),
                            underline: const SizedBox(),
                            value: firstPhoneNumDropdown,
                            onChanged: (value) {
                              setState(() {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                firstPhoneNumDropdown = value ?? '';
                              });
                            },
                            items: phoneNumber
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: textNormalCustom(
                                        AppTheme.getInstance().whiteColor(),
                                        16,
                                        FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
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
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  child: Focus(
                    onFocusChange: (value) {
                      cubit.showHideDropDownBtn(
                        typeDropDown: DropDownBtnType.COUNTRY,
                        value: value,
                      );
                    },
                    child: CustomForm(
                      textValue: (value) {
                        cubit.showHideDropDownBtn(
                          typeDropDown: DropDownBtnType.COUNTRY,
                        );
                        print(value);
                      },
                      hintText: 'Select country',
                      suffix: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            ImageAssets.btnDownArrow,
                          ),
                        ],
                      ),
                      inputType: null,
                    ),
                  ),
                ),
                StreamBuilder<bool>(
                  stream: cubit.visibleDropDownCity.stream,
                  initialData: false,
                  builder: (context, snapshot) {
                    return Visibility(
                      visible: snapshot.data ?? false,
                      child: Container(
                        width: 343.w,
                        height: 203.h,
                        decoration: BoxDecoration(
                          color: AppTheme.getInstance().bgDropdownBtn(),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: ListView.builder(
                          itemCount: cities.length,
                          itemBuilder: (ctx, index) {
                            return Text(
                              cities[index],
                              style: textNormalCustom(
                                AppTheme.getInstance().whiteColor(),
                                10,
                                FontWeight.w400,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
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
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  child: CustomForm(
                    textValue: (value) {
                      print(value);
                    },
                    hintText: 'Select city',
                    suffix: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          ImageAssets.btnDownArrow,
                        ),
                      ],
                    ),
                    inputType: null,
                  ),
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
                textShowWithPadding(
                  textShow: 'Connect wallet',
                  txtStyle: textNormalCustom(
                    AppTheme.getInstance().fillColor(),
                    16,
                    FontWeight.w600,
                  ),
                ),
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
