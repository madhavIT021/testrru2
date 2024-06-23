import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';

// Example data model for an event post
class EventPost {
  final String title;
  final String description;
  final String date;
  final String location;
  final List<String> imageUrls;

  EventPost({
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.imageUrls,
  });
}

class EventPage extends StatelessWidget {
  final EventPost post;

  const EventPage({Key ?key, required this.post}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(

        child: Card(
          margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Images section
              SizedBox(
                height: 400.0,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 400.0,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    autoPlay: false,
                  ),
                  items: post.imageUrls.map((imageUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 0.0),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              // Description section
              ListTile(
                title: Text(post.location, style: TextStyle(fontWeight: FontWeight.bold),), // Event title
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post.description), // Event description
                    Text(post.date), // Event date
                    // Text(post.location), // Event location
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

