import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Timetable extends StatelessWidget {
  Timetable({super.key});
  List<List<String>> tableData = [
    ["Time", "Subject", "Faculty"],
    ["9:10 AM - 11:10 AM", "DAA", "prof. ABC"],
    ["11:10 AM - 12:10 PM", "Lunch Break", "-"],
    ["12:10 AM - 02:10 PM", "DBMS", "prof. XYZ"],
    ["02:10 AM - 02:20 PM", "Break", "-"],
    ["02:20 AM - 03:20 PM", "-", "-"],
    ["03:20 AM - 04:20 PM", "-", "-"],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(height: 30.0,),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Table(
              border: TableBorder.all(color: Colors.black),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: tableData.map((row) {
                return TableRow(
                  children: row.map((cell) {
                    return TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          cell,
                        ),
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
