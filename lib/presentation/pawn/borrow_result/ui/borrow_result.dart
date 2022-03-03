import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';
import 'package:Dfy/domain/model/pawn/personal_lending.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/borrow_result/bloc/borrow_result_cubit.dart';
import 'package:Dfy/presentation/pawn/borrow_result/ui/pawnshop_package_item.dart';
import 'package:Dfy/presentation/pawn/borrow_result/ui/personal_lending_item.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    cubit.callApi();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BorrowResultCubit, BorrowResultState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is BorrowResultLoading) {}

        if (state is BorrowPersonSuccess) {
          //refresh => clear list
          personalLending.addAll(state.personalLending ?? []);
          if (state.completeType == CompleteType.ERROR) {
            message = state.message ?? '';
          }
        }
        if (state is BorrowPawnshopSuccess) {
          //refresh => clear list
          pawnshopPackage.addAll(state.pawnshopPackage ?? []);
          if (state.completeType == CompleteType.ERROR) {
            message = state.message ?? '';
          }
        }
      },
      builder: (context, state) {
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
            child: SizedBox(
              height: 710.h,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spaceH24,
                    Padding(
                      padding:  EdgeInsets.only(left: 16.w,right: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'PERSONAL LENDING',
                            style: textNormalCustom(
                              purple,
                              20,
                              FontWeight.w400,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 32.h,
                              decoration: const BoxDecoration(
                                color: borderItemColors,
                                shape: BoxShape.circle,
                              ),
                              child: Image(
                                height: 32.h,
                                width: 32.w,
                                image: const AssetImage(
                                  ImageAssets.img_push,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    spaceH16,
                    SizedBox(
                      height: 246.h,
                      child: ListView.builder(
                        padding: EdgeInsets.only(left: 16.w),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: personalLending.length > 6
                            ? 6
                            : personalLending.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: [
                              PersonalLendingItem(
                                personalLending: personalLending[index],
                              ),
                              spaceW20,
                            ],
                          );
                        },
                      ),
                    ),
                    spaceH32,
                    Padding(
                      padding:  EdgeInsets.only(left: 16.w,right: 16.w),
                      child: Text(
                        'PAWNSHOP PACKAGE',
                        style: textNormalCustom(
                          purple,
                          20,
                          FontWeight.w400,
                        ),
                      ),
                    ),
                    spaceH16,
                    SizedBox(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(left: 16.w,right: 16.w),
                        shrinkWrap: true,
                        itemCount: pawnshopPackage.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              PawnshopPackageItem(
                                pawnshopPackage: pawnshopPackage[index],
                              ),
                              spaceH20,
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
