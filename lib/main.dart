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
        apiKey: "AIzaSyBtyM9npIQl3DgZxah278Ox9JuJ76diQDQ",
        appId: "1:45608366690:android:cdbec23bc1ad2c132d573",
        messagingSenderId: "45608366690",
        projectId: "testrru2",
        storageBucket: "testrru2.appspot.com",

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

