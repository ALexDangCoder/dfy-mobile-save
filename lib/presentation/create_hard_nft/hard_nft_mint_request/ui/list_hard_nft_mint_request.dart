import 'dart:async';

import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/hard_nft_mint_request.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/hard_nft_mint_request/bloc/hard_nft_mint_request_cubit.dart';
import 'package:Dfy/presentation/create_hard_nft/hard_nft_mint_request/ui/list_mint_request.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/dialog/cupertino_loading.dart';
import 'package:Dfy/widgets/dialog/modal_progress_hud.dart';
import 'package:Dfy/widgets/views/state_stream_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListHardNftMintRequest extends StatefulWidget {
  const ListHardNftMintRequest({Key? key}) : super(key: key);

  @override
  _ListHardNftMintRequestState createState() => _ListHardNftMintRequestState();
}

class _ListHardNftMintRequestState extends State<ListHardNftMintRequest> {
  late HardNftMintRequestCubit cubit;

  TextEditingController controller = TextEditingController();
  late Timer _debounce;

  @override
  void initState() {
    super.initState();
    cubit = HardNftMintRequestCubit();
    _debounce = Timer(const Duration(milliseconds: 500), () {});
    cubit.getListMintRequest();
  }

  @override
  void dispose() {
    _debounce.cancel();
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HardNftMintRequestCubit, HardNftMintRequestState>(
      bloc: cubit,
      builder: (BuildContext context, state) {
        return StateStreamLayout(
          stream: cubit.stateStream,
          error: AppException(S.current.error, S.current.something_went_wrong),
          retry: () async {},
          textEmpty: '',
          child: content(state),
        );
      },
    );
  }

  Widget content(HardNftMintRequestState state) {
    if (state is ListMintRequestSuccess) {
      final List<MintRequestModel> list = state.list;
      return BaseDesignScreen(
        title: 'Hard NFT mint request',
        isImage: true,
        text: ImageAssets.ic_filter,
        onRightClick: () {},
        child: Column(
          children: [
            spaceH12,
            Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
              ),
              child: searchBar(),
            ),
            spaceH16,
            SizedBox(
              height: 621.h,
              child: ListMintRequest(
                cubit: cubit,
                listMintRequest: list,
              ),
            ),
          ],
        ),
      );
    } else {
      return const ModalProgressHUD(
        inAsyncCall: true,
        progressIndicator: CupertinoLoading(),
        child: SizedBox(),
      );
    }
  }

  Widget searchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            width: 343.w,
            height: 46.h,
            decoration: BoxDecoration(
              color: backSearch,
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 14.w,
                ),
                Image.asset(
                  ImageAssets.ic_search,
                  height: 16.h,
                  width: 16.w,
                ),
                SizedBox(
                  width: 10.7.w,
                ),
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    onChanged: (value) {
                      cubit.show();
                      _onSearchChanged(value.trim());
                    },
                    cursorColor: Colors.white,
                    style: textNormal(
                      Colors.white,
                      16.sp,
                    ),
                    maxLength: 255,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      isCollapsed: true,
                      counterText: '',
                      hintText: S.current.name_of_nft,
                      hintStyle: textNormal(
                        Colors.white54,
                        16.sp,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                StreamBuilder<bool>(
                  stream: cubit.isVisible,
                  builder: (context, snapshot) {
                    return Visibility(
                      visible: snapshot.data ?? false,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            controller.text = '';
                            cubit.hide();
                          });
                          FocusScope.of(context).unfocus();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: 13.w,
                          ),
                          child: ImageIcon(
                            const AssetImage(
                              ImageAssets.ic_close,
                            ),
                            color: AppTheme.getInstance().whiteColor(),
                            size: 20.sp,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _onSearchChanged(String query) {
    if (_debounce.isActive) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 900), () {});
  }
}
