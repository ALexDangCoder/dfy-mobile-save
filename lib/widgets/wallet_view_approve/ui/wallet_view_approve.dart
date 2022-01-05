import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';

class WalletViewApprove extends StatefulWidget {
  const WalletViewApprove({Key? key}) : super(key: key);

  @override
  _WalletViewApproveState createState() => _WalletViewApproveState();
}

class _WalletViewApproveState extends State<WalletViewApprove> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppTheme.getInstance().bgBtsColor(),
        boxShadow: [
          BoxShadow(
              color: AppTheme.getInstance().divideColor(), spreadRadius: 1),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.red,
            ),
            margin: const EdgeInsets.only(right: 8, top: 2, bottom: 2),
            height: 40,
            width: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [Text('Test wallet'), Text('09090..89080', overflow: TextOverflow.ellipsis,)],
              ),
              const Text('Balance : 08880u bnb')
            ],
          )
        ],
      ),
    );
  }
}
