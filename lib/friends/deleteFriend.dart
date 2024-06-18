import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'dart:convert';

class DeleteFriendScreen extends StatefulWidget{
  const DeleteFriendScreen({super.key});
  @override
  DeleteFriendScreenState createState() => DeleteFriendScreenState();
}
class DeleteFriendScreenState extends State<DeleteFriendScreen>{
  final _formKey = GlobalKey<FormState>();
  String deletedFriendName = "";
  List<dynamic> postFriends = [];
  Future<void> deleteFriend(String name) async{
    final response = await http.delete(Uri.parse('http://192.168.1.110:3000/friend-delete/$name'));
    if(response.statusCode == 200){
      setState(() {
        postFriends.remove(response.body);
      });
    }else{
      throw Exception('Failed');
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete friend'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    labelText: "Friend`s name"
                ),
                validator:(name){
                  deletedFriendName = name.toString();
                },
              ),Row(
                children: [
                  Expanded(child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        deleteFriend(deletedFriendName);
                      }
                    },
                    child: const Text("delete"),
                  ))
                ],
              )

            ],
          ),
        ),
      ) ,
    );
  }
}