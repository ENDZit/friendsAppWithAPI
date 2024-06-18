import 'package:flutter/material.dart';
import 'friends/deleteFriend.dart';
import 'friends/friendsDetails.dart';
import 'friends/addFriend.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: const FriendsDetails(),
      initialRoute: '/',
      routes: {
        '/AddFriendScreen': (context) => const FriendAddScreen(),
        '/DeleteFriendScreen': (context) => const DeleteFriendScreen(),
      },
    );
  }
}



