import 'dart:async';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../../business_logic/models/models/place_directions.dart';
import '../../../business_logic/models/models/place_model.dart';
import '../../../business_logic/models/models/place_suggestions _model.dart';
import '../home/widgets/appBarProfile.dart';
import 'bloc/maps_cubit.dart';
import 'helper/location_helper.dart';

class MapScreen extends StatefulWidget {
   static const String routeName="/map";
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static Position? position;
  late List<PlaceSuggestionsModel> places;
  static final CameraPosition _myCurrentLocation = CameraPosition(
    bearing: 0.0,
    target: LatLng(position!.latitude, position!.longitude),
    tilt: 0.0,
    zoom: 17,
  );
  final Completer<GoogleMapController> _mapController = Completer();

  // ignore: prefer_collection_literals
  Set<Marker> markers = Set();
  late PlaceSuggestionsModel placeSuggestion;
  late Place selectedPlace;
  late Marker searchedPlaceMarker;
  late Marker currentLocationMarker;
  late CameraPosition goToSearchedForPlace;

  // these variables for getDirections
  PlaceDirections? placeDirections;
  var progressIndicator = false;
   List<LatLng>? polylinePoints;
  var isTimeAndDistanceVisible = false;
  late String time;
  late String distance;

  late ThemeData _theme;


  @override
  void didChangeDependencies()async {
    _theme = Theme.of(context);
    getCurrentLocation();
    super.didChangeDependencies();
  }
  @override
  void initState() {
    super.initState();

  }
  void getSelectedPlacedLocation() {
    final sessiontoken = const Uuid().v4();
    MapsCubit.get(context).getPlaceLocation(
      placeId: placeSuggestion.placeId,
      sessiontoken: sessiontoken,
    );
  }
  void buildCameraNewPosition() {
    goToSearchedForPlace = CameraPosition(
      bearing: 0.0,
      tilt: 0.0,
      target: LatLng(
        selectedPlace.result!.geometry!.location!.lat!,
        selectedPlace.result!.geometry!.location!.lng!,
      ),
      zoom: 13,
    );
  }
  Future<void> getCurrentLocation() async {
    position = await LocationHelper.getCurrentLocation().whenComplete(() {
      buildCurrentLocationMarker();
      setState(() {});
    });
  }
  Future<void> _goToMyCurrentLocation() async {
    print('current Location');
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(_myCurrentLocation),
    );
    buildCurrentLocationMarker();
  }

  void buildSearchedPlaceMarker() {
    searchedPlaceMarker = Marker(
      markerId: const MarkerId('2'),
      position: goToSearchedForPlace.target,
      onTap: () {
        buildCurrentLocationMarker();
        setState(() {
          //isSearchedPlaceMarkerClicked = true;
          isTimeAndDistanceVisible = true;
        });
      },
      infoWindow: InfoWindow(
        title: placeSuggestion.description,
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
    addMarkerToMarkersAndUpdateUI(searchedPlaceMarker);
  }

  void buildCurrentLocationMarker() {
    currentLocationMarker = Marker(
      markerId: const MarkerId('1'),
      position: LatLng(position!.latitude, position!.longitude),
      infoWindow: const InfoWindow(
        title: 'your Current Location',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
    addMarkerToMarkersAndUpdateUI(currentLocationMarker);
  }

  void addMarkerToMarkersAndUpdateUI(Marker marker) {
    setState(() {
      markers.add(marker);
    });
  }
  void getSuggestions(String query) {
    final sessiontoken = const Uuid().v4();
    MapsCubit.get(context)
        .getSuggestionsCubit(place: query, sessiontoken: sessiontoken);
  }

  void getPolyLinePoints() {
    polylinePoints = placeDirections!.polyLinePoints
        .map((e) =>
        LatLng(
          e.latitude,
          e.longitude,
        ))
        .toList();
  }
  Future<void> goToMySearchedForLocation() async {
    buildCameraNewPosition();
    final GoogleMapController googleMapController = await _mapController.future;
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(goToSearchedForPlace));
    buildSearchedPlaceMarker();
  }

  void onNotificationPressed() {
      Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapsCubit, MapsState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: false,
          appBar: AppBar(
            title: SvgPicture.asset(
              'assets/images/logo_black.svg',
              height: 36,
              semanticsLabel: 'Discover Morocco',
            ),
            centerTitle: true,
            actions: const [
              AppBarProfile()
            ],
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 30.0,
              ),
              padding: const EdgeInsetsDirectional.only(start: 4),
              onPressed: onNotificationPressed
            ),
            elevation: 0,
            backgroundColor: _theme.canvasColor,
          ),
          body: SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: [
                ConditionalBuilder(
                  condition: position != null,
                  builder: (context) => buildMap(),
                  fallback: (context) =>
                  const Center(
                    child: CircularProgressIndicator(
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 8, 30),
            child: FloatingActionButton(
              onPressed: _goToMyCurrentLocation,
              child: const Icon(
                Icons.place,
                color: Colors.white,
              ),
            ),
          ),
          //drawer: const MyDrawer(),
        );
      },
    );
  }

  Widget buildMap() {
    return GoogleMap(
      markers: markers,
      mapType: MapType.normal,
      myLocationButtonEnabled: true,
      zoomControlsEnabled: false,
      myLocationEnabled: false,
      initialCameraPosition: _myCurrentLocation,
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
      },
      polylines: placeDirections != null
          ? {
        Polyline(
          polylineId: const PolylineId('my_polyline'),
          color: Colors.black,
          width: 2,
          points: polylinePoints!,
        )
      }
          : {},
    );
  }

  Widget buildSelectedPlaceLocationBloc() {
    return BlocListener<MapsCubit, MapsState>(
      listener: (context, state) {
        if (state is PlacesLocationLoadedSuccess) {
          selectedPlace = state.place;
          goToMySearchedForLocation();
          MapsCubit.get(context).getPlaceDirections(
            origin: LatLng(
              position!.latitude,
              position!.longitude,
            ),
            destination: LatLng(
              selectedPlace.result!.geometry!.location!.lat!,
              selectedPlace.result!.geometry!.location!.lng!,
            ),
          );

        }
      },
      child: Container(),
    );
  }

  Widget buildDirectionBloC() {
    return BlocListener<MapsCubit, MapsState>(
      listener: (context, state) {
        if (state is GetPlacesDirectionsSuccess) {
          placeDirections = state.readyDirection;
          getPolyLinePoints();
        }
      },
      child: Container(),
    );
  }

}
