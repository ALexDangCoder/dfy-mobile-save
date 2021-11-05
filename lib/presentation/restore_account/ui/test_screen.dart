import 'package:Dfy/presentation/bottom_sheet_receive_token/ui/bts_receive_dfy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: () => Center(
          child: ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) => const ReceiveDFY(
                  walletAddress: '0xafwfakfaowofamcmacaocoacoacmacmac',
                ),
              );
            },
            child: const Text('Click'),
          ),
        ),
      ),
    );
  }
}
