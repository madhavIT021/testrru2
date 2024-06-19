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
    if (role == 'Student') {
      return await studentCollection.doc(uid).update(data);
    } else if (role == 'Faculty') {
      return await facultyCollection.doc(uid).update(data);
    }else {
      throw Exception("Invalid role");
    }
  }

  Future<DocumentSnapshot> getUserData(String role) async {
    if (role == 'Student') {
      return await studentCollection.doc(uid).get();
    } else if (role == 'Faculty') {
      return await facultyCollection.doc(uid).get();
    } else {
      throw Exception("Invalid role");
    }
  }

  Future<List<Map<String, dynamic>>> fetchFacultyData() async {
    List<Map<String, dynamic>> facultyData = [];

    try {
      QuerySnapshot querySnapshot = await facultyCollection.get();
      querySnapshot.docs.forEach((doc) {
        facultyData.add(doc.data() as Map<String, dynamic>);
      });
      return facultyData;
    } catch (e) {
      print("Error fetching faculty data: $e");
      return [];
    }
  }



}