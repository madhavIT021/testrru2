import 'package:flutter/material.dart';
import 'package:testrru/models/event.dart';
import 'package:testrru/screens/authenticate/authenticate.dart';
import 'package:testrru/screens/guest/register_guest.dart';
import 'package:testrru/services/database.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<EventPost> _eventPosts = []; // Example list of event posts
  DatabaseServices _db = DatabaseServices(uid: "");
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchEventData();
  }

  Future<void> _fetchEventData() async {
    List<EventPost> eventPosts = await _db.getEventData();
    setState(() {
      _eventPosts = eventPosts;
      _isLoading = false;
    });
  }
  bool showSignIn = true;
  void toogleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("R R U"),
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          child: Image(image: AssetImage('assets/Logo copy.png')),
        ),
        actions: [
          Tooltip(
            message: 'Notifications',
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Authenticate(role: "Guest"),
                    ),
                  );
                },
                child: Icon(Icons.notifications_active),
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _eventPosts.length,
        itemBuilder: (context, index) {
          return _buildEventPostCard(_eventPosts[index]);
        },
      ),
    );
  }

  Widget _buildEventPostCard(EventPost post) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventPage(post: post),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              post.imageUrls.isNotEmpty ? post.imageUrls[0] : '',
              fit: BoxFit.cover,
              height: 400,
            ),

            // Title section with expandable description
            ListTile(
              leading: Container(
                width: 24.0,
                child: null,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTile(
                    title: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventPage(post: post),
                          ),
                        );
                      },
                      child: Text(
                        post.location,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.visible,
                      ),
                    ),

                  ),
                  SizedBox(height: 8.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventPage(post: post),
                        ),
                      );
                    },
                    child: ExpandableText(
                      post.description,
                      trim: 2,
                      linkTextStyle: TextStyle(color: Colors.blue),
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

