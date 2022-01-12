import 'package:flutter/material.dart';

class ExpansionTitleCustom extends StatefulWidget {
  final Widget child;
  final bool expand;
  final Widget title;
  final Function onChangeExpand;

  const ExpansionTitleCustom({
    Key? key,
    this.expand = false,
    required this.child,
    required this.title, required this.onChangeExpand,
  }) : super(key: key);

  @override
  _ExpansionTitleCustomState createState() => _ExpansionTitleCustomState();
}

class _ExpansionTitleCustomState extends State<ExpansionTitleCustom>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
  }

  ///Setting up the animation
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
    if (widget.expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void didUpdateWidget(ExpansionTitleCustom oldWidget) {
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
            widget.onChangeExpand();
          },
          child: widget.title,
        ),
        SizeTransition(
            axisAlignment: 1.0, sizeFactor: animation, child: widget.child),
      ],
    );
  }
}
