import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputNumberOfQuantity extends StatefulWidget {
  final bool? canEdit;
  final int? quantity;
  final Function? onchangeText;
  final int? maxLength;

  const InputNumberOfQuantity(
      {Key? key,
      this.canEdit = false,
      this.quantity = 1,
      this.onchangeText,
      this.maxLength = 25,})
      : super(key: key);

  @override
  _InputNumberOfQuantityState createState() => _InputNumberOfQuantityState();
}

class _InputNumberOfQuantityState extends State<InputNumberOfQuantity> {
  final editTextController = TextEditingController();
  final _focusNode = FocusNode();
  int currentValue = 1;

  @override
  void initState() {
    editTextController.text = '1 of 1';
    // TODO: implement initState
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        editTextController.text = '$currentValue of ${widget.quantity}';
      } else {
        editTextController.text = '$currentValue';
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    editTextController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: AppTheme.getInstance().backgroundBTSColor(),),
      height: 64,
      child: Center(
        child: TextField(
          enabled: widget.canEdit ?? false,
          focusNode: _focusNode,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          controller: editTextController,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            if (widget.onchangeText != null) {
              setState(() {
                currentValue = int.parse(value);
                if (currentValue > (widget.quantity ?? 1)) {
                  currentValue = widget.quantity ?? 1;
                }
              });
              widget.onchangeText!(value);
            }
          },
          cursorColor: AppTheme.getInstance().whiteColor(),
          style: textNormalCustom(
            AppTheme.getInstance().textThemeColor(),
            16,
            FontWeight.w400,
          ),
          maxLength: widget.maxLength ?? 25,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 18),
            counterText: '',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
