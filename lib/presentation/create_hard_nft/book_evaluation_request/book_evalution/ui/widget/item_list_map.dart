import 'package:Dfy/domain/model/market_place/evaluators_city_model.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/book_evalution/bloc/bloc_book_evalution.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/create_book_evalution/ui/create_book_evaluation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ItemListMap extends StatefulWidget {
  final BlocBookEvaluation bloc;
  final List<EvaluatorsCityModel> list;

  const ItemListMap({
    Key? key,
    required this.bloc,
    required this.list,
  }) : super(key: key);

  @override
  _ItemListMap createState() => _ItemListMap();
}

class _ItemListMap extends State<ItemListMap> {
  late GoogleMapController mapController;
  late final Set<Marker> markers;

  late final LatLng showLocation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showLocation = LatLng(
      widget.bloc.locationLat,
      widget.bloc.locationLong,
    );
    markers = Set();
  }

  void getMarkers() {
    markers.add(
      Marker(
        markerId: MarkerId(showLocation.toString()),
        position: showLocation,
        infoWindow: InfoWindow(
          title: widget.bloc.nameCity,
        ),
      ),
    );
    for (final EvaluatorsCityModel value in widget.list) {
      if (!(value.locationLong?.isNaN ?? false) &&
          !(value.locationLat?.isNaN ?? false)) {
        markers.add(
          Marker(
            markerId: MarkerId(value.id ?? ''),
            position: LatLng(
              value.locationLat ?? 0,
              value.locationLong ?? 0,
            ), //position of marker
            infoWindow: InfoWindow(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateBookEvaluation(
                      idEvaluation: value.id ?? '',
                      type: TypeEvaluation.NEW_CREATE,
                      typeNFT: widget.bloc.evaluatorId,
                    ),
                  ),
                );
              },
              //popup info
              title: value.name,
              snippet: value.description,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getMarkers();
    return GoogleMap(
      gestureRecognizers: Set()
        ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
        ..add(
          Factory<VerticalDragGestureRecognizer>(
            () => VerticalDragGestureRecognizer(),
          ),
        )
        ..add(
          Factory<HorizontalDragGestureRecognizer>(
            () => HorizontalDragGestureRecognizer(),
          ),
        )
        ..add(
          Factory<ScaleGestureRecognizer>(
            () => ScaleGestureRecognizer(),
          ),
        ),
      zoomControlsEnabled: false,
      initialCameraPosition: CameraPosition(
        target: showLocation,
        zoom: 11.0,
      ),
      markers: markers,
      onMapCreated: (controller) {
        setState(() {
          mapController = controller;
        });
      },
    );
  }
}
