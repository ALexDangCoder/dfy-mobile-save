import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/select_crypto_collateral/bloc/select_crypto_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectCryptoCollateral extends StatefulWidget {
  const SelectCryptoCollateral({Key? key}) : super(key: key);

  @override
  _SelectCryptoCollateralState createState() => _SelectCryptoCollateralState();
}

class _SelectCryptoCollateralState extends State<SelectCryptoCollateral> {
  late SelectCryptoCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = SelectCryptoCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SelectCryptoCubit, SelectCryptoState>(
      bloc: cubit,
      listener: (context, state) {

      },
      builder: (context, state) {
        return StateStreamLayout(
          retry: () {},
          textEmpty: cubit.message,
          error: AppException(S.current.error, cubit.message),
          stream: cubit.stateStream,
          child: BaseDesignScreen(
            onRightClick: () {
              showModalBottomSheet(
                backgroundColor: Colors.black,
                isScrollControlled: true,
                context: context,
                builder: (_) {
                  //TODO filter
                  return const SizedBox();
                },
              );
            },
            isImage: true,
            title: 'Borrow result',
            text: ImageAssets.ic_filter,
            child: SizedBox(),
          ),
        );
      },
    );
  }
}
