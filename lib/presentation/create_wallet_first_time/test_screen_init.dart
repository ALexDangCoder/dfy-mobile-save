import 'package:Dfy/presentation/create_wallet_first_time/setup_password/ui/setup_password.dart';
import 'package:Dfy/presentation/send_token_nft/ui/send_nft/send_nft.dart';
import 'package:Dfy/presentation/send_token_nft/ui/send_token/send_token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TestScreenUtils extends StatelessWidget {
  const TestScreenUtils({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () {
        return MaterialApp(
          home: Scaffold(
            body: Center(
              child: ElevatedButton(
                child: const Text('CLICKME'),
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (context) => const SendToken(),
                    // builder: (context) => const AddWalletFtSeedPharse(
                    // ),
                    context: context,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
