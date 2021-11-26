import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/base_items/base_item.dart';
import 'package:flutter/material.dart';

class OwnerTab extends StatelessWidget {
  const OwnerTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 20,
      itemBuilder: (context, index) {
        return _buildItemOwner(index);
      },
    );
  }

  Widget _buildItemOwner(int index) {
    return BaseItem(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            maxLines: 1,
            text: TextSpan(
              children: [
                TextSpan(
                  text: '0xFE5788eEBaa5fw6fa5f6awf6ac7144fd0'.handleString(),
                  style: richTextWhite.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          spaceH7,
          RichText(
            text: TextSpan(
              text: '1 of 20 on sale for',
              style: textNormalCustom(
                AppTheme.getInstance().textThemeColor(),
                14,
                FontWeight.w400,
              ),
              children: [
                TextSpan(
                  text: ' 100 ETH ',
                  style: textNormalCustom(
                    AppTheme.getInstance().fillColor(),
                    14,
                    FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: 'each',
                  style: textNormalCustom(
                    AppTheme.getInstance().textThemeColor(),
                    14,
                    FontWeight.w400,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
