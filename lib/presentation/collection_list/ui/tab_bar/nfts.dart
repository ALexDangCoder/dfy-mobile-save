import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/nft_item_by_category/nft_type_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NftsCollection extends StatefulWidget {
  const NftsCollection({Key? key}) : super(key: key);

  @override
  _NftsCollectionState createState() => _NftsCollectionState();
}

class _NftsCollectionState extends State<NftsCollection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            width: 343.w,
            height: 46.h,
            margin: EdgeInsets.only(top: 20.h),
            padding: const EdgeInsets.only(right: 15, left: 15),
            decoration: const BoxDecoration(
              color: Color(0xff32324c),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.ic_search,
                ),
                SizedBox(
                  width: 11.5.w,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 5.w),
                    child: TextFormField(
                      //   controller: textSearch,
                      // maxLength: 20,
                      onChanged: (value) {
                        // widget.bloc.textSearch.sink.add(value);
                        //
                        // widget.bloc.search();
                      },
                      cursorColor: Colors.white,
                      style: textNormal(
                        Colors.white54,
                        14,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: S.current.search,
                        hintStyle: textNormal(
                          Colors.white.withOpacity(0.5),
                          14,
                        ),
                        border: InputBorder.none,
                      ),
                      // onFieldSubmitted: ,
                    ),
                  ),
                ),
                StreamBuilder(
                  //stream: widget.bloc.textSearch,
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
        StreamBuilder(
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return SizedBox(
                height: 253.h,
                child: GridView.builder(
                  padding: EdgeInsets.only(top: 21.h, bottom: 24.h, left: 20.w),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    // crossAxisSpacing: 24.w,
                    mainAxisSpacing: 20.h,
                    crossAxisCount: 2,
                  ),
                  itemCount: 300,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: NftProduct(
                        nftIsHard: NFT_IS_HARD.HARD_NFT,
                        nftCategory: NFT_CATEGORY.AUCTION,
                        nftIsVidOrImg: NFT_IS_VID_OR_IMG.IMG_NFT,
                        nftName: 'doanh handsome',
                        price: 231,
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Image.asset(
                    ImageAssets.img_search_empty,
                  ),
                  spaceH16,
                  Text(
                    S.current.no_result_found,
                    style: textNormalCustom(
                      Colors.white.withOpacity(0.7),
                      20,
                      FontWeight.bold,
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 80.h,
                  ),
                  const CircularProgressIndicator(
                    color: Colors.white,
                  )
                ],
              );
            }
          },
        ),
      ],
    );
  }
}
