import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/pawn/send_loan_request/bloc/send_loan_request_cubit.dart';
import 'package:Dfy/presentation/pawn/send_loan_request/ui/widget/form_dropdown.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common/dotted_border.dart';
import 'package:Dfy/widgets/text/text_from_field_group/form_group.dart';
import 'package:Dfy/widgets/text/text_from_field_group/text_field_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///https://beta.gwapi.defiforyou.uk/defi-pawn-crypto-service/public-api/v1.0.0/account/collaterals/nfts?walletAddress=all&page=0&size=6

class SendLoanRequestNft extends StatefulWidget {
  const SendLoanRequestNft({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final SendLoanRequestCubit cubit;

  @override
  _SendLoanRequestNftState createState() => _SendLoanRequestNftState();
}

class _SendLoanRequestNftState extends State<SendLoanRequestNft> {
  final GlobalKey<FormGroupState> _keyForm = GlobalKey<FormGroupState>();

  @override
  void initState() {
    super.initState();
    widget.cubit.getTokensRequestNft();
  }

  @override
  Widget build(BuildContext context) {
    return FormGroup(
      key: _keyForm,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DottedBorder(
              radius: Radius.circular(20.r),
              borderType: BorderType.RRect,
              color: AppTheme.getInstance().dashedColorContainer(),
              child: Container(
                height: 172.h,
                width: 343.w,
                padding: EdgeInsets.only(top: 47.h),
                child: Column(
                  children: [
                    Image.asset(
                      ImageAssets.createNft,
                    ),
                    spaceH16,
                    Text(
                      'Choose your NFT',
                      style: textNormalCustom(
                        AppTheme.getInstance().whiteColor(),
                        14,
                        FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            ),
            spaceH36,
            Text(
              'Message',
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                16,
                FontWeight.w400,
              ),
            ),
            spaceH4,
            TextFieldValidator(
              hint: 'Enter message',
              onChange: (value) {
                widget.cubit.mapValidate['form'] =
                    _keyForm.currentState?.checkValidator() ?? false;
                widget.cubit.validateAll();
              },
              validator: (value) {
                return widget.cubit.validateMessage(value ?? '');
              },
            ),
            spaceH16,
            Text(
              'Loan amount',
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                16,
                FontWeight.w400,
              ),
            ),
            spaceH4,
            TextFieldValidator(
              hint: 'Loan amount',
              onChange: (value) {
                widget.cubit.mapValidate['form'] =
                    _keyForm.currentState?.checkValidator() ?? false;
                widget.cubit.validateAll();
              },
              validator: (value) {
                return widget.cubit.validateAmount(value ?? '');
              },
              suffixIcon: FormDropDownWidget(
                widthDropDown: 100.w,
                heightDropDown: 300.h,
                listDropDown: widget.cubit.listDropDownToken,
                initValue: widget.cubit.listDropDownToken[0],
                onChange: (Map<String, dynamic> value) {},
              ),
            ),
            spaceH16,
            Text(
              'Duration',
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                16,
                FontWeight.w400,
              ),
            ),
            spaceH4,
            StreamBuilder<bool>(
              initialData: true,
              stream: widget.cubit.isMonthForm,
              builder: (context, snapshot) {
                return TextFieldValidator(
                  hint: 'Duration',
                  onChange: (value) {
                    widget.cubit.mapValidate['form'] =
                        _keyForm.currentState?.checkValidator() ?? false;
                    widget.cubit.validateAll();
                  },
                  suffixIcon: FormDropDownWidget(
                    listDropDown: widget.cubit.listDropDownDuration,
                    initValue: widget.cubit.listDropDownDuration[0],
                    heightDropDown: 150.h,
                    widthDropDown: 100.w,
                    onChange: (value) => {
                      if (value['label'] == 'month')
                        {
                          widget.cubit.isMonthForm.sink.add(true),
                        }
                      else
                        {
                          widget.cubit.isMonthForm.sink.add(false),
                        }
                    },
                  ),
                  validator: (value) {
                    return (snapshot.data ?? true)
                        ? widget.cubit.validateDuration(value ?? '')
                        : widget.cubit.validateDuration(
                            value ?? '',
                            isMonth: false,
                          );
                  },
                );
              },
            ),
            spaceH20,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: Checkbox(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    fillColor: MaterialStateProperty.all(
                        AppTheme.getInstance().fillColor()),
                    activeColor: AppTheme.getInstance().activeColor(),
                    // checkColor: const Colors,
                    onChanged: (value) {},
                    value: true,
                  ),
                ),
                spaceW12,
                SizedBox(
                  width: 287.w,
                  child: Flexible(
                    child: Text(
                      'Login to receive email notifications',
                      style: textNormalCustom(
                        AppTheme.getInstance().whiteColor(),
                        16,
                        FontWeight.w400,
                      ),
                    ),
                  ),
                )
              ],
            ),
            spaceH40,
            const ButtonGold(
              title: 'Request loan',
              isEnable: true,
            )
          ],
        ),
      ),
    );
  }
}
