import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CloseTextBase extends StatefulWidget {
  final TextEditingController textEditingController;

  const CloseTextBase({
    Key? key,
    required this.textEditingController,
  }) : super(key: key);

  @override
  _CloseTextBaseState createState() => _CloseTextBaseState();
}

class _CloseTextBaseState extends State<CloseTextBase> {
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
    return GestureDetector(
      onTap: () {
        widget.textEditingController.text = '';
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: widget.textEditingController.text.isNotEmpty
          ? Image.asset(
              ImageAssets.ic_close,
              width: 20.w,
              height: 20.h,
            )
          : SizedBox(
              height: 20.h,
              width: 20.w,
            ),
    );
  }
}
