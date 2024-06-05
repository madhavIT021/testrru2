import 'package:flutter/material.dart';
import 'package:testrru/services/auth.dart';
import 'package:testrru/shared/container.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final Authservice _auth = Authservice();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Dashboard",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        leading: const Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          child: Image(image: AssetImage('assets/Logo copy.png')),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: FadingContainer(h: 150, container: "Time table",)),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                    child: FadingContainer(h: 150, container: "Attendance")),
              ],
            ),
            SizedBox(height: 10), // Add spacing between rows
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: FadingContainer(h: 150, container: "Fee Payment",)),
                SizedBox(width: 10),
                Expanded(
                    child: FadingContainer(h: 150, container: "Result",)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
