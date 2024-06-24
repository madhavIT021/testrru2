import 'package:testrru/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:testrru/screens/guest/sign_in_guest.dart';
import 'package:testrru/screens/guest/register_guest.dart';

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
    if (widget.role == "Guest") {
      if (showSignIn) {
        return Registern(toggleView: toogleView, role: widget.role);
      } else {
        return SignInn(toggleView: toogleView, role: widget.role);
      }
    } else {
      return SignIn(role: widget.role);
    }
  }
}
