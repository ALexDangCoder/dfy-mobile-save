import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';

class ValidateTextBase extends StatefulWidget {
  const ValidateTextBase({
    Key? key,
    required this.textEditingController,
    required this.textValidate,
  }) : super(key: key);
  final TextEditingController textEditingController;
  final String textValidate;

  @override
  _ValidateTextBaseState createState() => _ValidateTextBaseState();
}

class _ValidateTextBaseState extends State<ValidateTextBase> {
  @override
  void initState() {
    widget.textEditingController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.textEditingController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: widget.textValidate.isNotEmpty
          ? Text(
              widget.textValidate,
              style: textNormal(
                AppTheme.getInstance().redColor(),
                12,
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
