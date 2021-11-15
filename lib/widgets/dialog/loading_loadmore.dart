import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';

class LoadingItem extends StatelessWidget {
  const LoadingItem({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppTheme.getInstance().primaryColor(),
      ),
    );
  }
}
