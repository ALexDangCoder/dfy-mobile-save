import 'package:Dfy/presentation/market_place/create_collection/bloc/bloc.dart';
import 'package:Dfy/presentation/market_place/create_collection/ui/create_collection_screen.dart';
import 'package:flutter/material.dart';

class StakingScreen extends StatefulWidget {
  const StakingScreen({Key? key}) : super(key: key);

  @override
  _StakingState createState() => _StakingState();
}

class _StakingState extends State<StakingScreen> {
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
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                // builder: (context) => const UploadProgress(),
                builder: (context) => CreateCollectionScreen(
                      bloc: CreateCollectionBloc(),
                ),
              ),
            );
          },
          child: const Text('CREATE COLLECTION'),
        ),
      ),
    );
  }
}
