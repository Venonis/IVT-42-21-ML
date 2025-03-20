// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_application_1/domain/services/model/user_data.dart';
// import 'package:flutter_application_1/domain/services/user_data/user_data_services_interface.dart';

// class UserDataService extends UserDataServiceInterface {
//   final CollectionReference users = FirebaseFirestore.instance.collection('users');
//   @override
//   Future<UserData> getUserData() async {
//     try {
//       return users
//           .doc(FirebaseAuth.instance.currentUser!.uid)
//           .get()
//           .then((snapshot) async {
//         var userData = UserData.fromJson(snapshot.data() as Map<String, dynamic>);
//         return userData;
//       });
//     } on FirebaseException catch (e) {
//       throw e.message.toString();
//     }
//   }

//   @override
//   Future<void> addUserData({
//     required String name,
//     required String email,
//   }) async {
//     try {
//       await users.doc(FirebaseAuth.instance.currentUser!.uid).set({
//         'userId': FirebaseAuth.instance.currentUser!.uid,
//         'name': name,
//         'email': email,
//         'description': '',
//         'timestamp': Timestamp.now(),
//       });
//     } on FirebaseException catch (e) {
//       throw e.message.toString();
//     }
//   }

//   @override
//   Future<void> updateUserData({
//     required String name,
//     required String description,
//   }) async {
//     try {
//       await users.doc(FirebaseAuth.instance.currentUser!.uid).update({
//         'name': name,
//         'description': description,
//       });
//     } on FirebaseException catch (e) {
//       throw e.message.toString();
//     }
//   }

//   @override
//   Future<void> deleteUserData() async {
//     try {
//       await users.doc(FirebaseAuth.instance.currentUser!.uid).delete();
//     } on FirebaseException catch (e) {
//       throw e.message.toString();
//     }
//   }
// }
