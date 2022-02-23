import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/bloc/provide_hard_nft_info/extension/upload_file_controller.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/hard_nft_type_model.dart';
import 'package:Dfy/presentation/create_hard_nft/bloc/provide_hard_nft_info/provide_hard_nft_cubit.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/components/circle_status_provide_nft.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/components/common_widget.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/components/form_drop_down.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/components/select_collection_dropdown.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/components/step1__when_submit.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/components/upload_document_widget.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/components/upload_image_widget.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/text/text_from_field_group/form_group.dart';
import 'package:Dfy/widgets/text/text_from_field_group/text_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'components/btn_hard_nft_type.dart';
import 'components/form_add_properties.dart';

enum CircleStatus {
  IS_CREATING,
  IS_NOT_CREATE,
}

class ProvideHardNftInfo extends StatefulWidget {
  const ProvideHardNftInfo({Key? key}) : super(key: key);

  @override
  _ProvideHardNftInfoState createState() => _ProvideHardNftInfoState();
}

class _ProvideHardNftInfoState extends State<ProvideHardNftInfo> {
  final GlobalKey<FormGroupState> _keyForm = GlobalKey<FormGroupState>();

  late String firstPhoneNumDropdown;
  late String cityFirstValue;
  late ProvideHardNftCubit cubit;
  late bool isShowOrHideItemProperties;
  String hardNftName = '';
  String additionalInfo = '';

