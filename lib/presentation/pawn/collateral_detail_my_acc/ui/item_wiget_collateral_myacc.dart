import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ItemWidgetCollateralMyAcc extends StatefulWidget {
  const ItemWidgetCollateralMyAcc({
    Key? key,
    required this.child,
    required this.title,
    required this.isBoolAdd,
  }) : super(key: key);
  final Widget child;
  final List<Widget> title;
  final BehaviorSubject<bool> isBoolAdd;

  @override
  _ItemWidgetCollateralMyAccState createState() =>
      _ItemWidgetCollateralMyAccState();
}

class _ItemWidgetCollateralMyAccState extends State<ItemWidgetCollateralMyAcc>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
  }

  void prepareAnimations() {
    expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() {
    if (widget.isBoolAdd.value) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void didUpdateWidget(ItemWidgetCollateralMyAcc oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            widget.isBoolAdd.add(!widget.isBoolAdd.value);
          },
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [...widget.title],
                ),
              ),
              Align(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Text(
                    widget.isBoolAdd.value ? '_' : '+',
                    style: textNormalCustom(
                      AppTheme.getInstance().titleTabColor(),
                      34,
                      FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizeTransition(
          axisAlignment: 1.0,
          sizeFactor: animation,
          child: widget.child,
        ),
      ],
    );
  }
}
