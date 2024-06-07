import 'package:testrru/models/user.dart';
import 'package:testrru/screens/Faculty/main_screen.dart';
import 'package:testrru/screens/authenticate/authenticate.dart';
import 'package:testrru/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testrru/screens/student/main_screen.dart';

class Wrapper extends StatelessWidget {
  final String? role;

  const Wrapper({required this.role});

  @override
  Widget build(BuildContext context) {


    final user = Provider.of<Users?>(context);
    print(user);

    if (user == null) {
      return Authenticate(
        role: role,
      );
    } else if (role == 'Student') {
      return MainScreen();
    } else if (role == 'Faculty') {
      return MainScreenF();
    } else  {
      return Home();
    }
  }
}
