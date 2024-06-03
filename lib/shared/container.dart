import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {

  double? h;
  String? container;

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
  @override
  _FadingContainerState createState() => _FadingContainerState();
}

class _FadingContainerState extends State<FadingContainer> {
  bool _isClicked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isClicked = !_isClicked;
        });
      },
      child: AnimatedOpacity(
        opacity: _isClicked ? 1.0 : 0.5,
        duration: Duration(seconds: 1),
        child: Container(
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.lightBlue[100],
            border: Border.all(
              color: Colors.blue,
              width: 2,
            ),
          ),
          child: Center(
            child: _isClicked
                ? Text(
              'Hello, Flutter!',
              style: TextStyle(fontSize: 16),
            )
                : null,
          ),
        ),
      ),
    );
  }
}
