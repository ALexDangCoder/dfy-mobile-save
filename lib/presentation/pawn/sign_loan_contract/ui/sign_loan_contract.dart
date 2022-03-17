import 'package:Dfy/presentation/pawn/sign_loan_contract/bloc/sign_loan_contract_cubit.dart';
import 'package:flutter/material.dart';
class SignLoanContract extends StatefulWidget {
  const SignLoanContract({Key? key}) : super(key: key);

  @override
  _SignLoanContractState createState() => _SignLoanContractState();
}

class _SignLoanContractState extends State<SignLoanContract> {

  late SignLoanContractCubit cubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = SignLoanContractCubit();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
