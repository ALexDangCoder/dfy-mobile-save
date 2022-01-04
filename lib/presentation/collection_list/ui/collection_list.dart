import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/market_place/collection_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/collection_list/bloc/collettion_bloc.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/form/from_search.dart';
import 'package:Dfy/widgets/item/item_collection/item_colection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../main.dart';
import 'filter.dart';
import 'filter_myacc.dart';

class CollectionList extends StatefulWidget {
  const CollectionList({Key? key}) : super(key: key);

  @override
  _CollectionListState createState() => _CollectionListState();
}

class _CollectionListState extends State<CollectionList> {
  late final CollectionBloc collectionBloc;

  late final TextEditingController searchCollection;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    collectionBloc = CollectionBloc();
    searchCollection = TextEditingController();
    trustWalletChannel.setMethodCallHandler(collectionBloc.nativeMethodCallBackTrustWallet);
    collectionBloc.getListWallets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: GestureDetector(
        onTap: () {
          print('hello');
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppTheme.getInstance().fillColor().withOpacity(0.3),
                spreadRadius: -5,
                blurRadius: 15,
                offset: const Offset(0, 10), // changes position of shadow
              ),
            ],
          ),
          child: Image.asset(
            ImageAssets.img_float_btn,
            fit: BoxFit.fill,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              final FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Container(
              height: 764.h,
              // width: 375.w,
              decoration: BoxDecoration(
                color: AppTheme.getInstance().bgBtsColor(),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.h),
                  topRight: Radius.circular(30.h),
                ),
              ),
              child: Column(
                children: [
                  spaceH16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 16.w),
                          width: 28.w,
                          height: 28.h,
                          child: Image.asset(ImageAssets.ic_back),
                        ),
                      ),
                      Text(
                        S.current.collection_list,
                        style: textNormalCustom(null, 20.sp, FontWeight.w700),
                      ),
                      GestureDetector(
                        onTap: () {
                          bool isMyacc = true;
                          if (!isMyacc) {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) => Filter(
                                collectionBloc: collectionBloc,
                              ),
                            );
                          } else {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) => FilterMyAcc(
                                collectionBloc: collectionBloc,
                              ),
                            );
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 16.w),
                          width: 24.w,
                          height: 24.h,
                          child: Image.asset(ImageAssets.ic_filter),
                        ),
                      ),
                    ],
                  ),
                  spaceH20,
                  line,
                  spaceH12,
                  FormSearchBase(
                    onChangedFunction: collectionBloc.funOnSearch,
                    onTapFunction: collectionBloc.funOnTapSearch,
                    urlIcon: ImageAssets.ic_search,
                    hint: S.current.name_of_collection,
                    textSearchStream: collectionBloc.textSearch,
                    textSearch: searchCollection,
                  ),
                  spaceH10,
                  StreamBuilder(
                    stream: collectionBloc.list,
                    builder: (context,
                        AsyncSnapshot<List<CollectionModel>> snapshot) {
                      if (snapshot.hasData) {
                        return Expanded(
                          child: StaggeredGridView.countBuilder(
                            padding: EdgeInsets.only(
                              left: 21.w,
                              right: 21.w,
                              top: 10.h,
                              bottom: 20.h,
                            ),
                            mainAxisSpacing: 20.h,
                            crossAxisSpacing: 26.w,
                            itemCount: collectionBloc.list.value.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRouter.detailCollection,
                                  );
                                },
                                child: ItemCollection(
                                  items:
                                      '${snapshot.data?[index].totalNft ?? 0}',
                                  text: snapshot.data?[index].description
                                          ?.parseHtml() ??
                                      '',
                                  urlIcon: ApiConstants.URL_BASE +
                                      (snapshot.data?[index].avatarCid ?? ''),
                                  owners:
                                      '${snapshot.data?[index].nftOwnerCount ?? 0}',
                                  title:
                                      snapshot.data?[index].name?.parseHtml() ??
                                          '',
                                  urlBackGround: ApiConstants.URL_BASE +
                                      (snapshot.data?[index].coverCid ?? ''),
                                ),
                              );
                            },
                            crossAxisCount: 2,
                            staggeredTileBuilder: (int index) =>
                                const StaggeredTile.fit(1),
                          ),
                        );
                      } else {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 2 - 80,
                            ),
                            child: CircularProgressIndicator(
                              color: AppTheme.getInstance().whiteColor(),
                            ),
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
