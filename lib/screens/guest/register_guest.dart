import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:testrru/services/auth.dart';
import 'package:testrru/shared/constants.dart';
import 'package:testrru/shared/loading.dart';
import 'package:testrru/services/validator.dart';

class Registern extends StatefulWidget {
  final Function toggleView;
  final String? role;

  Registern({required this.toggleView, required this.role});

  @override
  State<Registern> createState() => _RegisternState();
}

class _RegisternState extends State<Registern> {
  final Authservice _auth = Authservice();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = "";
  String password = "";
  String error = "";
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: const Text(
          "Welcome to RRU",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(0.0),
                child: Center(
                  child: Image(
                    image: AssetImage('assets/Logo copy.png'),
                    // width: 200,
                    // height: 200,
                  ),
                ),
              ),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Pioneering National Security and\n Police University of India',
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                    speed: Duration(milliseconds: 50),
                  ),
                ],
                totalRepeatCount: 1,
                pause: Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),
              SizedBox(height: 20.0),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: textDecoretion.copyWith(hintText: 'Email'),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Enter an email';
                        } else if (!isValidEmail(val)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textDecoretion.copyWith(hintText: 'Password'),
                      obscureText: true,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Enter a password';
                        } else if (!isValidPassword(val)) {
                          return 'Enter a valid password';
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, // foreground (text) color
                        backgroundColor: Colors.blue[400], // background color
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth.registerWithEmailandPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error = "Enter a valid email or password";
                              loading = false;
                            });
                          }
                        }
                      },
                      child: const Text(
                        'Register',
                      ),
                    ),

                    // "Already registered?" section
                    TextButton.icon(
                      icon: Icon(Icons.person),
                      label: Text("Already registered? Sign in"),
                      onPressed: () {
                        widget.toggleView();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.red, // background color

                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red, fontSize: 15.0),
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),

              // Footer text
              // Text(
              //   "@2024 MD creation,All rights reserved",
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontSize: 15.0,
              //     fontStyle: FontStyle.italic,
              //     fontWeight: FontWeight.w300,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
