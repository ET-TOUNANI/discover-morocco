import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discover_morocco/business_logic/models/authentication/models/models.dart';
import 'package:discover_morocco/business_logic/utils/logicConstants.dart';

import '../models/models/publication.dart';

class DbService {
  DbService(FirebaseFirestore instance);
  final _db = FirebaseFirestore.instance;

  Future<bool> createPub(Publication publication) async {
    try {
      // Use the publication's ID as the document ID
      final publicationId = publication.id;

      // Get the reference to the document using the publication ID
      final pubRef = _db.collection('publications').doc(publicationId);

      // Set the data for the document
      await pubRef.set(publication.toJson());

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

  Future<bool> deletePub(Publication pub) async {
    try {
      // Get the reference to the document using the publication ID
      final pubRef = FirebaseFirestore.instance.collection("publications").doc(pub.id);

      // Use the delete() method to delete the document
      await pubRef.delete();

      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> updatePub(Publication pub) async {
    try {
      // Get the reference to the document using the publication ID
      final pubRef = _db.collection("publications").doc(pub.id);

      // Use set with merge option to update the existing document
      await pubRef.set(pub.toJson(), SetOptions(merge: true));

      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

}
