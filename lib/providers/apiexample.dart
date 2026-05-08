import 'dart:developer';

import 'package:dialo/providers/modelclass.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiExample extends StatefulWidget {
  const ApiExample({super.key});

  @override
  _ApiExampleState createState() => _ApiExampleState();
}

class _ApiExampleState extends State<ApiExample> {
  List<User> users = [];

  Future<void> fetchUsers() async {
    final response = await http.get( Uri.parse("https://jsonplaceholder.typicode.com/users"), );

    if (response.statusCode == 200) {
      log(response.body);
      setState(() {
        users = ( json.decode(response.body) as List)
        .map((data)=> User.fromJson(data)).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("API Example")),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index].name),
            subtitle: Text(users[index].email),
          );
        },
      ),
    );
  }
}