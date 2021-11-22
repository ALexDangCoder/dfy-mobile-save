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
    child: Text('$index'),
  );
}
