import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discover_morocco/business_logic/models/authentication/models/models.dart';
import 'package:discover_morocco/business_logic/utils/logicConstants.dart';

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

  Future<List<Publication>> getPublicationsByUser(UserModel user) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot;
      if (user.id == Constant.adminId) {
        snapshot = await _db.collection("publications").get();
      } else {
        snapshot = await _db
            .collection("publications")
            .where("user.id", isEqualTo: user.id)
            .get();
      }

      final publications =
          snapshot.docs.map((e) => Publication.fromJson(e.data())).toList();

      return publications;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Publication>> waitingPublications() async {
    try {
      final snapshot = await _db
          .collection("publications")
          .where("state", isEqualTo: "pending")
          .get();
      final publications =
          snapshot.docs.map((e) => Publication.fromJson(e.data())).toList();

      return publications;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Publication>> publications() async {
    try {
      final snapshot = await _db
          .collection("publications")
          .where("isPublished", isEqualTo: true)
          .get();
      final publications =
          snapshot.docs.map((e) => Publication.fromJson(e.data())).toList();

      return publications;
    } catch (e) {
      throw Exception(e);
    }
  }

//TODO: Delete Pub by ID
  Future<bool> deletePub(Publication pub) async {
    try {
      // TODO : how to delete from firestore
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> updatePub(Publication pub) async {
    try {
      await _db.collection("publications").add(pub.toJson());
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }
//TODO: update an pub
}
