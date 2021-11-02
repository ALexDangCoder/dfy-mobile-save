import 'package:Dfy/config/base/state_base.dart';
import 'package:Dfy/presentation/example_view/bloc/example_cubit.dart';
import 'package:flutter/material.dart';

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({Key? key}) : super(key: key);

  @override
  BaseState<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends BaseState<ExampleScreen> {
  late ExampleCubit _cubit;

  //Calendar choose
  DateTime selected = DateTime.now();
  DateTime rangeStart = DateTime.now();
  DateTime rangeEnd = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _cubit = ExampleCubit();
  }

  @override
  void dispose() {
    super.dispose();
    _cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [],
      ),
    );
  }
}
