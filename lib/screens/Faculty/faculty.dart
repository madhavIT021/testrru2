import 'package:flutter/material.dart';

class Faculty extends StatefulWidget {
  const Faculty({super.key});

  @override
  State<Faculty> createState() => _FacultyState();
}

class _FacultyState extends State<Faculty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text("Faculty Name"),
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          child: Image(image: AssetImage('assets/Logo copy.png')),
        ),
      ),
      body:const  Center(
        child: Text("Faculty dashboard"),
      ),
    );
  }
}
