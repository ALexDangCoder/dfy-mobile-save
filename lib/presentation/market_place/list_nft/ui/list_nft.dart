import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/list_nft/bloc/list_nft_cubit.dart';
import 'package:Dfy/presentation/market_place/ui/nft_item.dart';
import 'package:Dfy/presentation/nft_on_sale/ui/nft_list_on_sale/ui/components/filter_bts.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ListNft extends StatefulWidget {
  const ListNft({Key? key, required this.marketType}) : super(key: key);
  final MarketType marketType;

  @override
  _ListNftState createState() => _ListNftState();
}

class _ListNftState extends State<ListNft> {
  late ListNftCubit _cubit;
  String title = '';
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cubit = ListNftCubit();
    title = _cubit.getTitle(widget.marketType);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Align(
          alignment: Alignment.bottomCenter,
          child: BaseBottomSheet(
            onRightClick: () {
              showModalBottomSheet(
                backgroundColor: Colors.black,
                isScrollControlled: true,
                context: context,
                builder: (_) {
                  return FilterBts(listNftCubit: _cubit,);
                },
              );
            },
            isImage: true,
            title: title,
            text: ImageAssets.ic_filter,
            child: SizedBox(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      top: 12.h,
                      bottom: 6.h,
                    ),
                    child: searchBar(),
                  ),
                  Expanded(
                    child: StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      mainAxisSpacing: 20.h,
                      itemCount: _cubit.listData.length,
                      crossAxisCount: 2,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(left: 16.w),
                          child: GestureDetector(
                            onTap: () {},
                            child: NFTItemWidget(
                              nftMarket: _cubit.listData[index],
                            ),
                          ),
                        );
                      },
                      staggeredTileBuilder: (int index) =>
                      const StaggeredTile.fit(1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget searchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            width: 343.w,
            height: 46.h,
            decoration: BoxDecoration(
              color: const Color(0xff4F4F65),
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
                      _cubit.show();
                    },
                    onFieldSubmitted: (value) {},
                    cursorColor: Colors.white,
                    style: textNormal(
                      Colors.white,
                      16.sp,
                    ),
                    decoration: InputDecoration(
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
                  stream: _cubit.isVisible,
                  builder: (context, snapshot) {
                    return Visibility(
                      visible: snapshot.data ?? false,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            controller.text = '';
                            _cubit.hide();
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
