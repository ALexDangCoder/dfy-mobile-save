import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/market_place/login/connect_wallet_dialog/ui/connect_wallet_dialog.dart';
import 'package:Dfy/presentation/pawn/sign_loan_contract/bloc/sign_loan_contract_cubit.dart';
import 'package:Dfy/presentation/pawn/sign_loan_contract/ui/crypto_loan_contract.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SignLoanContract extends StatefulWidget {
  const SignLoanContract({Key? key, required this.pawnshopPackage})
      : super(key: key);

  final PawnshopPackage pawnshopPackage;

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
    cubit.collateralAccepted = widget.pawnshopPackage.acceptableAssetsAsCollateral ?? [];
    cubit.pawnshopPackage = widget.pawnshopPackage;
    trustWalletChannel
        .setMethodCallHandler(cubit.nativeMethodCallBackTrustWallet);
    cubit.getLoginState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
      title: 'Sign loan contract',
      child: BlocConsumer<SignLoanContractCubit, SignLoanContractState>(
        bloc: cubit,
        listener: (context, state) {
          if (state is NoLogin) {
            showDialog(
              context: context,
              builder: (context) => const ConnectWalletDialog(
                isRequireLoginEmail: true,
              ),
            ).then((_) => cubit.getLoginState());
          }
        },
        builder: (context, state) {
          if (state is GetWalletSuccess) {
            return CryptoLoanContract(
              cubit: cubit,
              pawnshopPackage: widget.pawnshopPackage,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.r,
                color: Colors.white,
              ),
            );
          }
        },
      ),
    );
  }
}
