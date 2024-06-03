import 'package:testrru/services/auth.dart';
import 'package:testrru/shared/constants.dart';
import 'package:testrru/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:testrru/services/validator.dart';

class Register extends StatefulWidget {
  final Function toogleView;
  final String? role;

  Register({required this.toogleView,required this.role});



  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final Authservice _auth = Authservice();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  String email = "";
  String password = "";
  String error = "";
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: const Text("Welcome to RRU",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text("Sign in"),
            onPressed: () {
              widget.toogleView();
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.blue[100], // foreground (text) color
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.all(0.0),
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
                key: _formkey,
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
                        if(val==null)
                          {
                            return "Enter valid  Password";
                          }
                        else if(!isValidPassword(val))
                          {
                            return 'Enter valid password';
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
                        if(_formkey.currentState!.validate())
                        {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth.registerWithEmailandPassword(email, password);
                          if(result==null)
                          {
                            setState(() {
                              error = "Enter a valid email or password";
                              // loading = true;
                            });
                          }
                        }
                      },
                      child: const Text(
                        'Register',
                      ),
                    ),

                    SizedBox(height: 20.0),
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red,fontSize: 15.0),
                    ),
                    // const Text(
                    //   "@2024 MD creation,All rights reserved",
                    //   style: TextStyle(color: Colors.black,fontSize: 15.0,fontStyle: FontStyle.italic,fontWeight: FontWeight.w300),
                    // ),

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
