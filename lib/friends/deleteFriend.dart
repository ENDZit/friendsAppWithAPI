import 'package:flutter/material.dart';
import 'package:future1/api/friendsOperations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:future1/store/friendsStore.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'deleteFriend.g.dart';

@hwidget
Widget deleteFriendScreen(BuildContext context) {
  final _formKey = useMemoized(() => GlobalKey<FormState>());
  final deletedFriendName = useState('');

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
              onChanged: (name) {
                deletedFriendName.value = name;
              },
              validator: (name) {
                FilteringTextInputFormatter.digitsOnly;
                if (friend.friendsList.every(
                    (friend) => friend.name != '${deletedFriendName.value}')) {
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
                        await friend.removeFriend(deletedFriendName.value);
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
