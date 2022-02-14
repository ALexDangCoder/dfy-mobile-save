import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/widgets/views/coming_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PawnScreen extends StatefulWidget {
  const PawnScreen({Key? key}) : super(key: key);

  @override
  _PawnState createState() => _PawnState();
}

class _PawnState extends State<PawnScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersive, overlays: [SystemUiOverlay.top],);
    return const ComingScreen();
  }
}
