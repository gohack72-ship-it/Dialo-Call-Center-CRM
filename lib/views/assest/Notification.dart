import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  List<String> notifications = [
    "New message from John",
    "Your profile was viewed",
    "New friend request",
    "App update available",
    "Your post got a like",
    "New message from John",
    "Your profile was viewed",
    "New friend request",
    "App update available",

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return SingleChildScrollView(
            child: Card(
              child: ListTile(
                leading: Icon(Icons.notifications),
                title: Text(notifications[index]),
                subtitle: Text("Just now"),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}