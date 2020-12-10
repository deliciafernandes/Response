import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:response/custom_icons/emergency_icons.dart';
import 'package:response/utilities/LocationService.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:response/utilities/constants.dart';

import 'SOS.dart';

class MapsBody extends StatefulWidget {
  static const String id = '/MapsBody';

  @override
  _MapsBodyState createState() => _MapsBodyState();
}

class _MapsBodyState extends State<MapsBody> {
  LocationService locationService = LocationService();

  double _latitude = 19.095212;
  double _longitude = 72.863363;

  void getLocationData() async {
    _latitude = await locationService.getLat();
    _longitude = await locationService.getLong();
  }

  //map code:
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(45.521563, -122.677433);

  final Set<Marker> _markers = {};

  LatLng _lastMapPosition = _center;

  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Your Current Location',
          snippet: "Mumbai",
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    getLocationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      width: 375.0,
      height: 667.0,
      allowFontScaling: true,
    );

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            top: false,
            bottom: true,
            left: false,
            right: false,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(_latitude, _longitude), //_center
                zoom: 12.0,
              ),
              mapType: _currentMapType,
              markers: _markers,
              onCameraMove: _onCameraMove,
            ),
          ),
          SafeArea(
            top: true,
            bottom: false,
            left: false,
            right: false,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10.0.w, vertical: 10.0.h),
                  child: Material(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0.w)),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0.w),
                          border: Border.all(
                            color: Colors.white,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20.0.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                icon: Icon(Icons.menu,
                                    size: 20.0.w, color: Colors.black),
                                onPressed: () {
                                  Scaffold.of(context).openDrawer();
                                }),
                            Text(
                              'RESPONSE     ',
                              style: kCustomAppBarResponseLogoTextStyle,
                            ),
                            IconButton(
                                icon: Icon(Emergency.warning,
                                    size: 20.0.w, color: Colors.black),
                                onPressed: () {
                                  Navigator.pushNamed(context, SOS.id);
                                }),
                          ],
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      children: <Widget>[
                        FloatingActionButton(
                          backgroundColor: Colors.white,
                          splashColor: Colors.blue,
                          elevation: 5.0,
                          tooltip: 'Increment',
                          child:
                              Icon(Icons.map, color: Colors.black, size: 36.0),
                          onPressed: _onMapTypeButtonPressed,
                        ),
                        SizedBox(height: 16.0),
                        FloatingActionButton(
                          onPressed: _onAddMarkerButtonPressed,
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                          backgroundColor: Colors.lightGreen,
                          child: const Icon(Icons.add_location, size: 36.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
