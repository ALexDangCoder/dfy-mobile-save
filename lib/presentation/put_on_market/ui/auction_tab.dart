import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/put_on_market/bloc/put_on_market_cubit.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/form/input_with_select_type.dart';
import 'package:flutter/material.dart';

class AuctionTab extends StatefulWidget {

  final PutOnMarketCubit cubit;
  const AuctionTab({Key? key, required this.cubit}) : super(key: key);

  @override
  _AuctionTabState createState() => _AuctionTabState();
}

class _AuctionTabState extends State<AuctionTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:  AppTheme.getInstance().bgBtsColor(),
      body: GestureDetector(

        onTap: () {
          final FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    SizedBox(
                      height: 50,
                    ),
                    //InputWithSelectType(typeInput: [],)
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: ButtonGold(
                title: S.current.continue_s,
                isEnable: true,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(
              height: 38,
            )
          ],
        ),
      ),
    );
  }
}
