import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FriendAddScreen extends StatefulWidget {
  const FriendAddScreen({super.key});

  @override
  FriendAddScreenState createState() => FriendAddScreenState();
}
class FriendAddScreenState extends State<FriendAddScreen> {
  final _formKey = GlobalKey<FormState>();
  String newFriendName = "";
  String newFriendAge = "";

  List<dynamic> postFriends = [];
  Future<void> addFriend(String name, String age) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.110:3000/friend-add'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'age': age,
      }),
    );
    if (response.statusCode == 201) {
      final responseBody = jsonDecode(response.body);
      setState(() {
        postFriends.add(responseBody);
      });
    } else {
      throw Exception('Failed');
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter your friend`s data"),
        backgroundColor: Colors.blueAccent,
      ),
      body:  Center(
          child: Form(
            key: _formKey,
            child: Column( children: [
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Friend`s name',
                    hintText: 'Enter your friend`s name'
                ),
                validator: (name){
                  newFriendName = name.toString();
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Friend`s age',
                    hintText: 'Enter your friend`s name'
                ),
                validator:(age){
                  newFriendAge = age.toString();
                },
              ),
              Row(
                children: [
                  Expanded(child: ElevatedButton(
                    onPressed: (){
                      if (_formKey.currentState!.validate()) {
                        // Perform submission logic
                        addFriend( newFriendName, newFriendAge);
                      }
                    },
                    child: const Text('Submit'),
                  ))
                ],
              )

            ],),
          )
      ),
    );
  }
}
