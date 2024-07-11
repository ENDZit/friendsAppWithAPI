import 'package:flutter/material.dart';
import 'package:future1/api/friendsOperations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class FriendsDetails extends StatefulWidget {
  const FriendsDetails({super.key});

  @override
  FriendsDetailsState createState() => FriendsDetailsState();
}

@override
class FriendsDetailsState extends State<FriendsDetails> {
  final friend = GetFriendsStore();

  @override
  void initState() {
    super.initState();
    friend.updateFriends();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/AddFriendScreen');
                      },
                      child: const Text('friends add')),
                ),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          friend.updateFriends();
                        },
                        child: (const Text('refresh friends')))),
                Expanded(
                    child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/DeleteFriendScreen');
                  },
                  child: const Text('delete friend'),
                ))
              ],
            ),
            Expanded(child: Observer(builder: (_) {
              if (friend.friendsList.status == FutureStatus.fulfilled) {
                final friends = friend.friendsList.value;
                return ListView.builder(
                  itemCount: friends!.length,
                  itemBuilder: (contex, index) {
                    return ListTile(
                      title: Text(friends[index]['name']),
                      subtitle: Text(friends[index]['age']),
                    );
                  },
                );
              }
              return Container();
            }))
          ],
        ),
      ),
    );
  }
}
