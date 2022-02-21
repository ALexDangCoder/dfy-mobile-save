import 'package:flutter/material.dart';

class ProgressBarProcess extends StatefulWidget {
  const ProgressBarProcess({Key? key}) : super(key: key);

  @override
  _ProgressBarProcessState createState() => _ProgressBarProcessState();
}

class _ProgressBarProcessState extends State<ProgressBarProcess>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 1000),
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController)
    ..addListener(() {
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
