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
import 'package:Dfy/presentation/market_place/login/connect_wallet_dialog/ui/connect_wallet_dialog.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/form/custom_form.dart';
import 'package:Dfy/widgets/text/text_from_field_group/form_group.dart';
import 'package:Dfy/widgets/text/text_from_field_group/text_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'components/btn_hard_nft_type.dart';
import 'components/dashed_btn_add_img_vid.dart';
import 'components/form_add_properties.dart';

enum CircleStatus {
  IS_CREATING,
  IS_NOT_CREATE,
}

enum NFT_TYPES {
  ART,
  CAR,
  WATCH,
  JEWELRY,
  HOUSE,
  OTHER,
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
    if (cubit.properties.isEmpty) {
      isShowOrHideItemProperties = false;
    } else {
      isShowOrHideItemProperties = true;
    }
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
                cubit.navigatorToConfirmInfo();
              },
              child: ButtonGold(
                title: S.current.next,
                isEnable: true,
              ),
            ),
          ),
          resizeBottomInset: true,
          title: S.current.provide_hard_nft_info,
          child: BlocBuilder<ProvideHardNftCubit, ProvideHardNftState>(
            bloc: cubit,
            builder: (context, state) {
              if (state is ProvideHardNftConfirmInfo) {
                return Step1WhenSubmit(
                  cubit: cubit,
                  typeNftSelect: NFT_TYPE.WATCH,
                  modelPassing: cubit.fakeData,
                );
              } else {
                return SingleChildScrollView(
                  child: FormGroup(
                    key: _keyForm,
                    child: Column(
                      children: [
                        spaceH24,
                        const CircleStatusProvideHardNft(),
                        spaceH32,
                        textShowWithPadding(
                          textShow: 'Hard NFT ${S.current.picture}/ video',
                          txtStyle: textNormalCustom(
                            AppTheme.getInstance().unselectedTabLabelColor(),
                            14,
                            FontWeight.w400,
                          ),
                        ),
                        spaceH20,
                        // addMediaFile(),
                        UploadWidget(
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
                            }),
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
                            onChange: (value) {},
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
                            hint: S.current.enter_price,
                            onChange: (value) {},
                            validator: (value) {
                              return cubit.validateAmountToken(value ?? '');
                            },
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 1.w,
                                  height: 32.h,
                                  color: AppTheme.getInstance().whiteDot2(),
                                ),
                                FormDropDown(
                                  typeDrop: TYPE_FORM_DROPDOWN.PRICE,
                                  cubit: cubit,
                                ),
                              ],
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
                          child: CustomForm(
                            textValue: (value) {},
                            hintText: S.current.enter_name,
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
                          child: TextFieldValidator(
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
                          child: Row(
                            children: [
                              FormDropDown(
                                typeDrop: TYPE_FORM_DROPDOWN.PHONE,
                                cubit: cubit,
                              ),
                              Expanded(
                                child: TextFieldValidator(
                                  validator: (value) {
                                    return cubit.validateMobile(value ?? '');
                                  },
                                ),
                              ),
                            ],
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
                        btnConnectWallet(),
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
                          height: 48.h,
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  InkWell btnConnectWallet() {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (ctx) => const ConnectWalletDialog(
            isRequireLoginEmail: false,
          ),
        ).then((value) => cubit.getListCollection());
      },
      child: textShowWithPadding(
        textShow: S.current.connect_wallet,
        txtStyle: textNormalCustom(
          AppTheme.getInstance().fillColor(),
          16,
          FontWeight.w600,
        ),
      ),
    );
  }

  Widget itemPropertiesFtBtnAdd() {
    return StreamBuilder<List<PropertyModel>>(
      initialData: cubit.properties,
      stream: cubit.showItemProperties,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (snapshot.data!.isEmpty)
              Container()
            else
              Container(
                margin: EdgeInsets.only(
                  top: 16.h,
                ),
                padding: EdgeInsets.only(left: 16.w),
                child: Wrap(
                  runSpacing: 10.h,
                  children: cubit.properties.map(
                    (e) {
                      final int index = cubit.properties.indexOf(e);
                      return itemProperty(
                        property: e.property,
                        value: e.value,
                        index: index,
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
                      builder: (_) => Dialog(
                        backgroundColor: Colors.transparent,
                        child: FormAddProperties(
                          cubit: cubit,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    snapshot.data!.isEmpty ? S.current.add : S.current.add_more,
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
                cubit.properties.removeAt(index);
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
