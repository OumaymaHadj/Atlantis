import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/users.dart';

class FireStoreUser {
  final CollectionReference _userCollectionRef =
  FirebaseFirestore.instance.collection('Users');

  Future<void> addUserToFireStore(Users userModel) async {
    return await _userCollectionRef
        .doc(userModel.uid)
        .set(userModel.toJson());
  }
}