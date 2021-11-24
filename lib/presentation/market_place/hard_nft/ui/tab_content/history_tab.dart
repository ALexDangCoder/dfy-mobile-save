import 'package:Dfy/generated/l10n.dart';
import 'package:flutter/material.dart';
class HistoryTabContent extends StatelessWidget {
  final String object;
  const HistoryTabContent({Key? key, required this.object}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Text(S.current.history),
      ),
    );
  }
}
