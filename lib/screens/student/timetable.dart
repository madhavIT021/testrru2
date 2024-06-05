import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Timetable extends StatefulWidget {
  Timetable({super.key});

  @override
  State<Timetable> createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {
  final List<List<String>> tableData = [
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
            padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 30.0),
            child: Table(
              border: TableBorder.all(color: Colors.black),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: tableData.asMap().map((index, row) {
                return MapEntry(index, TableRow(
                  children: row.map((cell) {
                    return TableCell(

                      child: Container(
                        width: 500,
                        color: index == 0 ? Colors.blue[200] : null,  // Apply background color to the header row
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          cell,
                          style: TextStyle(
                            fontWeight: index == 0 ? FontWeight.bold : FontWeight.normal,  // Bold text for header row
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
      ),
    );
  }
}
