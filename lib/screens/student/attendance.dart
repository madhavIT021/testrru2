import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Attendance extends StatefulWidget {
  Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  final List<List<String>> tableData = [
    ["Course", "Lecture","Percentage"],

  ];

  int? percentage = 75;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        children: <Widget>[
          const Divider(height: 50.0,),
          Text("Semester 4 Gross Attendance... $percentage%",
            style:const  TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
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