  @override
  void initState() {
    super.initState();
    cubit = ProvideHardNftCubit();
    cubit.getTokenInf();
    cubit.getCountriesApi();
    cubit.getPhonesApi();
    cubit.getConditionsApi();
    cubit.getListHardNftTypeApi();
    cubit.getListCollection();
    if (cubit.propertiesData.isEmpty) {
      isShowOrHideItemProperties = false;
    } else {
      isShowOrHideItemProperties = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
      title: S.current.provide_hard_nft_info,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            child: FormGroup(
              key: _keyForm,
              child: Column(
                children: [
                  spaceH24,
                  const CircleStatusProvideHardNft(),
                  spaceH32,
                  textShowWithPadding(
                    textShow: 'HARD NFT ${S.current.picture}/ VIDEO',
                    txtStyle: textNormalCustom(
                      AppTheme.getInstance().unselectedTabLabelColor(),
                      14,
                      FontWeight.w400,
                    ),
                  ),
                  spaceH20,
                  // addMediaFile(),
                  UploadImageWidget(
                    cubit: cubit,
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
                  spaceH20,
                  UploadDocumentWidget(
                    cubit: cubit,
                  ),
                  StreamBuilder<bool>(
                    stream: cubit.enableButtonUploadDocumentSubject,
                    builder: (context, snapshot) {
                      final _isEnable = snapshot.data ?? true;
                      return Visibility(
                        visible: _isEnable,
                        child: btnAdd(
                          isEnable: _isEnable,
                          content: S.current.add,
                          onTap: () {
                            cubit.pickDocument();
                          },
                        ),
                      );
                    },
                  ),
                  spaceH20,
                  spaceH32,
                  textShowWithPadding(
                    textShow: S.current.hard_nft_info,
                    txtStyle: textNormalCustom(
                      AppTheme.getInstance().unselectedTabLabelColor(),
                      14,
                      FontWeight.w400,
                    ),
                  ),
                  spaceH20,
                  textShowWithPadding(
                    textShow: S.current.select_nft_type,
                    txtStyle: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      14,
                      FontWeight.w400,
                    ),
                  ),
                  spaceH8,
                  ButtonHardNftType(cubit: cubit),
                  spaceH24,
                  textShowWithPadding(
                    textShow: S.current.hard_nft_name,
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
                    child: TextFieldValidator(
                      hint: S.current.enter_name,
                      onChange: (value) {
                        cubit.dataStep1.hardNftName = value;
                        cubit.mapValidate['inputForm'] =
                            _keyForm.currentState?.checkValidator() ?? false;
                        cubit.validateAll();
                      },
                      validator: (value) {
                        return cubit.validateHardNftName(value ?? '');
                      },
                    ),
                  ),
                  spaceH16,
                  textShowWithPadding(
                    textShow: S.current.condition,
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
                    cubit: cubit,
                  ),
                  spaceH16,
                  textShowWithPadding(
                    textShow: S.current.expecting_price,
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
                    child: TextFieldValidator(
                      textInputType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      hint: S.current.enter_price,
                      onChange: (value) {
                        cubit.dataStep1.amountToken = double.parse(value);
                        cubit.mapValidate['inputForm'] =
                            _keyForm.currentState?.checkValidator() ?? false;
                        cubit.validateAll();
                      },
                      validator: (value) {
                        return cubit.validateAmountToken(value ?? '');
                      },
                      suffixIcon: FormDropDown(
                        typeDrop: TYPE_FORM_DROPDOWN.PRICE,
                        cubit: cubit,
                      ),
                    ),
                  ),
                  spaceH16,
                  textShowWithPadding(
                    textShow: S.current.addition_info,
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
                    child: TextFieldValidator(
                      hint: S.current.enter_info,
                      onChange: (value) {
                        cubit.dataStep1.additionalInfo = value;
                        cubit.mapValidate['inputForm'] =
                            _keyForm.currentState?.checkValidator() ?? false;
                        cubit.validateAll();
                      },
                      validator: (value) {
                        return cubit.validateAdditionInfo(value ?? '');
                      },
                    ),
                  ),
                  spaceH24,
                  textShowWithPadding(
                    textShow: S.current.properties,
                    txtStyle: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                  itemPropertiesFtBtnAdd(),
                  spaceH32,
                  textShowWithPadding(
                    textShow: S.current.contact_info,
                    txtStyle: textNormalCustom(
                      AppTheme.getInstance().unselectedTabLabelColor(),
                      14,
                      FontWeight.w400,
                    ),
                  ),
                  spaceH20,
                  textShowWithPadding(
                    textShow: S.current.name,
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
                    child: TextFieldValidator(
                      onChange: (value) {
                        cubit.dataStep1.nameContact = value;
                        cubit.mapValidate['inputForm'] =
                            _keyForm.currentState?.checkValidator() ?? false;
                        cubit.validateAll();
                      },
                      validator: (value) {
                        return cubit.validateHardNftName(value ?? '');
                      },
                      hint: S.current.enter_name,
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
                    child: TextFieldValidator(
                      onChange: (value) {
                        cubit.dataStep1.emailContact = value;
                        cubit.mapValidate['inputForm'] =
                            _keyForm.currentState?.checkValidator() ?? false;
                        cubit.validateAll();
                      },
                      validator: (value) {
                        return cubit.validateEmail(value ?? '');
                      },
                      hint: S.current.enter_email,
                    ),
                  ),
                  spaceH16,
                  textShowWithPadding(
                    textShow: S.current.phone_num,
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
                    child: TextFieldValidator(
                      prefixIcon: FormDropDown(
                        typeDrop: TYPE_FORM_DROPDOWN.PHONE,
                        cubit: cubit,
                      ),
                      onChange: (value) {
                        cubit.dataStep1.phoneContact = value;
                        cubit.mapValidate['inputForm'] =
                            _keyForm.currentState?.checkValidator() ?? false;
                        cubit.validateAll();
                      },
                      validator: (value) {
                        return cubit.validateMobile(value ?? '');
                      },
                    ),
                  ),

                  spaceH16,
                  textShowWithPadding(
                    textShow: S.current.country,
                    txtStyle: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                  spaceH4,
                  FormDropDown(
                    typeDrop: TYPE_FORM_DROPDOWN.COUNTRY,
                    cubit: cubit,
                  ),
                  spaceH16,
                  textShowWithPadding(
                    textShow: S.current.city,
                    txtStyle: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                  spaceH4,
                  FormDropDown(
                    typeDrop: TYPE_FORM_DROPDOWN.CITY,
                    cubit: cubit,
                  ),
                  spaceH16,
                  textShowWithPadding(
                    textShow: S.current.address,
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
                    child: TextFieldValidator(
                      onChange: (value) {
                        cubit.dataStep1.addressContact = value;
                        cubit.mapValidate['inputForm'] =
                            _keyForm.currentState?.checkValidator() ?? false;
                        cubit.validateAll();
                      },
                      validator: (value) {
                        return cubit.validateAddress(value ?? '');
                      },
                      hint: S.current.enter_add,
                    ),
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
                  spaceH14,
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                    ),
                    child: TextFieldValidator(
                      readOnly: true,
                      hint: cubit.getAddressWallet().formatAddressWallet(),
                    ),
                  ),
                  spaceH16,
                  textShowWithPadding(
                    textShow: S.current.collection,
                    txtStyle: textNormalCustom(
                      AppTheme.getInstance().whiteOpacityDot5(),
                      16,
                      FontWeight.w600,
                    ),
                  ),
                  spaceH4,
                  CategoriesDropDown(
                    cubit: cubit,
                  ),
                  SizedBox(
                    height: 150.h,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 38.h),
            color: AppTheme.getInstance().bgBtsColor(),
            child: StreamBuilder<bool>(
              initialData: true,
              stream: cubit.nextBtnBHVSJ.stream,
              builder: (ctx, snapshot) {
                return GestureDetector(
                  onTap: () {
                    if (snapshot.data ?? false) {
                      // cubit.createModel();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => Step1WhenSubmit(cubit: cubit),
                          // builder: (ctx) => ComingSoon(),
                        ),
                      );
                    } else {
                      //nothing
                    }
                  },
                  child: ButtonGold(
                    title: S.current.next,
                    isEnable: (snapshot.data ?? false) ? true : false,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget itemPropertiesFtBtnAdd() {
    return StreamBuilder<List<PropertyModel>>(
      initialData: cubit.propertiesData,
      stream: cubit.showItemProperties,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if ((snapshot.data ?? []).isEmpty)
              Container()
            else
              Container(
                margin: EdgeInsets.only(
                  top: 16.h,
                ),
                padding: EdgeInsets.only(left: 16.w),
                child: Wrap(
                  runSpacing: 10.h,
                  children: cubit.propertiesData.map(
                        (e) {
                      final int index = cubit.propertiesData.indexOf(e);
                      return itemProperty(
                        property: e.property,
                        value: e.value,
                        index: index,
                        isHaveClose: true,
                      );
                    },
                  ).toList(),
                ),
              ),
            spaceH10,
            divider,
            spaceH20,
            Row(
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
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) =>
                          Dialog(
                            backgroundColor: Colors.transparent,
                            child: FormAddProperties(
                              cubit: cubit,
                            ),
                          ),
                    );
                  },
                  child: Text(
                    (snapshot.data ?? []).isEmpty
                        ? S.current.add
                        : S.current.add_more,
                    style: textNormalCustom(
                      AppTheme.getInstance().fillColor(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
            spaceH20,
            divider,
          ],
        );
      },
    );
  }

  Widget btnSelectNftType({
    required HardNftTypeModel hardNftType,
  }) {
    String image = '';
    switch (hardNftType.id) {
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
              hardNftType.name ?? '',
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
          S.current.add,
          style: textNormalCustom(
            AppTheme.getInstance().fillColor(),
            16,
            FontWeight.w400,
          ),
        )
      ],
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
                cubit.checkPropertiesWhenSave(property: '', value: '');
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
