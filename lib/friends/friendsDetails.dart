import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FriendsDetails extends StatefulWidget {
  const FriendsDetails({super.key});

  @override
  FriendsDetailsState createState() => FriendsDetailsState();
}

class FriendsDetailsState extends State<FriendsDetails> {
  List<dynamic> postFriends = [];

  Future<void> friends() async {
    final response =
    await http.get(Uri.parse('http://192.168.1.110:3000/friends-list'));
    if (response.statusCode == 200) {
      setState(() {
        postFriends = jsonDecode(response.body);
      });
    } else {
      throw Exception('ERROR');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends'), backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          children: [ Row(children: [ Expanded(child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/AddFriendScreen');
              },
              child: const Text('friends add')),),
            Expanded(child: ElevatedButton(onPressed: () {
              friends();
            }, child: const Text('show friends'))),
            Expanded(child: ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/DeleteFriendScreen');
              },
              child: const Text('delete friend'),
            ))

          ],),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView.builder(
                  itemCount: postFriends.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(postFriends[index]['name']),
                        subtitle: Text(postFriends[index]['age']));
                  },
                ))
          ],
        ),
      ),
    );
  }
}
