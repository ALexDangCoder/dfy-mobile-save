import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/select_crypto_collateral/bloc/select_crypto_cubit.dart';
import 'package:Dfy/presentation/pawn/select_crypto_collateral/ui/item_crypto_collateral.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectCryptoCollateral extends StatefulWidget {
  const SelectCryptoCollateral({
    Key? key,
    required this.walletAddress,
    required this.packageId,
  }) : super(key: key);

  final String walletAddress;
  final String packageId;

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
    cubit.refreshPosts(widget.walletAddress, widget.packageId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SelectCryptoCubit, SelectCryptoState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is GetApiSuccess) {
          if (state.completeType == CompleteType.SUCCESS) {
            if (cubit.loadMoreRefresh) {
              cubit.listCryptoCollateral.clear();
            }
            if ((state.list ?? []).isEmpty) {
              cubit.showEmpty();
            } else {
              cubit.showContent();
            }
          } else {
            cubit.message = state.message ?? '';
            cubit.listCryptoCollateral.clear();
            cubit.showError();
          }
          cubit.listCryptoCollateral.addAll(state.list ?? []);
          cubit.canLoadMore = cubit.listCryptoCollateral.length >=
              ApiConstants.DEFAULT_PAGE_SIZE;
          cubit.loadMoreLoading = false;
        }
      },
      builder: (context, state) {
        return StateStreamLayout(
          retry: () {
            cubit.refreshPosts(widget.walletAddress, widget.packageId);
          },
          textEmpty: cubit.message,
          error: AppException(S.current.error, cubit.message),
          stream: cubit.stateStream,
          child: BaseDesignScreen(
            title: 'Select crypto collateral',
            child: SizedBox(
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (cubit.canLoadMore &&
                      scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                    cubit.loadMorePosts(
                      widget.walletAddress,
                      widget.packageId,
                    );
                  }
                  return true;
                },
                child: RefreshIndicator(
                  onRefresh: () async {
                    await cubit.refreshPosts(
                      widget.walletAddress,
                      widget.packageId,
                    );
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                    ),
                    itemCount: cubit.listCryptoCollateral.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          ItemCryptoCollateral(
                            model: cubit.listCryptoCollateral[index],
                          ),
                          spaceH20,
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
