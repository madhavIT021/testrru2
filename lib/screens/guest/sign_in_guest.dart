import 'package:flutter/material.dart';
import 'package:testrru/services/auth.dart';
import 'package:testrru/shared/constants.dart';
import 'package:testrru/shared/loading.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class SignInn extends StatefulWidget {
  final Function toggleView;
  final String? role;


  SignInn({required this.toggleView, required this.role});
  // SignInn({ required this.role});


  @override
  _SignInnState createState() => _SignInnState();
}

class _SignInnState extends State<SignInn> {
  final Authservice _auth = Authservice();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String error = '';

  // text field state
  String email = '';
  String password = '';
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
        title: Text(
          "Welcomeback",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        // actions: <Widget>[
        //   TextButton.icon(
        //     icon: Icon(Icons.person),
        //     label: Text('Register'),
        //     onPressed: () => widget.toggleView(),
        //     style: ElevatedButton.styleFrom(
        //       foregroundColor:
        //       Colors.blue[100], // foreground (text) color
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
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
                      decoration:
                      textDecoretion.copyWith(hintText: 'Email'),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Enter an email';
                        }
                        // else if (!isValidEmail(val)) {
                        //   return 'Enter a valid email address';
                        // }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                      textDecoretion.copyWith(hintText: 'Password'),
                      obscureText: true,
                      validator: (val) => val!.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, // foreground (text) color
                        backgroundColor: Colors.blue[400], // background color
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          try {
                            dynamic result = await _auth.signInWithEmailandPassword(email, password);
                            print(result);
                            if (result == null) {
                              setState(() {
                                error = 'Could not sign in with those credentials';
                                loading = false;
                              });
                            }
                          } catch (e) {
                            setState(() {
                              error = 'Invalid Email or Password';
                              loading = false;
                            });
                          }
                        }
                      },
                    ),

                    TextButton.icon(
                      icon: Icon(Icons.person),
                      label: Text("Do not have account? Register"),
                      onPressed: () {
                        widget.toggleView();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.red, // background color
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}