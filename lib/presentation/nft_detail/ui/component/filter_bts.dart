import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/list_nft/bloc/list_nft_cubit.dart';
import 'package:Dfy/presentation/nft_detail/ui/component/ckc_filter.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterBts extends StatefulWidget {
  const FilterBts({Key? key, required this.listNftCubit}) : super(key: key);
  final ListNftCubit listNftCubit;

  @override
  _FilterBtsState createState() => _FilterBtsState();
}

class _FilterBtsState extends State<FilterBts> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    widget.listNftCubit.listCheckBox.add(
      widget.listNftCubit.listCollectionCheck,
    );
    super.initState();
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
          height: 686.h,
          width: 375.w,
          padding: EdgeInsets.only(
            top: 9.h,
            left: 16.w,
            right: 16.w,
            // right: 16.w,
          ),
          decoration: BoxDecoration(
            color: AppTheme.getInstance().bgBtsColor(),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
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
              spaceH20,
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
              spaceH20,
              Text(
                S.current.status,
                style: textNormalCustom(
                  Colors.white,
                  20,
                  FontWeight.w600,
                ),
              ),
              spaceH12,
              CheckBoxFilter(
                cubit: widget.listNftCubit,
                nameCkcFilter: S.current.on_sell,
                typeCkc: TYPE_CKC_FILTER.NON_IMG,
                filterType: S.current.status,
              ),
              spaceH12,
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
              spaceH20,
              Text(
                S.current.collection,
                style: textNormalCustom(
                  Colors.white,
                  20,
                  FontWeight.w600,
                ),
              ),
              spaceH12,
              searchCollection(),
              spaceH20,
              SizedBox(
                height: 210.h,
                width: double.infinity,
                child: StreamBuilder<List<CheckBoxFilter>>(
                  stream: widget.listNftCubit.listCheckBox,
                  builder:
                      (context, AsyncSnapshot<List<CheckBoxFilter>> snapshot) {
                    final itemCount = snapshot.data?.length ?? 0;
                    if(itemCount != 0) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: (itemCount > 5) ? 5: itemCount,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              CheckBoxFilter(
                                cubit: widget.listNftCubit,
                                nameCkcFilter:
                                snapshot.data?[index].nameCkcFilter ?? '',
                                typeCkc: snapshot.data?[index].typeCkc ??
                                    TYPE_CKC_FILTER.NON_IMG,
                                urlCover: snapshot.data![index].urlCover,
                                filterType: S.current.collection,
                                collectionId:
                                snapshot.data?[index].collectionId ?? '',
                              ),
                              spaceH12,
                            ],
                          );
                        },
                      );
                    }
                    else {
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
                  },
                ),
              ),
              SizedBox(
                height: 34.h,
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
                ),
              ),
            ],
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
}
