import 'package:Dfy/presentation/market_place/login/connect_wallet_dialog/ui/connect_wallet_dialog.dart';
import 'package:Dfy/presentation/market_place/login/login_with_email/bloc/login_with_email_cubit.dart';
import 'package:Dfy/presentation/market_place/login/login_with_email/ui/enter_email_screen.dart';
import 'package:Dfy/presentation/pawn/ui/pawn_screen.dart';
import 'package:Dfy/widgets/views/coming_screen.dart';
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
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (context) => const ConnectWalletDialog(
          navigationTo: EnterEmail(),
          isRequireLoginEmail: false,
        ),
      ),
      child: const ComingScreen(),
    );
  }
}
