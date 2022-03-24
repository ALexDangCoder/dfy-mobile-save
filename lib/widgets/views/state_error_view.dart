import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/style_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StateErrorView extends StatelessWidget {
  final String? _message;
  final Function() _retry;
  final bool? isHaveBackBtn;

  const StateErrorView(this._message, this._retry,
      {this.isHaveBackBtn = true, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getInstance().bgBtsColor(),
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: AppTheme.getInstance().bgBtsColor(),
        leading: (isHaveBackBtn ?? true)
            ? GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(ImageAssets.ic_back),
              )
            : Container(),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 54.h,
              width: 54.w,
              child: Image.asset(ImageAssets.err_load_nft),
            ),
            spaceH12,
            Text(
              _message ?? S.of(context).something_went_wrong,
              style: textStyle(),
            ),
            spaceH15,
            InkWell(
              onTap: _retry,
              child: SizedBox(
                height: 54.h,
                width: 54.w,
                child: Image.asset(ImageAssets.reload_nft),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
