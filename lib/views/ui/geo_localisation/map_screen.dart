import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../../business_logic/models/models/place_directions.dart';
import '../../../business_logic/models/models/place_model.dart';
import '../../../business_logic/models/models/place_suggestions _model.dart';
import 'bloc/maps_cubit.dart';
import 'distance_and_time.dart';
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
  var isSearchedPlaceMarkerClicked = false;
  var isTimeAndDistanceVisible = false;
  late String time;
  late String distance;


  @override
  void initState() {
    super.initState();
    getCurrentLocation();
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
      setState(() {});
    });
  }
  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(_myCurrentLocation),
    );
  }

  void buildSearchedPlaceMarker() {
    searchedPlaceMarker = Marker(
      markerId: const MarkerId('2'),
      position: goToSearchedForPlace.target,
      onTap: () {
        buildCurrentLocationMarker();
        setState(() {
          isSearchedPlaceMarkerClicked = true;
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapsCubit, MapsState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              fit: StackFit.expand,
              children: [
               /* ConditionalBuilder(
                  condition: position != null,
                  builder: (context) => buildMap(),
                  fallback: (context) =>
                  const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                ),*/
                //buildFloatingSearchBar(),
                isSearchedPlaceMarkerClicked ? DistanceAndTime(
                  isTimeAndDistanceVisiable: isTimeAndDistanceVisible,
                  placeDirections: placeDirections,
                ):Container(),
              ],
            ),
          ),
          floatingActionButton: Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 8, 30),
            child: FloatingActionButton(
              backgroundColor: Colors.blue,
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


 /* Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery
            .of(context)
            .orientation == Orientation.portrait;

    return BlocBuilder<MapsCubit, MapsState>(
      builder: (context, state) {
        return FloatingSearchBar(
          controller: _floatingSearchBarController,
          hint: 'Search...',
          elevation: 6,
          progress: progressIndicator,
          hintStyle: const TextStyle(fontSize: 18),
          queryStyle: const TextStyle(fontSize: 18),
          border: const BorderSide(style: BorderStyle.none),
          margins: const EdgeInsets.fromLTRB(20, 50, 20, 0),
          padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
          height: 52,
          iconColor: Colors.blue,
          scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
          transitionDuration: const Duration(milliseconds: 600),
          transitionCurve: Curves.easeInOut,
          physics: const BouncingScrollPhysics(),
          axisAlignment: isPortrait ? 0.0 : -1.0,
          openAxisAlignment: 0.0,
          width: isPortrait ? 600 : 500,
          debounceDelay: const Duration(milliseconds: 500),
          onQueryChanged: (query) {
            getSuggestions(query);
          },
          onFocusChanged: (isFocused) {
            setState(() {
              isTimeAndDistanceVisible = false;
            });
          },
          transition: CircularFloatingSearchBarTransition(),
          actions: [
            FloatingSearchBarAction(
              showIfOpened: false,
              child: CircularButton(
                icon: Icon(
                  Icons.place,
                  color: Colors.black.withOpacity(0.6),
                ),
                onPressed: () {},
              ),
            ),

          ],
          builder: (context, transition) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Material(
                color: Colors.white,
                elevation: 4.0,
                child: Column(
                  children: [
                    if (state is PlacesLoading)
                      const SizedBox(
                        height: 100,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else
                      ListView.builder(
                        itemCount: MapsCubit
                            .get(context)
                            .suggestions
                            .length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              placeSuggestion =
                              MapsCubit
                                  .get(context)
                                  .suggestions[index];
                             // _floatingSearchBarController.close();
                              getSelectedPlacedLocation();
                              polylinePoints!.clear();
                             setState(() {
                               markers.clear();
                             });
                            },
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsetsDirectional.all(8),
                              padding: const EdgeInsetsDirectional.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.lightBlue,
                                      ),
                                      child: const Icon(
                                        Icons.place,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    title: RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text:
                                          '${MapsCubit
                                              .get(context)
                                              .suggestions[index].description
                                              .split(',')[0]}\n',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: MapsCubit
                                              .get(context)
                                              .suggestions[index]
                                              .description
                                              .replaceAll(
                                              MapsCubit
                                                  .get(context)
                                                  .suggestions[index]
                                                  .description
                                                  .split(',')[0],
                                              '')
                                              .substring(2),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    buildSelectedPlaceLocationBloc(),
                    buildDirectionBloC(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }*/

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
