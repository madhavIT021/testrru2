import 'package:flutter/material.dart';
import 'package:testrru/screens/inbox_screen.dart';
import 'package:testrru/screens/student/dashboard.dart';
import 'package:testrru/screens/profile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  DateTime prv_backpress = DateTime.now();

  static final List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    ProfilePage(selected_role: "Student",),
    Inbox(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  Future<bool> _onPop() async {
    final timeGap = DateTime.now().difference(prv_backpress);
    final canExit = timeGap >= Duration(seconds: 2);
print(timeGap);
    if (!canExit) {
      return true; // Exit the app
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Press back again to exit the app')),
      );
      prv_backpress = DateTime.now();
      return false; // Do not exit the app
    }
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
