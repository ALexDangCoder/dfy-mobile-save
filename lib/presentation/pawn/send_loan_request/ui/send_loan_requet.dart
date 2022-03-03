import 'package:Dfy/presentation/pawn/send_loan_request/bloc/send_loan_request_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:flutter/material.dart';

class SendLoanRequest extends StatefulWidget {
  const SendLoanRequest({Key? key}) : super(key: key);

  @override
  _SendLoanRequestState createState() => _SendLoanRequestState();
}

class _SendLoanRequestState extends State<SendLoanRequest> {
  late SendLoanRequestCubit cubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = SendLoanRequestCubit();
  }
  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
        onRightClick: () {
          ///Pop
        },
        isImage: true,
        title: 'Send loan request',
        text: ImageAssets.ic_close,
        child: Container(),
    );
  }
}
