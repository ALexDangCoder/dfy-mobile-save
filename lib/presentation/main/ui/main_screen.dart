import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/bloc_creare_seedphrase.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/ui/show_create_seedphrase1.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

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
    trustWalletChannel.setMethodCallHandler(
        widget.bLocCreateSeedPhrase.nativeMethodCallBackTrustWallet);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
              onPressed: () {
                showCreateSeedPhrase1(context, BLocCreateSeedPhrase());
              },
              icon: const Icon(Icons.padding))
        ],
      ),
    );
  }
}
