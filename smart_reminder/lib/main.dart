import 'package:flutter/material.dart';

void main() {
  runApp(SmartReminderApp());
}

class SmartReminderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Reminder Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<String> notes = [
    "Buy groceries at 6 PM",
    "Meeting with team tomorrow",
    "Doctor appointment reminder"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Reminder Notes"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(notes[index]),
              subtitle: Text("Reminder: Not Set"),
              leading: Icon(Icons.note),
              trailing: Icon(Icons.notifications),
            ),
          );
        },
      ),

      // Floating Buttons
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Add Text Note
          FloatingActionButton(
            heroTag: "text",
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Add Text Note Clicked")),
              );
            },
            child: Icon(Icons.edit),
            tooltip: "Add Note",
          ),
          SizedBox(height: 10),

          // Record Voice Note
          FloatingActionButton(
            heroTag: "voice",
            backgroundColor: Colors.green,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Record Voice Clicked")),
              );
            },
            child: Icon(Icons.mic),
            tooltip: "Record Voice",
          ),
          SizedBox(height: 10),

          // Set Reminder
          FloatingActionButton(
            heroTag: "reminder",
            backgroundColor: Colors.orange,
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Set Reminder Clicked")),
              );
            },
            child: Icon(Icons.alarm),
            tooltip: "Set Reminder",
          ),
        ],
      ),
    );
  }
}