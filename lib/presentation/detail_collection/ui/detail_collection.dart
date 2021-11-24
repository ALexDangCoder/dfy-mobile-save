import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/detail_collection/bloc/detail_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'header_collection.dart';

class DetailCollection extends StatefulWidget {
  const DetailCollection({Key? key}) : super(key: key);

  @override
  _DetailCollectionState createState() => _DetailCollectionState();
}

class _DetailCollectionState extends State<DetailCollection> {
  late final DetailCollectionBloc detailCollectionBloc;

  @override
  void initState() {
    super.initState();
    detailCollectionBloc = DetailCollectionBloc();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () {
            final FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Column(
            children: [
              SizedBox(
                height: 48.h,
              ),
              Container(
                height: 764.h,
                width: 375.w,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: AppTheme.getInstance().borderItemColor(),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                child: HeaderCollection(
                  owner: '0xFE5788e2...EB7144fd0',
                  category: 'Art',
                  title: 'Artwork collection',
                  bodyText:
                      'Euismod amet, sed pulvinar mattis venenatis tristique'
                      ' pulvinar aliquam sit. Non orci quis eget cras erat'
                      ' elit ornare. Sit pharetra, arcu, sit quis quam'
                      ' vulputate. Ornare cursus sed id nibh nisi.'
                      ' Vulputate at dictum pharetra tortor aliquet'
                      ' ornare nisl nisl.',
                  contract: '0xFE5788e2...EB7144fd0',
                  nftStandard: 'ERC - 1155',
                  detailCollectionBloc: detailCollectionBloc,
                  urlBackground: 'https://tse1.mm.bing.net/th?id=OIP.'
                      'OfaVuv27apRglGh0_CL9TQHaEK&pid=Api&P=0&w=340&h=192',
                  urlAvatar: 'https://tse1.mm.bing.net/th?id=OIP'
                      '.PrSmDPqBP53bKlJvK0-KIwHaEo&pid=Api&P=0&w=259&h=163',
                  collectionBloc: detailCollectionBloc,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
