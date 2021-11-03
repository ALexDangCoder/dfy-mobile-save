import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<WalletScreen> {
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
    return Scaffold(
      body: Container(
        color: Colors.grey,
        child: Center(
          child: TextFormField(
            cursorColor: Colors.white,
            style: const TextStyle(fontSize: 18),
            decoration: const InputDecoration(
              hintText: 'Password',
              border: InputBorder.none,
            ),
            // onFieldSubmitted: ,
          ),
        ),
      ),
    );
  }
}
