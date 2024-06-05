import 'dart:ffi';

import 'package:testrru/screens/home/home.dart';
import 'package:testrru/screens/wrapper.dart';
import 'package:testrru/services/auth.dart';
import 'package:testrru/shared/constants.dart';
import 'package:testrru/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:testrru/shared/transition_animation.dart';

class Role extends StatefulWidget {
  @override
  State<Role> createState() => _RoleState();
}

class _RoleState extends State<Role> {
  final Authservice _auth = Authservice();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  void navigateToScreen(String role) {
    if (role == 'Guest') {
      Navigator.push(
        context,
        SlidePageRoute(page: Home(),millisecinds: 990),
      );
    } else {
      Navigator.push(
        context,
        SlidePageRoute(page: Wrapper(role: role),millisecinds: 990),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.blue[100],
            // appBar: AppBar(
            //   backgroundColor: Colors.blue[400],
            //   elevation: 0.0,
            //   title: const Text(
            //     "Welcome",
            //     style: TextStyle(fontWeight: FontWeight.w500),
            //   ),
            // ),

            body:TweenAnimationBuilder(
              tween: Tween(begin: 0.0,end: 1.0),
              duration: Duration(milliseconds: 500),
              builder: (context,val ,child){
                return Opacity(opacity: val,
                  child: Padding(
                    padding: EdgeInsets.only(top: val * 110),
                    child: child,
                  ),
                );
              },
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  margin: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
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
                      SizedBox(
                        height: 20.0,
                      ),
                      Column(
                        children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            ElevatedButton.icon(
                              onPressed: () {

                                navigateToScreen('Student');
                              },
                              label: Text('Student',
                                  style: TextStyle(fontSize: 15.0)),
                              icon: Icon(Icons.school),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                navigateToScreen('Faculty');
                              },
                              label: Text('Faculty',
                                  style: TextStyle(fontSize: 15.0)),
                              icon: Icon(Icons.person),
                            ),

                            ],
                        ),
                          ElevatedButton.icon(
                            onPressed: () {
                              navigateToScreen('Guest');
                            },
                            label: Text('Guest',
                                style: TextStyle(fontSize: 15.0)),
                            icon: Icon(Icons.person_2_outlined),
                          ),


                            // const Text(
                            //   "@2024 MD creation,All rights reserved",
                            //   style: TextStyle(color: Colors.black,fontSize: 15.0,fontStyle: FontStyle.italic,fontWeight: FontWeight.w300),
                            // ),
                          ],
                        ),

                    ],
                  ),
                ),
            ),
          );
  }
}
