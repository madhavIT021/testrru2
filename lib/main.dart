import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:testrru/screens/select_role.dart';
import 'package:testrru/screens/student/dashboard.dart';
import 'package:testrru/screens/student/main_screen.dart';
import 'services/auth.dart';
import 'package:testrru/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAEIFGQgXTORc-q356k-HREHARtnfuSW5M",
        appId: "1:276968077214:android:74145e66f2faa750b7088f",
        messagingSenderId: "276968077214",
        projectId: "testrru-83eea",
      )
  );
  runApp(const MyApp());
}

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

