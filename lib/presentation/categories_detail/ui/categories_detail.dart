import 'package:Dfy/config/base/base_app_bar.dart';
import 'package:Dfy/config/base/base_custom_scroll_view.dart';
import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/detail_collection/ui/widget/base_collection.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/item/item_collection/item_colection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CategoriesDetail extends StatefulWidget {
  const CategoriesDetail({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _CategoriesDetailState createState() => _CategoriesDetailState();
}

class _CategoriesDetailState extends State<CategoriesDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          child: NestedScrollView(
            physics: const ScrollPhysics(),
            headerSliverBuilder: (context, innerScroll) => [
              BaseAppBar(
                image:
                    'https://www.dungplus.com/wp-content/uploads/2019/12/girl-xinh-1-480x600.jpg',
                title: '${widget.title} ${S.current.categories}',
                initHeight: 145,
                leading: SizedBox(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SizedBox(
                      height: 32,
                      width: 32,
                      child: Image.asset(ImageAssets.img_back),
                    ),
                  ),
                ),
                actions: [
                  Container(
                    margin: const EdgeInsets.only(
                      right: 16,
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: SizedBox(
                        height: 32,
                        width: 32,
                        child: Image.asset(ImageAssets.img_filter),
                      ),
                    ),
                  )
                ],
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      color: backgroundBottomSheetColor,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          Text(
                            '${S.current.explore} ${widget.title} ${S.current.categories}',
                            style: textNormalCustom(
                              AppTheme.getInstance().textThemeColor(),
                              20,
                              FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            'Euismod amet, sed pulvinar mattis venenatis tristique pulvinar aliquam sit. Non orci quis eget cras erat elit ornare. Sit pharetra, arcu, sit quis quam vulputate. Ornare',
                            style: textNormalCustom(
                              AppTheme.getInstance()
                                  .textThemeColor()
                                  .withOpacity(0.7),
                              14,
                              FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              color: backgroundBottomSheetColor,
              child: StaggeredGridView.countBuilder(
                mainAxisSpacing: 20,
                crossAxisSpacing: 15,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) {
                      //       return DetailCollection(
                      //         walletAddress:
                      //         'a6b1b1a6-6cbe-4375-a981-0e727b8120c4',
                      //         id: collectionBloc
                      //             .list.value[index].id ??
                      //             '',
                      //       );
                      //     },
                      //   ),
                      // );
                    },
                    child: const ItemCollection(
                      fixWidth: false,
                      urlBackGround:
                          'https://toigingiuvedep.vn/wp-content/uploads/2021/01/hinh-anh-girl-xinh-toc-ngan-de-thuong.jpg',
                      backgroundFit: BoxFit.cover,
                      urlIcon:
                          'https://www.dungplus.com/wp-content/uploads/2019/12/girl-xinh-1-480x600.jpg',
                      title: 'alo',
                      items: '1025',
                      owners: '365',
                      text:
                          'text text text text text text text text text  text text text text text text',
                    ),
                  );
                },
                crossAxisCount: 2,
                staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
              ),

              // GridView.builder(
              //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 2,
              //     crossAxisSpacing: 15,
              //     mainAxisSpacing: 20,
              //   ),
              //   itemCount: 10,
              //   itemBuilder: (BuildContext context, int index) {
              //     return const ItemCollection(
              //       fixWidth: false,
              //       urlBackGround:
              //           'https://toigingiuvedep.vn/wp-content/uploads/2021/01/hinh-anh-girl-xinh-toc-ngan-de-thuong.jpg',
              //       backgroundFit: BoxFit.cover,
              //       urlIcon:
              //           'https://www.dungplus.com/wp-content/uploads/2019/12/girl-xinh-1-480x600.jpg',
              //       title: 'alo',
              //       items: '1025',
              //       owners: '365',
              //       text: 'text text text text',
              //     );
              //   },
              // ),
            ),
          ),
        ),
      ),
    );
  }
}
