import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/components/circle_status_provide_nft.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common/dotted_border.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/form/custom_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum CircleStatus {
  IS_CREATING,
  IS_NOT_CREATE,
}

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
    'Dfy',
    ImageAssets.ic_dfy,
  )
];

List<String> phoneNumber = [
  '+84',
  '+11',
  '+44',
  '+23',
  '+10',
  '+87',
  '+78',
];

class ProvideHardNftInfo extends StatefulWidget {
  const ProvideHardNftInfo({Key? key}) : super(key: key);

  @override
  _ProvideHardNftInfoState createState() => _ProvideHardNftInfoState();
}

class _ProvideHardNftInfoState extends State<ProvideHardNftInfo> {
  late Token firstValueDropdown;
  late String firstPhoneNumDropdown;

  @override
  void initState() {
    super.initState();
    firstValueDropdown = tokens[0];
    firstPhoneNumDropdown = phoneNumber[1];
  }

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
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
            buildDashedCreateNft(),
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

            ///Form hard nft name
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
                  print(value);
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
              child: CustomForm(
                textValue: (value) {
                  print(value);
                },
                hintText: 'Enter phone number',
                suffix: null,
                prefix: DropdownButton<String>(
                  icon: Image.asset(
                    ImageAssets.btnDownArrow,
                  ),
                  dropdownColor: AppTheme.getInstance().itemBtsColors(),
                  underline: const SizedBox(),
                  value: firstPhoneNumDropdown,
                  onChanged: (value) {
                    setState(() {
                      FocusScope.of(context).requestFocus(FocusNode());
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
                inputType: null,
              ),
            )
          ],
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

  Widget buildDashedCreateNft() => DottedBorder(
        radius: Radius.circular(20.r),
        borderType: BorderType.RRect,
        color: AppTheme.getInstance().dashedColorContainer(),
        child: Container(
          padding: EdgeInsets.only(
            top: 20.h,
          ),
          width: 343.w,
          height: 133.h,
          child: Column(
            children: [
              Image.asset(
                ImageAssets.createNft,
              ),
              spaceH12,
              Text(
                'Format: mp4, WEBM, mp3, WAV,\n' +
                    '       OGG, png, jpg, jpeg, GIF',
                style: textNormalCustom(
                  AppTheme.getInstance().whiteColor(),
                  14,
                  FontWeight.w400,
                ),
              )
            ],
          ),
        ),
      );
}
