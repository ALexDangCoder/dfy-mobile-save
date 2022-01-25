import 'package:flutter/material.dart';

class StreamConsumerCustom<T> extends StatefulWidget {
  final Stream<T> stream;
  final Function(T) listen;
  final Widget Function(BuildContext context, AsyncSnapshot<T> snapshot) builder;
  const StreamConsumerCustom({
    Key? key,
    required this.listen,
    required this.stream,
    required this.builder,

  }) : super(key: key);

  @override
  State<StreamConsumerCustom<T>> createState() =>
      _StreamConsumerCustomState<T>();
}

class _StreamConsumerCustomState<T> extends State<StreamConsumerCustom<T>> {
  @override
  void initState() {
    super.initState();
    widget.stream.listen((event) {
      widget.listen(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(builder: widget.builder,stream: widget.stream,);
  }
}
