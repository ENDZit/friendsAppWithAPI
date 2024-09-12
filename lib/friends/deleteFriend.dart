import 'package:flutter/material.dart';
import 'package:future1/api/friendsOperations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:future1/store/friendsStore.dart';

class DeleteFriendScreen extends StatefulWidget{
  const DeleteFriendScreen({super.key});
  @override
  DeleteFriendScreenState createState() => DeleteFriendScreenState();
}
class DeleteFriendScreenState extends State<DeleteFriendScreen>{
  final friend = FriendsStore();
  final _formKey = GlobalKey<FormState>();
  String deletedFriendName = "";
  // List<dynamic> postFriends = [];

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
                  return null;
                },
              ),Row(
                children: [
                  Expanded(child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                      friend.removeFriend(deletedFriendName);
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