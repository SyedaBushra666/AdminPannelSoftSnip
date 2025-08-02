import 'package:flutter/material.dart';

void showRightFilterPanel(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Align(
        alignment: Alignment.centerRight,
        child: Material(
          color: Colors.white,
          child: Container(
            width: 350,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Filters", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                // Your filter fields here
                TextField(decoration: InputDecoration(labelText: "Search")),
                Spacer(),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Apply"),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
