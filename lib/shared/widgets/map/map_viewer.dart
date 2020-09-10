import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pos_app/core.dart';

class MapViewer extends StatefulWidget {
  final double latitude;
  final double longitude;

  MapViewer({
    this.latitude,
    this.longitude,
  });

  @override
  _MapViewerState createState() => _MapViewerState();
}

class _MapViewerState extends State<MapViewer> {
  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Container();
    }
    return MapViewerMobile(
      latitude: widget.latitude,
      longitude: widget.longitude,
    );
  }
}

class MapViewerMobile extends StatefulWidget {
  final double latitude;
  final double longitude;

  MapViewerMobile({
    this.latitude,
    this.longitude,
  });

  @override
  State<MapViewerMobile> createState() => MapViewerMobileState();
}

class MapViewerMobileState extends State<MapViewerMobile> {
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Completer<GoogleMapController> mapController = Completer();

  initData() async {
    if (widget.latitude != null && widget.longitude != null) {
      currentLatitude = -6.1867937;
      currentLongitude = 106.8205608;
    } else {
      await getCurrentLocation();
    }

    var markerId = MarkerId("CURRENT_LOCATION");
    Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        currentLatitude,
        currentLongitude,
      ),
      infoWindow: InfoWindow(title: "Your Location", snippet: '*'),
      onTap: () {},
    );

    markers[markerId] = marker;

    setState(() {});
  }

  getCurrentLocation() async {
    var location = Location();
    var currentLocation = await location.getLocation();

    currentLatitude = currentLocation.latitude;
    currentLongitude = currentLocation.longitude;
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  double currentLatitude;
  double currentLongitude;

  @override
  Widget build(BuildContext context) {
    return ExScaffold(
      hideAppBar: true,
      body: currentLatitude == null && currentLongitude == null
          ? Container(
              color: Colors.grey[300],
            )
          : GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(currentLatitude, currentLongitude),
                zoom: 17.4746,
              ),
              markers: Set<Marker>.of(markers.values),
              onMapCreated: (GoogleMapController controller) {
                mapController.complete(controller);
              },
            ),
    );
  }
}
