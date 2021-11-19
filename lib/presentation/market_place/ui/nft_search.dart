import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/nft_item.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/bloc/marketplace_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchNFT extends StatefulWidget {
  const SearchNFT({Key? key}) : super(key: key);

  @override
  _SearchNFTState createState() => _SearchNFTState();
}

class _SearchNFTState extends State<SearchNFT> {
  late MarketplaceCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = MarketplaceCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: 375.w,
          height: 812.h,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: listBackgroundColor,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 52.h,
              ),
              searchBar(),
              SizedBox(
                height: 22.h,
              ),
              Divider(
                color: AppTheme.getInstance().divideColor(),
              ),
              BlocBuilder<MarketplaceCubit, MarketplaceState>(
                bloc: cubit,
                builder: (context, state) {
                  if (state is SearchSuccess) {
                    return result();
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(top: 150.h),
                      child: Column(
                        children: [
                          const Image(
                            image: AssetImage(ImageAssets.img_search_empty),
                          ),
                          SizedBox(
                            height: 17.7.h,
                          ),
                          Text(
                            'No result found',
                            style: textNormal(
                              Colors.white54,
                              20,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchBar() {
    return SizedBox(
      width: 343.w,
      height: 38.h,
      child: Row(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: const ImageIcon(
              AssetImage(ImageAssets.ic_back,),color: Colors.white,
            ),
          ),
          SizedBox(
            width: 27.h,
          ),
          Expanded(
            child: Container(
              width: 299.w,
              height: 38.h,
              decoration: BoxDecoration(
                color: AppTheme.getInstance().selectDialogColor(),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Row(
                children: [
                  SizedBox(width: 14.w,),
                  Image.asset(
                    ImageAssets.ic_search,
                  ),
                  SizedBox(
                    width: 10.7.w,
                  ),
                  Expanded(
                    child: TextFormField(
                      cursorColor: Colors.white,
                      style: textNormal(
                        Colors.white,
                        14,
                      ),
                      decoration: InputDecoration(
                        hintText: S.current.search,
                        hintStyle: textNormal(
                          Colors.white54,
                          14,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  StreamBuilder(
                    // stream: widget.bloc.textSearch,
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      return GestureDetector(
                        onTap: () {
                          // widget.bloc.textSearch.sink.add('');
                          // textSearch.text = '';
                          // widget.bloc.search();
                        },
                        child: snapshot.data?.isNotEmpty ?? false
                            ? Image.asset(
                          ImageAssets.ic_close,
                          width: 20.w,
                          height: 20.h,
                        )
                            : SizedBox(
                          height: 20.h,
                          width: 20.w,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget result() {
    return Container();
  }
}
