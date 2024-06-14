
import 'dart:async';
import 'package:testrru/models/user.dart';
import 'package:testrru/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
class Authservice {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //creat user object based on firebaseUser(User)
  Users? _userFromFirebaseUser(User? user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<Users?> get user {
    return _auth
        .authStateChanges()
    //.map((User? user) =>  _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  //sign anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register using email and password
  Future registerWithEmailandPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      //creat a new document for the user with uid
      // await DatabaseServices(uid : user!.uid).updateUserData('${user.email}' );
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  String? error;
  //sign in using email and password
  Future signInWithEmailandPassword(String email, String password) async {
    try {

      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;


      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  //signout
  Future signOut() async {
    return _auth.signOut();
  }

  //Upload image to firebase_storage
  Future<String?> uploadImage(File profileImage) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return null;

      final timestamp = DateTime.now().microsecondsSinceEpoch;
      final filename = profileImage.path.split("/").last;
      final userID = user.uid;
      final storageRef = FirebaseStorage.instance.ref().child('$userID/profile_images/$timestamp-$filename');
      final uploadTask = storageRef.putFile(profileImage);

      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'profileImageUrl': downloadUrl,
      }, SetOptions(merge: true));

      return fetchProfileImageUrl();
    } catch (e) {
      print('Failed to upload image: $e');
      return null;
    }
  }

  // fetch the image from storage
  Future<String?> fetchProfileImageUrl() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final docSnapshot = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    return docSnapshot.data()?['profileImageUrl'] as String?;
  }

}