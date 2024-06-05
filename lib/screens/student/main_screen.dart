import 'package:flutter/material.dart';
import 'package:testrru/screens/inbox_screen.dart';
import 'package:testrru/screens/student/dashboard.dart';
import 'package:testrru/screens/Faculty/faculty.dart';
import 'package:testrru/screens/home/home.dart';
import 'package:testrru/screens/profile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;


  static final List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    ProfilePage(),
    Inbox(),
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
                icon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.emoji_emotions),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.inbox_rounded),
                label: 'Inbox',
              ),

            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
            onTap: _onItemTapped,
          ),

        // debugShowCheckedModeBanner: false,
      ),
    );
  }
}
