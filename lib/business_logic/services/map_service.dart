import 'package:dio/dio.dart';
import 'package:discover_morocco/business_logic/utils/logicConstants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlacesWebServices {
  static late Dio dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: Constant.mapBaseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
  }

  static Future<List<dynamic>> getSuggestions({
    required String place,
    required String sessiontoken,
  }) async {
    Response res = await dio.get(
      Constant.suggestionAutocompleteEndPoint,
      queryParameters: {
        'input': place,
        'type': 'address',
        'components': 'country:eg',
        'key': dotenv.get('MAP_KEY'),
        'sessiontoken': sessiontoken,
      },
    );
    return res.data['predictions'];
  }

  static Future<Map<String, dynamic>> getPlaceLocation({
    required String placeId,
    required String sessiontoken,
  }) async {
    Response res = await dio.get(
      Constant.placesLocationDetailsEndPoint,
      queryParameters: {
        'place_id': placeId,
        'fields': 'geometry',
        'key': dotenv.get('MAP_KEY'),
        'sessiontoken': sessiontoken,
      },
    );

    return res.data;
  }

// origin is current location or placeId
  static   Future<Map<String,dynamic>> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    Response res = await dio.get(
      Constant.directionsEndPoint,
      queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': dotenv.get('MAP_KEY'),
      },
    );

    return res.data;
  }
}
