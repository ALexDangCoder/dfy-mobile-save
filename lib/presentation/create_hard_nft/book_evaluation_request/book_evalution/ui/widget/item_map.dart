import 'package:Dfy/presentation/create_hard_nft/book_evaluation_request/book_evalution/bloc/bloc_book_evalution.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ItemMap extends StatefulWidget {
  final BlocBookEvaluation bloc;

  const ItemMap({
    Key? key,
    required this.bloc,
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
          markerId: MarkerId(widget.bloc.id),
          position: LatLng(
            widget.bloc.locationLat,
            widget.bloc.locationLong,
          ),
          infoWindow: InfoWindow(
            title: widget.bloc.nameCity,
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
        zoom: 11,
      ),
      markers: _markers,
      zoomControlsEnabled: false,
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
