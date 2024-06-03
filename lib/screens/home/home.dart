import 'package:flutter/material.dart';
import 'package:testrru/services/auth.dart';
import 'package:testrru/services/search.dart';

class Home extends StatefulWidget {


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // bool _isSearching = false;
  // final TextEditingController _searchController = TextEditingController();
  final Authservice _auth = Authservice();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("R R U",

        ),
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 0.0),
          child: Image(image: AssetImage('assets/Logo copy.png')),
        ),


        actions: [
          IconButton(
              onPressed: (){
                showSearch(context: context, delegate: CustomSearchDelegate(),);
              },

              icon: const Icon(
                Icons.search,
              )),
        ],
      ),
      body: Center(
        child: Text('Search App Home Page'),
      ),
    );
  }

}