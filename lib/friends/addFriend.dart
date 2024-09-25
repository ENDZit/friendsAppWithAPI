import 'package:flutter/material.dart';
import 'package:future1/api/friendsOperations.dart';
import 'package:flutter/services.dart';
import 'package:future1/store/friendsStore.dart';
import 'dart:async';

class FriendAddScreen extends StatefulWidget {
  const FriendAddScreen({super.key});

  @override
  FriendAddScreenState createState() => FriendAddScreenState();
}

class FriendAddScreenState extends State<FriendAddScreen> {
  final _formKey = GlobalKey<FormState>();
  String newFriendName = "";
  String newFriendAge = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter your friend`s data"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Friend`s name',
                  hintText: 'Enter your friend`s name'),
              validator: (name) {
                newFriendName = name.toString();
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Friend`s age',
                  hintText: 'Enter your friend`s name'),
              validator: (age) {
                FilteringTextInputFormatter.digitsOnly;
                newFriendAge = age.toString();
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
                        await friend.addFriend(newFriendName, newFriendAge);
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
                  child: const Text('Submit'),
                ))
              ],
            )
          ],
        ),
      )),
    );
  }
}
