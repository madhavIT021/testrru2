import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testrru/models/event.dart';



class DatabaseServices {
  final String uid;

  DatabaseServices({required this.uid});

  // Firestore instance




  // Collections for students and faculty
  final CollectionReference studentCollection = FirebaseFirestore.instance.collection("students");
  final CollectionReference facultyCollection = FirebaseFirestore.instance.collection("faculty");
  final CollectionReference eventCollection = FirebaseFirestore.instance.collection("events");

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

  Future<List<EventPost>> getEventData() async {
    QuerySnapshot snapshot = await eventCollection.get();
    return snapshot.docs.map((doc) {
      return EventPost(
        title: doc['title'] ?? '',
        description: doc['description'] ?? '',
        date: doc['date'] ?? '',
        location: doc['location'] ?? '',
        imageUrls: List<String>.from(doc['imageurl'] ?? []),
      );
    }).toList();
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