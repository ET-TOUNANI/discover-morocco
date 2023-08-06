import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discover_morocco/business_logic/models/authentication/models/models.dart';
UserModel userModel=const UserModel(id: '');
class UserService {
  UserService(FirebaseFirestore instance,);
  final _db = FirebaseFirestore.instance;


  Future<UserModel>fetchUser(String id)async{
    try {
       final snapshot = await getUserById(id);
       if(snapshot != null) {
         userModel=snapshot;
       }
       print("***************** $userModel");
       return userModel;

    } catch (e) {
      print("Error fetching current user: $e");
      throw Exception(e);
    }
  }

  Future<bool> createUser(UserModel user) async {
    try {
      final userId = user.id;

      final userRef = _db.collection('users').doc(userId);

      // Set the data for the document
      await userRef.set(user.toJson());
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }
  Future<UserModel?> getUserById(String userId) async {
    try {
      print("**************userId  $userId");
      final snapshot = await _db.collection("users").doc(userId).get();
      if (snapshot.exists) {
        return UserModel.fromJson(snapshot.data()!);
      }
      return null;
    } catch (e) {
      print("Error fetching current user: $e");
      return null;
    }
  }

  Future<bool> updateUser(UserModel user) async {
    try {
      // Get the reference to the document using the user ID
      final userRef = _db.collection("users").doc(user.id);

      // Use set with merge option to update the existing document
      await userRef.set(user.toJson(), SetOptions(merge: true));
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> deleteUser(UserModel user) async {
    try {
      // Get the reference to the document using the user ID
      final userRef = FirebaseFirestore.instance.collection("users").doc(user.id);

      // Use the delete() method to delete the document
      await userRef.delete();

      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

}
