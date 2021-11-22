import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/widgets/base_items/base_item.dart';
import 'package:flutter/material.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return _buildItemHistory(index);
      },
    );
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
  ));
}
