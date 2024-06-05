import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testrru/screens/student/attendance.dart';
import 'package:testrru/screens/student/fees.dart';
import 'package:testrru/screens/student/result.dart';
import 'package:testrru/screens/student/timetable.dart';
import 'package:testrru/shared/transition_animation.dart';

class CustomContainer extends StatelessWidget {

  final double? h;
  final String? container;

  CustomContainer({required this.h,required this.container});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: h,
      decoration: BoxDecoration(
        color: Colors.lightBlue[100], // Light blue background
        border: Border.all(
          color: Colors.blue, // Blue border color
          width: 2, // Border width
        ),
      ),
      child: Center(
        child: Text(
          '$container',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

class FadingContainer extends StatefulWidget {

  late final String container;
  final double? h;
  FadingContainer({required this.h, required this.container});
  @override
  _FadingContainerState createState() => _FadingContainerState();
}

class _FadingContainerState extends State<FadingContainer> {
  bool _isClicked = false;

  void navigateToScreen(String? role) {
    // if (role == 'Time table') {
    //   Navigator.push(
    //     context,
    //     SlidePageRoute(page: Timetable()),
    //   );
    // }
    switch(role){
      case 'Timetable' : {
    Navigator.push(
        context,
        SlidePageRoute(page: Timetable()),
      );
      }
      break;
      case 'Attendance' : {
        Navigator.push(
          context,
          SlidePageRoute(page: Attendance()),
        );
      }
      break;
      case 'Fees' : {
        Navigator.push(
          context,
          SlidePageRoute(page: Fees()),
        );
      }
      break;
      case 'Result' : {
        Navigator.push(
          context,
          SlidePageRoute(page: Result()),
        );
      }

    }

  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isClicked = !_isClicked;
        });
      },
      child: AnimatedOpacity(
        opacity: _isClicked ? 1.0 : 0.8,
        duration: Duration(seconds: 1),
        child: Container(
          margin: EdgeInsets.all(8.0),
          height: widget.h,
          decoration: BoxDecoration(
            color: Colors.lightBlue[100],
            border: Border.all(
              color: Colors.blue,
              width: 2,
            ),
          ),
          child: TextButton(
            onPressed: () => navigateToScreen(widget.container),
            child: Center(
              child:  Text(
                widget.container,
                style: TextStyle(fontSize: 16),
              )
            ),
          ),

        ),
      ),
    );
  }
}
