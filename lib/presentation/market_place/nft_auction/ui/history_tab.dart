import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/history_nft.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/base_items/base_item.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({Key? key, required this.listHistory}) : super(key: key);
  final List<HistoryNFT> listHistory;

  @override
  _HistoryTabState createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.listHistory.isEmpty) {
      return Center(
        child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 100.h),
              children: [
                Center(
                  child: sizedPngImage(
                    w: 94,
                    h: 94,
                    image: ImageAssets.icNoTransaction,
                  ),
                ),
                Center(
                  child: Text(
                    S.current.no_transaction,
                    style: tokenDetailAmount(
                      color: AppTheme.getInstance().currencyDetailTokenColor(),
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
      );
    } else {
      return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.listHistory.length,
            itemBuilder: (context, index) {
              return _buildItemHistory(index);
            },
          );
    }
  }
}

Widget _buildItemHistory(int index) {
  return BaseItem(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Put on sale',
              style: textNormalCustom(
                Colors.white,
                14,
                FontWeight.w700,
              ),
            ),
            spaceH7,
            Text(
              'Create 10 of 10',
              style: textNormalCustom(
                const Color(0xffE4E4E4),
                14,
                FontWeight.w400,
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              '10:35 - 10/11/2021',
              style: textNormalCustom(
                const Color(0xffE4E4E4),
                14,
                FontWeight.w400,
              ),
            )
          ],
        ),
      ],
    ),
  );
}
