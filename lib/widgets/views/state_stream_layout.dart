import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/widgets/views/state_layout.dart';
import 'package:flutter/material.dart';

class StateStreamLayout extends StatelessWidget {
  final Stream<StateLayout> stream;
  final Widget child;
  final AppException error;
  final Function() retry;
  final dynamic textEmpty;
  final bool? isBack;

  const StateStreamLayout({
    required this.stream,
    required this.child,
    required this.error,
    required this.retry,
    required this.textEmpty,
    Key? key,
    this.isBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StateLayout>(
      stream: stream,
      builder: (context, snapshot) {
        return StateFullLayout(
          isBack: isBack,
          retry: retry,
          textEmpty: textEmpty,
          stateLayout: snapshot.data ?? StateLayout.showLoading,
          error: error,
          child: child,
        );
      },
    );
  }
}
