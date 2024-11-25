import 'package:flutter/material.dart';
import 'package:future1/api/friendsOperations.dart';
import 'package:flutter/services.dart';
import 'package:future1/store/friendsStore.dart';
import 'dart:async';
import 'package:flutter_hooks/flutter_hooks.dart';

class FriendAddScreen extends HookWidget {
  const FriendAddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = useMemoized(() => GlobalKey<FormState>() );
    final newFriendName = useState("");
    final newFriendAge = useState("");

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
              onChanged: (name) {
                 newFriendName.value = name;
              },
              validator: (name) {
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Friend`s age',
                  hintText: 'Enter your friend`s name'),
              onChanged: (age){
                newFriendAge. value = age;
              },
              validator: (age) {
                FilteringTextInputFormatter.digitsOnly;
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
                        await friend.addFriend(newFriendName.value, newFriendAge.value);
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
