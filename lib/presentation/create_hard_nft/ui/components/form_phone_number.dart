import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/widgets/text/text_from_field_group/form_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class FormPhoneNumber extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final bool isEnabled;
  final Function(String)? onChange;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final int maxLine;
  final String? hint;
  final String? suffixText;
  final String? prefixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int maxInputChar;
  final double? errorTextHeight;
  final bool readOnly;

  const FormPhoneNumber({
    Key? key,
    this.controller,
    this.isEnabled = true,
    this.onChange,
    this.validator,
    this.initialValue,
    this.maxLine = 1,
    this.textInputType,
    this.readOnly = false,
    this.hint,
    this.suffixText,
    this.prefixText,
    this.prefixIcon,
    this.suffixIcon,
    this.maxInputChar = 256,
    this.errorTextHeight,
  }) : super(key: key);

  @override
  _FormPhoneNumberState createState() => _FormPhoneNumberState();
}

class _FormPhoneNumberState extends State<FormPhoneNumber> {
  final key = GlobalKey<FormState>();
  FormProvider? formProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    formProvider = FormProvider.of(context);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (formProvider != null) {
        if (widget.validator != null) {
          final validator =
              widget.validator!(widget.controller?.text ?? '') == null;
          formProvider?.validator.addAll({key: validator});
        } else {
          formProvider?.validator.addAll({key: true});
        }
      }
    });
    if (formProvider != null) {
      formProvider?.validator.addAll({key: true});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.w,
      ),
      child: Form(
        key: key,
        child: InternationalPhoneNumberInput(

          onInputChanged: (PhoneNumber number) {
            print(number.phoneNumber);
          },
          onInputValidated: (bool value) {
            print(value);
          },
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          ignoreBlank: true,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          selectorTextStyle: TextStyle(color: Colors.black),
          textFieldController: widget.controller,
          formatInput: false,
          keyboardType:
              TextInputType.numberWithOptions(signed: true, decimal: true),
          inputBorder: OutlineInputBorder(),
          onSaved: (PhoneNumber number) {
            print('On Saved: $number');
          },
          inputDecoration: InputDecoration(
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.r),
              ),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.r),
              ),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.r),
              ),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.r),
              ),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.r),
              ),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            fillColor: AppTheme.getInstance().backgroundBTSColor(),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 18.w, vertical: 21.h),
            counterText: '',
            hintText: widget.hint,
            hintStyle: textNormal(
              Colors.white.withOpacity(0.5),
              16,
            ),
            errorStyle: errorText(
              h: widget.errorTextHeight,
              color: widget.errorTextHeight != null
                  ? Colors.transparent
                  : AppTheme.getInstance().redColor(),
            ),
            suffixStyle: textCustom(),
            suffixText: widget.suffixText,
            prefixText: widget.prefixText,
            border: InputBorder.none,
            suffixIcon: widget.suffixIcon,
            prefixIcon: widget.prefixIcon,
          ),
        ),
      ),
    );
  }
}
