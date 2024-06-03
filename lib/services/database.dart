import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final String uid;

  DatabaseServices({ required this.uid});

  //collection reference
  final CollectionReference Collection = FirebaseFirestore.instance.collection("students");

  Future updateUserData(String email) async {
    return await Collection.doc(uid).set({

      'email' : email,
    });
  }
  }