import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/manage_loan_package/bloc/manage_loan_package_cubit.dart';
import 'package:Dfy/presentation/pawn/my_acc_lender/manage_loan_package/create_new_loan_package/bloc/create_new_loan_package_cubit.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LendingSetting extends StatefulWidget {
  const LendingSetting({Key? key, required this.cubit,}) : super(key: key);
  final ManageLoanPackageCubit cubit;

  @override
  _LendingSettingState createState() => _LendingSettingState();
}

class _LendingSettingState extends State<LendingSetting> {

  late TextEditingController _txtInterestMinAPR;
  late TextEditingController _txtInterestMaxAPR;

  @override
  void initState() {
    super.initState();
    _txtInterestMaxAPR = TextEditingController();
    _txtInterestMinAPR = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
      title: 'Lending setting',
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _formWithOutDropDown(
                  controller: _txtInterestMinAPR,
                  txtInputType:
                  const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  onChange: (value) {
                    // cubit.validateAmount(
                    //   value,
                    //   _txtLoanAmountMax.text,
                    // );
                    // cubit.validateAmount(
                    //   _txtLoanAmountMax.text,
                    //   value,
                    //   isMinLoan: false,
                    // );
                    // cubit.validateAll();
                  },
                  hintText: 'Min',
                  streamValidateText:
                  widget.cubit.txtWarningInterestMin.stream,
                ),
              ),
              spaceW16,
              Expanded(
                child: _formWithOutDropDown(
                  controller: _txtInterestMaxAPR,
                  txtInputType:
                  const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  onChange: (value) {
                    // cubit.validateAmount(
                    //   value,
                    //   _txtLoanAmountMin.text,
                    //   isMinLoan: false,
                    // );
                    // cubit.validateAmount(
                    //     _txtLoanAmountMin.text, value);
                    // cubit.validateAll();
                  },
                  hintText: 'Max',
                  streamValidateText:
                  widget.cubit.txtWarningInterestMin.stream,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _formWithOutDropDown({
    required TextEditingController controller,
    required Function(String value) onChange,
    required String hintText,
    required Stream<String> streamValidateText,
    TextInputType? txtInputType,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 64.h,
          padding: EdgeInsets.only(right: 15.w, left: 15.w),
          decoration: BoxDecoration(
            color: AppTheme.getInstance().backgroundBTSColor(),
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
          ),
          child: Center(
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              keyboardType: txtInputType,
              controller: controller,
              maxLength: 100,
              onChanged: (value) {
                onChange(value);
              },
              cursorColor: AppTheme.getInstance().whiteColor(),
              style: textNormal(
                AppTheme.getInstance().whiteColor(),
                16,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                isCollapsed: true,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                counterText: '',
                hintText: hintText,
                hintStyle: textNormal(
                  AppTheme.getInstance().whiteWithOpacityFireZero(),
                  16,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        spaceH4,
        StreamBuilder<String>(
          stream: streamValidateText,
          builder: (context, snapshot) {
            return Text(
              snapshot.data ?? '',
              style: textNormalCustom(
                AppTheme.getInstance().redColor(),
                12,
                FontWeight.w400,
              ),
            );
          },
        ),
      ],
    );
  }
}

