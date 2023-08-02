import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/models/publication.dart';

class DbService {
  DbService(FirebaseFirestore instance);
  final _db = FirebaseFirestore.instance;

  Future<bool> createPub(Publication publication) async {
    try {
      await _db.collection('publications').add(publication.toJson());
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }
  Future<List<Publication>> hotels() async {
    try {
      final snapshot = await _db
          .collection("publications")
          .where("isPublished",isEqualTo: true).get();
      final publications = snapshot.docs
          .map((e) => Publication.fromJson(e.data()))
          .toList();

      return publications;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Publication>> features() async {
    try {
      final snapshot = await _db
          .collection("publications")
          .where("isPublished",isEqualTo: true).get();
      final publications = snapshot.docs
          .map((e) => Publication.fromJson(e.data()))
          .toList();

      return publications;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Publication>> populars() async {
    try {
      final snapshot = await _db
          .collection("publications")
          .where("isPublished",isEqualTo: true).get();
      final publications = snapshot.docs
          .map((e) => Publication.fromJson(e.data()))
          .toList();

      return publications;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Publication>> publications() async {
    try {
      final snapshot = await _db
          .collection("publications")
         .where("isPublished",isEqualTo: true).get();
      final publications = snapshot.docs
          .map((e) => Publication.fromJson(e.data()))
          .toList();

      return publications;
    } catch (e) {
      throw Exception(e);
    }
  }
}
