import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final String uid;

  DatabaseServices({required this.uid});

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collections for students and faculty
  final CollectionReference studentCollection = FirebaseFirestore.instance.collection("students");
  final CollectionReference facultyCollection = FirebaseFirestore.instance.collection("faculty");

  Future<void> updateUserData( String role,Map<String,dynamic> data) async {
    if (role == 'student') {
      return await studentCollection.doc(uid).update(data);
    } else if (role == 'faculty') {
      return await facultyCollection.doc(uid).update(data);
    }else {
      throw Exception("Invalid role");
    }
  }

  Future<DocumentSnapshot> getUserData(String role) async {
    if (role == 'student') {
      return await studentCollection.doc(uid).get();
    } else if (role == 'faculty') {
      return await facultyCollection.doc(uid).get();
    } else {
      throw Exception("Invalid role");
    }
  }
}
