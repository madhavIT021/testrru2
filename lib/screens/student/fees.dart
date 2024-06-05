import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Fees extends StatefulWidget {
  Fees({super.key});

  @override
  State<Fees> createState() => _FeesState();
}

class _FeesState extends State<Fees> {
  final List<List<String>> tableData = [
    ["Semester", "Fees", "Received fees"],
    ["4", "62,000", "62,000"],
    ["3", "66,000", "66,000"],
    ["2", "62,000", "62,000"],
    ["1", "66,000", "66,000"],
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
