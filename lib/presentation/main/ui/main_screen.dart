import 'package:Dfy/widgets/show_modal_bottomsheet/show_bottom_sheet.dart';
import 'package:Dfy/widgets/show_modal_bottomsheet/show_create_seedphrare2.dart';
import 'package:Dfy/widgets/show_modal_bottomsheet/show_create_seedphrase1.dart';
import 'package:Dfy/widgets/show_modal_bottomsheet/show_create_successfully.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
              onPressed: () {
                showCreateSeedPhrase2(context);
              },
              icon: const Icon(Icons.padding))
        ],
      ),
    );
  }
}
