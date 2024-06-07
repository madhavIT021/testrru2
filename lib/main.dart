import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:testrru/screens/profile.dart';
import 'package:testrru/screens/select_role.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'services/auth.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyABmLpgxS_t3qr4WZLqBiVqNKAgxI_pun0",
        appId: "1:154033199482:android:993035257e013e22a49ec3",
        messagingSenderId: "154033199482",
        projectId: "testrru2-fd458",
        storageBucket: "testrru2-fd458.appspot.com",

      )
  );
  // debugStorageBucket();
  runApp(const MyApp());
}
// void debugStorageBucket() {
//   final storageBucket = FirebaseStorage.instance.bucket;
//   print('Firebase Storage Bucket: $storageBucket');
// }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Widget build(BuildContext context) {
    return StreamProvider<Users?>.value(
      value: Authservice().user,
      initialData: null,
      child:  MaterialApp(

        debugShowCheckedModeBanner: false,

        home: Role(),
      ),
    );
  }
}

