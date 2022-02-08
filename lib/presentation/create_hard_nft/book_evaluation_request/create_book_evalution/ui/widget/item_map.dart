import 'package:Dfy/domain/model/market_place/evaluator_detail.dart';
import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/create_book_evalution/bloc/bloc_create_book_evaluation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ItemMap extends StatefulWidget {
  final BlocCreateBookEvaluation bloc;
  final EvaluatorsDetailModel obj;

  const ItemMap({
    Key? key,
    required this.bloc,
    required this.obj,
  }) : super(key: key);

  @override
  _ItemMapState createState() => _ItemMapState();
}

class _ItemMapState extends State<ItemMap> {
  bool isCreateGoogle = false;
  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('id'),
          position: LatLng(
            widget.bloc.locationLat,
            widget.bloc.locationLong,
          ),
          infoWindow: InfoWindow(
            title: widget.obj.name,
            snippet: widget.obj.address,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(
          widget.bloc.locationLat,
          widget.bloc.locationLong,
        ),
        zoom: 14,
      ),
      markers: _markers,
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
    );
  }
}
