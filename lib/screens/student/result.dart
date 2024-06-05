import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Result extends StatefulWidget {
  Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  final List<List<String>> tableData = [
    ["Course", "Credit", "Grade"],
   ];

  String _selectedValue = 'Select';
  bool _isTableVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(

            top: 35.0,
            right: 30.0,
            child:_isTableVisible ? SizedBox() : DropdownButton<String>(
              value: _selectedValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 14,
              elevation: 50,
              style: TextStyle(color: Colors.black),
              disabledHint: Text("Select"),
              onChanged: (String? newValue) {
                setState(() {
                 if(newValue=='Select')
                   {
                     _selectedValue = newValue!;
                     _isTableVisible = false;
                   }
                 else{
                   _selectedValue = newValue!;
                   _isTableVisible = true;
                 }
                });
              },
              items: <String>['Select','Sem 1', 'Sem 2', 'Sem 3', 'Sem 4']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),

                );
              }).toList(),
            ),
          ),
          _isTableVisible ?
            Column(
              children: <Widget>[
                const SizedBox(height: 50.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 30.0, horizontal: 30.0),
                  child: Table(
                    border: TableBorder.all(color: Colors.black),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: tableData.asMap().map((index, row) {
                      return MapEntry(index, TableRow(
                        children: row.map((cell) {
                          return TableCell(
                            child: Container(
                              width: 500,
                              color: index == 0 ? Colors.blue[200] : null,
                              // Apply background color to the header row
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                cell,
                                style: TextStyle(
                                  fontWeight: index == 0
                                      ? FontWeight.bold
                                      : FontWeight
                                      .normal, // Bold text for header row
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ));
                    }).values.toList(),
                  ),
                ),
              ],
            ) : Center(child: Text("Select semester")),

        ],
      ),
    );
  }
}


