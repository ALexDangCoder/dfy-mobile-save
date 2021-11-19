import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  return Container(
    height: 55.h,
    decoration: BoxDecoration(
      color: Colors.transparent,
      border: Border(
        bottom: BorderSide(
          color: AppTheme.getInstance().divideColor(),
        ),
      ),
    ),
    child: Text('$index'),
  );
}
