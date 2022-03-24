import 'dart:convert';

import 'package:rxdart/subjects.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

enum WebSocketCMD {
  bid_auction,
}

class WebSocket {
  late IOWebSocketChannel _channel;
  final String token;
  late Timer _timerForInter;
  final String webSocketCmd;

  BehaviorSubject<String> _socketDataSubject = BehaviorSubject<String>();

  Stream<String> get socketDataStream => _socketDataSubject.stream;

  WebSocket(this.token, this.webSocketCmd) {
    _channel = IOWebSocketChannel.connect(
        Uri.parse('wss://dev2.socket.defiforyou.uk/ws?token=$token'));
    _timerForInter = Timer.periodic(const Duration(seconds: 5), (timer) {
      _channel.sink.add('emit data');
    });
    _channel.stream.listen((event) {
      final Map<String, dynamic> socketData = jsonDecode(event);
      print('map $socketData');
      if (socketData['cmd'] == 'bid_auction') {
        _socketDataSubject.sink.add(socketData['data']);
      }
    });
  }

  void dispose() {
    _channel.sink.close();
    _timerForInter.cancel();
  }
}
