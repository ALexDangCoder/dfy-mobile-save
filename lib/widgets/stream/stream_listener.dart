import 'package:flutter/material.dart';

class StreamListenerCustom<T> extends StatefulWidget {
  final Stream<T> stream;
  final Function(T) listen;
  final Widget child;

  const StreamListenerCustom({
    Key? key,
    required this.listen,
    required this.stream,
    required this.child,
  }) : super(key: key);

  @override
  State<StreamListenerCustom<T>> createState() =>
      _StreamListenerCustomState<T>();
}

class _StreamListenerCustomState<T> extends State<StreamListenerCustom<T>> {
  @override
  void initState() {
    super.initState();
    widget.stream.listen((event) {
      widget.listen(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
