import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';
import 'package:Dfy/domain/model/pawn/personal_lending.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/borrow_result/bloc/borrow_result_cubit.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BorrowResult extends StatefulWidget {
  const BorrowResult({Key? key}) : super(key: key);

  @override
  _BorrowResultState createState() => _BorrowResultState();
}

class _BorrowResultState extends State<BorrowResult> {

  late BorrowResultCubit cubit;

  String message = '';
  final List<PawnshopPackage> pawnshopPackage = [];
  final List<PersonalLending> personalLending = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = BorrowResultCubit();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BorrowResultCubit,BorrowResultState>(
      bloc: cubit,
      listener: (context,state){
        if(state is BorrowResultLoading){

        }

        if(state is BorrowPersonSuccess){
          //refresh => clear list
          personalLending.addAll(state.personalLending ?? []);
          if(state.completeType == CompleteType.ERROR){
            message = state.message ?? '';
          }
        }
        if(state is BorrowPawnshopSuccess){
          //refresh => clear list
          pawnshopPackage.addAll(state.pawnshopPackage ?? []);
          if(state.completeType == CompleteType.ERROR){
            message = state.message ?? '';
          }
        }
      },
      builder: (context,state){
        return StateStreamLayout(
          retry: () {},
          textEmpty: message,
          error: AppException(S.current.error, message),
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
              child: SingleChildScrollView(
                child: Row(
                  children: [
                    //ListView
                    //ListView
                  ],
                ),
              ),
          ),
        );
      },
    );
  }
}
