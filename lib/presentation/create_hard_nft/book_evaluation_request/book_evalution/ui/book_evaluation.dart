import 'dart:async';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/book_evalution/ui/widget/item_pawn_shop_star.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/create_book_evalution/ui/create_book_evaluation.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/list_book_evalution/ui/widget/step_appbar.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class BookEvaluation extends StatefulWidget {
  const BookEvaluation({Key? key}) : super(key: key);

  @override
  _BookEvaluationState createState() => _BookEvaluationState();
}

class _BookEvaluationState extends State<BookEvaluation> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(20.547441679107266, 105.90781651516276),
    zoom: 14.4746,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getLocationUpdates();
  }

  // void getLocationUpdates() {
  //   final LocationSettings locationSettings = LocationSettings(
  //     accuracy: LocationAccuracy.high,
  //     distanceFilter: 100,
  //   );
  //   StreamSubscription<Position> homeTabPostionStream;
  //   homeTabPostionStream =
  //       Geolocator.getPositionStream(locationSettings: locationSettings)
  //           .listen((position) {
  //     print(position == null
  //         ? 'Unknown'
  //         : position.latitude.toString() +
  //             ', ' +
  //             position.longitude.toString());
  //     print('-----------------------------------------${position.latitude}');
  //   });
  // }
  // void _currentLocation() async {
  //   final GoogleMapController controller = await _controller.future;
  //   LocationData currentLocation;
  //   var location = Location();
  //   try {
  //     currentLocation = await location.getLocation();
  //   } on Exception {
  //     currentLocation = null;
  //   }
  //
  //   controller.animateCamera(CameraUpdate.newCameraPosition(
  //     CameraPosition(
  //       bearing: 0,
  //       target: LatLng(currentLocation.latitude, currentLocation.longitude),
  //       zoom: 17.0,
  //     ),
  //   ));
  // }

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      isImage: true,
      text: ImageAssets.ic_close,
      onRightClick: () {
        //todo add event
      },
      title: S.current.book_evaluation_request,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            spaceH24,
            const StepAppBar(),
            spaceH32,
            SizedBox(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Text(
                  S.current.to_mint_hard_nft_you,
                  style: textNormalCustom(
                    AppTheme.getInstance().grayTextColor(),
                    14,
                    null,
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      20.r,
                    ),
                  ),
                ),
                height: 193.h,
                width: 343.w,
                child: GoogleMap(
                  // zoomGesturesEnabled: false,
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            ),
            spaceH32,
            Container(
              padding: EdgeInsets.all(16.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '4 ${S.current.evaluators_near_you}',
                  style: textNormalCustom(
                    AppTheme.getInstance().getPurpleColor(),
                    14,
                    null,
                  ),
                ),
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateBookEvaluation(),
                    ),
                  );
                },
                child: ItemPawnShopStar(
                  starNumber: '5.0',
                  namePawnShop: 'Tima - Online Pawnshop',
                  avatarPawnShopUrl:
                      'https://cdn.tgdd.vn/Files/2021/12/14/1404293/f8822mwg111_1280x720-800-resize.jpg',
                  function: () {},
                ),
              ),
              itemCount: 4,
              shrinkWrap: true,
            )
          ],
        ),
      ),
    );
  }
}
