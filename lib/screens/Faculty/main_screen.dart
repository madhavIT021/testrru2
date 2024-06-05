import 'package:flutter/material.dart';
import 'package:testrru/screens/student/dashboard.dart';
import 'package:testrru/screens/Faculty/faculty.dart';
import 'package:testrru/screens/home/home.dart';
import 'package:testrru/screens/profile.dart';

class MainScreenF extends StatefulWidget {
  const MainScreenF({super.key});

  @override
  State<MainScreenF> createState() => _MainScreenFState();
}

class _MainScreenFState extends State<MainScreenF> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    Faculty(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
       child: Scaffold(
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'Faculty',
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.emoji_emotions),
                label: 'Profile',
              ),

            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
            onTap: _onItemTapped,
          ),
        ),


    );
  }
}
