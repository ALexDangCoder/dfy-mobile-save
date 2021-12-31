import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:Dfy/widgets/views/row_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OfferDetailScreen extends StatelessWidget {
  const OfferDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      title: S.current.offer_detail,
      isImage: true,
      text: ImageAssets.ic_close,
      onRightClick: () {},
      child: Column(
        children: [
          spaceH20,
          Text(
            '0x9f69a6cbe17d26d86df0fc216bf632083a02a135'.formatAddressWallet(),
            style: richTextWhite.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          spaceH8,
          _rowStar(100),
          spaceH18,
          _textButton(),
          Divider(
            color: AppTheme.getInstance().divideColor(),
          ),
          spaceH20,
          ..._buildTable,
        ],
      ),
    );
  }

  List<Widget> get _buildTable => [
        buildRow(
          title: S.current.status,
          detail: 'Open',
          type: TextType.NORMAL,
        ),
        spaceH16,
        buildRow(
          title: S.current.status,
          detail: 'Open',
          type: TextType.NORMAL,
        ),
        spaceH16,
        buildRow(
          title: S.current.status,
          detail: 'Open',
          type: TextType.NORMAL,
        ),
        spaceH16,
        buildRow(
          title: S.current.status,
          detail: 'Open',
          type: TextType.NORMAL,
        ),
        spaceH16,
        buildRow(
          title: S.current.status,
          detail: 'Open',
          type: TextType.NORMAL,
        ),
        spaceH16,
        buildRow(
          title: S.current.status,
          detail: 'Open',
          type: TextType.NORMAL,
        ),
        spaceH16,
        buildRow(
          title: S.current.status,
          detail: 'Open',
          type: TextType.NORMAL,
        ),
        spaceH16,
      ];

  Widget _rowStar(int mark) {
    return Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImageAssets.ic_star),
          spaceW12,
          Text(
            '$mark',
            style: textNormalCustom(
              AppTheme.getInstance().textThemeColor(),
              32,
              FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _textButton() {
    return TextButton(
        onPressed: () {},
        child: Text(
          S.current.view_profile,
          style: textNormalCustom(
            AppTheme.getInstance().fillColor(),
            16,
            FontWeight.normal,
          ),
        ));
  }
}
