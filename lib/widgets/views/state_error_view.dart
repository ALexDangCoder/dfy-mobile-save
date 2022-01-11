import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/style_utils.dart';
import 'package:Dfy/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StateErrorView extends StatelessWidget {
  final String? _message;
  final Function() _retry;

  const StateErrorView(this._message, this._retry, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}
