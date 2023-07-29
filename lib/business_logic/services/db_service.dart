import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discover_morocco/business_logic/models/models/place.dart';
import 'package:discover_morocco/business_logic/models/models/video_category.dart';

class PlaceRepository {
  PlaceRepository(FirebaseFirestore instance);
  final _db = FirebaseFirestore.instance;

  Future<List<PlaceModel>> hotels() async {
    try {
      return List.empty();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<PlaceModel>> features() async {
    try {
      return List.empty();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<PlaceModel>> populars() async {
    try {
      return List.empty();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<PlaceCategoryModel>> categories() async {
    try {
      final snapshot = await _db
          .collection("Places")
          .get(); // where("isPublished",isEqualTo: true)
      final categories = snapshot.docs
          .map((e) => PlaceCategoryModel.fromJson(e.data()))
          .toList();

      return categories;
    } catch (e) {
      throw Exception(e);
    }
  }
}
