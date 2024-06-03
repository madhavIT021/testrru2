import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate{
  List<String> terms = [
    'Apple',
    'Banana',
    'Orange',
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {

    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear)),
    ];
    // TODO: implement buildActions
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {

    return  IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
    // TODO: implement buildLeading
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {

    List<String> matchquary = [];

    for(var fruits in terms)
      {
        if(fruits.toLowerCase().contains(query.toLowerCase()))
          {
            matchquary.add(fruits);
          }
      }
    
    return ListView.builder(
      itemBuilder: (context,index)
      {
        var result = matchquary[index];
        return ListTile(
          title: Text(result),
        );
      },
      itemCount: matchquary.length,
    );
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    List<String> matchquary = [];

    for(var fruits in terms)
    {
      if(fruits.toLowerCase().contains(query.toLowerCase()))
      {
        matchquary.add(fruits);
      }
    }

    return ListView.builder(
      itemBuilder: (context,index)
      {
        var result = matchquary[index];
        return ListTile(
          title: Text(result),
        );
      },
      itemCount: matchquary.length,
    );
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }

}