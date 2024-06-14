import 'package:testrru/screens/authenticate/register.dart';
import 'package:testrru/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  final String? role;
  Authenticate({required this.role});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  void toogleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn)
    {
      // return SignIn( toggleView:toogleView,role: widget.role,);
      return SignIn( role: widget.role,);

    }
    else
    {
      return Register(toogleView:toogleView,role: widget.role,);
    }
  }
}