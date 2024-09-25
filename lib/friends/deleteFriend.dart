import 'package:flutter/material.dart';
import 'package:future1/api/friendsOperations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:future1/store/friendsStore.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class DeleteFriendScreen extends StatefulWidget {
  const DeleteFriendScreen({super.key});

  @override
  DeleteFriendScreenState createState() => DeleteFriendScreenState();
}

class DeleteFriendScreenState extends State<DeleteFriendScreen> {
  final _formKey = GlobalKey<FormState>();
  String deletedFriendName = "";

  @override
  Widget build(BuildContext context) {
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
                decoration: const InputDecoration(labelText: "Friend`s name"),
                validator: (name) {
                  FilteringTextInputFormatter.digitsOnly;
                  deletedFriendName = name.toString();
                  if (friend.friendsList
                      .every((friend) => friend.name != '$deletedFriendName')) {
                    return 'wrong friend name';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await friend.removeFriend(deletedFriendName);
                          Navigator.pushNamed(context, '/FriendsDetails');
                        } catch (e) {
                          final snackBar = SnackBar(
                            content: Text('error: ${e.runtimeType}'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                    child: const Text("delete"),
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
