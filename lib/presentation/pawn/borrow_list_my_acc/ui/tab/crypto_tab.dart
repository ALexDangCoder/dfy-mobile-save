import 'package:Dfy/presentation/pawn/borrow_list_my_acc/bloc/borrow_list_my_acc_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../item_crypto.dart';

class CryptoTab extends StatefulWidget {
  const CryptoTab({
    Key? key,
    required this.bloc,
  }) : super(key: key);
  final BorrowListMyAccBloc bloc;

  @override
  _CryptoTabState createState() => _CryptoTabState();
}

class _CryptoTabState extends State<CryptoTab> {
  @override
  void initState() {
    super.initState();
    widget.bloc.getBorrowContract(
      type: BorrowListMyAccBloc.BORROW_TYPE,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => ItemCrypto(),
      ),
    );
  }
}
