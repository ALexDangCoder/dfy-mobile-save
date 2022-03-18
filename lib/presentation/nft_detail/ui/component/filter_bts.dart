import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/list_nft/bloc/list_nft_cubit.dart';
import 'package:Dfy/presentation/nft_detail/ui/component/ckc_filter.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterBts extends StatefulWidget {
  const FilterBts({
    Key? key,
    required this.listNftCubit,
    required this.isLogin,
  }) : super(key: key);
  final ListNftCubit listNftCubit;
  final bool isLogin;

  @override
  _FilterBtsState createState() => _FilterBtsState();
}

class _FilterBtsState extends State<FilterBts> {
  TextEditingController controller = TextEditingController();
  final ScrollController _firstController =
      ScrollController();

  @override
  void initState() {
    widget.listNftCubit.listCheckBox.add(
      widget.listNftCubit.listCollectionCheck,
    );
    widget.listNftCubit.checkStatus();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    _firstController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 4,
          sigmaY: 4,
        ),
        child: Container(
          height: widget.isLogin ? 403.h : 650.h,
          width: 375.w,
          padding: EdgeInsets.only(
            top: 9.h,
            left: 16.w,
            right: 16.w,
            // right: 16.w,
          ),
          decoration: BoxDecoration(
            color: AppTheme.getInstance().bgBtsColor(),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: GestureDetector(
            onTap: () {
              widget.listNftCubit.isShowDropDownStream.add(false);
              FocusScope.of(context).unfocus();
            },
            child: Stack(
              children: [
                SingleChildScrollView(
                  physics: widget.listNftCubit.isShowDropDownStream.value
                      ? const NeverScrollableScrollPhysics()
                      : const ScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      spaceH20,
                      if (widget.isLogin)
                        Text(
                          S.current.address,
                          style: textNormalCustom(
                            Colors.white,
                            20,
                            FontWeight.w600,
                          ),
                        ),
                      if (widget.isLogin) spaceH10,
                      if (widget.isLogin)
                        StreamBuilder<String>(
                          stream: widget.listNftCubit.addressStream,
                          builder: (
                            BuildContext context,
                            AsyncSnapshot<String> snapshot,
                          ) {
                            return boxAddress(snapshot.data ?? '');
                          },
                        ),
                      if (widget.isLogin) spaceH10,
                      Text(
                        S.current.nft_type,
                        style: textNormalCustom(
                          Colors.white,
                          20,
                          FontWeight.w600,
                        ),
                      ),
                      spaceH12,
                      Row(
                        children: [
                          Expanded(
                            child: CheckBoxFilter(
                              cubit: widget.listNftCubit,
                              nameCkcFilter: S.current.hard_NFT,
                              typeCkc: TYPE_CKC_FILTER.NON_IMG,
                              filterType: S.current.nft_type,
                            ),
                          ),
                          Expanded(
                            child: CheckBoxFilter(
                              cubit: widget.listNftCubit,
                              nameCkcFilter: S.current.soft_nft,
                              typeCkc: TYPE_CKC_FILTER.NON_IMG,
                              filterType: S.current.nft_type,
                            ),
                          ),
                        ],
                      ),
                      if (!widget.isLogin) spaceH20,
                      if (!widget.isLogin)
                        Text(
                          S.current.status,
                          style: textNormalCustom(
                            Colors.white,
                            20,
                            FontWeight.w600,
                          ),
                        ),
                      if (!widget.isLogin) spaceH12,
                      if (!widget.isLogin)
                        CheckBoxFilter(
                          cubit: widget.listNftCubit,
                          nameCkcFilter: S.current.on_sell,
                          typeCkc: TYPE_CKC_FILTER.NON_IMG,
                          filterType: S.current.status,
                        ),
                      if (!widget.isLogin) spaceH12,
                      if (!widget.isLogin)
                        Row(
                          children: [
                            Expanded(
                              child: CheckBoxFilter(
                                cubit: widget.listNftCubit,
                                nameCkcFilter: S.current.on_pawn,
                                typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                filterType: S.current.status,
                              ),
                            ),
                            Expanded(
                              child: CheckBoxFilter(
                                cubit: widget.listNftCubit,
                                nameCkcFilter: S.current.on_auction,
                                typeCkc: TYPE_CKC_FILTER.NON_IMG,
                                filterType: S.current.status,
                              ),
                            ),
                          ],
                        ),
                      if (!widget.isLogin) spaceH20,
                      if (!widget.isLogin)
                        Text(
                          S.current.collection,
                          style: textNormalCustom(
                            Colors.white,
                            20,
                            FontWeight.w600,
                          ),
                        ),
                      if (!widget.isLogin) spaceH12,
                      if (!widget.isLogin) searchCollection(),
                      if (!widget.isLogin) spaceH20,
                      if (!widget.isLogin)
                        SizedBox(
                          height: 210.h,
                          width: double.infinity,
                          child: StreamBuilder<List<CheckBoxFilter>>(
                            stream: widget.listNftCubit.listCheckBox,
                            builder: (
                              context,
                              AsyncSnapshot<List<CheckBoxFilter>> snapshot,
                            ) {
                              if (snapshot.hasData) {
                                final itemCount = snapshot.data?.length ?? 0;
                                if (itemCount != 0) {
                                  return Scrollbar(
                                    controller: _firstController,
                                    radius: Radius.circular(10.0.r),
                                    isAlwaysShown: true,
                                    child: ListView.builder(
                                      controller: _firstController,
                                      shrinkWrap: true,
                                      itemCount: itemCount,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            CheckBoxFilter(
                                              cubit: widget.listNftCubit,
                                              nameCkcFilter: snapshot
                                                      .data?[index]
                                                      .nameCkcFilter ??
                                                  '',
                                              typeCkc: snapshot
                                                      .data?[index].typeCkc ??
                                                  TYPE_CKC_FILTER.NON_IMG,
                                              urlCover: snapshot
                                                  .data![index].urlCover,
                                              filterType: S.current.collection,
                                              collectionId: snapshot
                                                      .data?[index]
                                                      .collectionId ??
                                                  '',
                                            ),
                                            spaceH12,
                                          ],
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  return Padding(
                                    padding: EdgeInsets.only(top: 40.h),
                                    child: Column(
                                      children: [
                                        Image(
                                          image: const AssetImage(
                                            ImageAssets.img_search_empty,
                                          ),
                                          height: 40.h,
                                          width: 40.w,
                                        ),
                                        SizedBox(
                                          height: 17.7.h,
                                        ),
                                        Text(
                                          S.current.no_result_found,
                                          style: textNormal(
                                            Colors.white54,
                                            14.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              } else {
                                return SizedBox(
                                  height: 100.h,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.r,
                                      color:
                                          AppTheme.getInstance().whiteColor(),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      SizedBox(
                        height: 34.h,
                      ),
                      if (widget.isLogin)
                        SizedBox(
                          height: 100.h,
                        ),
                      GestureDetector(
                        onTap: () {
                          widget.listNftCubit.page = 1;
                          widget.listNftCubit.canLoadMoreListNft = true;
                          widget.listNftCubit.checkStatus();
                          widget.listNftCubit.checkFilterArr.clear();
                          widget.listNftCubit.getListNft(
                            status: widget.listNftCubit
                                .getParam(widget.listNftCubit.selectStatus),
                            nftType: widget.listNftCubit
                                .getParam(widget.listNftCubit.selectTypeNft),
                            collectionId: widget.listNftCubit
                                .getParam(widget.listNftCubit.selectCollection),
                            walletAddress: widget.listNftCubit.walletAddress,
                            pageRouter: widget.isLogin
                                ? PageRouter.MY_ACC
                                : PageRouter.MARKET,
                          );
                          widget.listNftCubit.setTitle();
                          widget.listNftCubit.setCheck(
                            widget.listNftCubit.selectTypeNft,
                            widget.listNftCubit.selectStatus,
                            widget.listNftCubit.selectCollection,
                          );
                          Navigator.pop(context);
                        },
                        child: ButtonGold(
                          isEnable: true,
                          title: S.current.apply,
                          height: 48.h,
                          textSize: 16,
                        ),
                      ),
                      if (widget.isLogin) spaceH38,
                    ],
                  ),
                ),
                StreamBuilder<bool>(
                  stream: widget.listNftCubit.isShowDropDownStream,
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    return Visibility(
                      visible: snapshot.data ?? false,
                      child: Padding(
                        padding: EdgeInsets.only(top: 110.h),
                        child: selectAccount(),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(left: 117.w, top: 8.h),
                  child: Container(
                    width: 109.w,
                    height: 5.h,
                    decoration: const BoxDecoration(
                      color: Color(0xff585782),
                      borderRadius: BorderRadius.all(
                        Radius.circular(3),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget searchCollection() {
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
                      widget.listNftCubit.show();
                      widget.listNftCubit.searchCollection(value);
                    },
                    onFieldSubmitted: (value) {},
                    cursorColor: Colors.white,
                    style: textNormal(
                      Colors.white,
                      16,
                    ),
                    maxLength: 255,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      isCollapsed: true,
                      counterText: '',
                      hintText: S.current.search,
                      hintStyle: textNormal(
                        Colors.white54,
                        16,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                StreamBuilder<bool>(
                  stream: widget.listNftCubit.isVisible,
                  builder: (context, snapshot) {
                    return Visibility(
                      visible: snapshot.data ?? false,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            controller.text = '';
                            widget.listNftCubit.hide();
                            FocusScope.of(context).unfocus();
                          });
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

  Widget selectAccount() {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 177.h,
      decoration: BoxDecoration(
        color: dialogColor,
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
      ),
      child: Theme(
        data: ThemeData(
          highlightColor: backgroundBottomSheet,
        ),
        child: Scrollbar(
          radius: Radius.circular(1.5.r),
          child: ListView.builder(
            itemCount: widget.listNftCubit.walletAddressFilter.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return itemAddress(
                widget.listNftCubit.walletAddressFilter[index],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget itemAddress(String text) {
    return InkWell(
      onTap: () {
        widget.listNftCubit.addressStream.add(text);
        widget.listNftCubit.walletAddress = text;
        widget.listNftCubit.isShowDropDownStream.add(false);
      },
      child: Container(
        height: 54.h,
        color: text == widget.listNftCubit.walletAddress
            ? Colors.white.withOpacity(0.3)
            : Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(
            left: 24.w,
            top: 15.h,
          ),
          child: Text(
            text.length == 3 ? text : text.formatAddress(index: 9),
            style: textNormalCustom(
              Colors.white,
              16,
              FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget boxAddress(String address) {
    return InkWell(
      onTap: () {
        if (widget.listNftCubit.showDropdownAddress) {
          widget.listNftCubit.isShowDropDownStream.add(true);
        }
      },
      child: Container(
        height: 46.h,
        padding: EdgeInsets.symmetric(
          horizontal: 15.5.w,
        ),
        decoration: BoxDecoration(
          color: AppTheme.getInstance().itemBtsColors(),
          borderRadius: BorderRadius.all(
            Radius.circular(12.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  child: Text(
                    address.length == 3
                        ? address
                        : address.formatAddress(index: 9),
                    style: textNormal(
                      null,
                      16,
                    ),
                  ),
                ),
              ],
            ),
            if(widget.listNftCubit.showDropdownAddress)
            Image.asset(
              ImageAssets.ic_line_down,
              height: 20.67.h,
              width: 20.14.w,
            ),
          ],
        ),
      ),
    );
  }
}
