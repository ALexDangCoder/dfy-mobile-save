import 'package:flutter/material.dart';

class CustomRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Function() onRefresh;
  final double offset;

  const CustomRefreshIndicator({
    Key? key,
    required this.child,
    required this.onRefresh,
    this.offset = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      edgeOffset: offset,
      onRefresh: () async {
        onRefresh();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: child,
      ),
    );
  }
}
