import 'package:Dfy/widgets/show_modal_bottomsheet/bloc/bloc_creare_seedphrase.dart';
import 'package:Dfy/widgets/show_modal_bottomsheet/show_create_seedphrare2.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final BLocCreateSeedPhrase bLocCreateSeedPhrase;

   const MainScreen({Key? key, required this.bLocCreateSeedPhrase})
      : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // widget.bLocCreateSeedPhrase.getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
              onPressed: () {
                showCreateSeedPhrase2(context,widget.bLocCreateSeedPhrase);
              },
              icon: const Icon(Icons.padding))
        ],
      ),
    );
  }
}
