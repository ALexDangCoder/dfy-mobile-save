import 'package:Dfy/presentation/pawn/borrow_lend/ui/borrow_lend.dart';
import 'package:Dfy/widgets/views/coming_screen.dart';
import 'package:flutter/material.dart';

class PawnScreen extends StatefulWidget {
  const PawnScreen({Key? key}) : super(key: key);

  @override
  _PawnState createState() => _PawnState();
}

class _PawnState extends State<PawnScreen> {
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
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return BorrowLendScreen();
          },
        ));
      },
      child: const ComingScreen(),
    );
  }
}
