import 'package:flutter/material.dart';
import 'package:future1/api/friendsOperations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:future1/store/friendsStore.dart';
import 'package:mobx/mobx.dart';

class FriendsDetails extends StatefulWidget {
  const FriendsDetails({super.key});

  @override
  FriendsDetailsState createState() => FriendsDetailsState();
}

@override
class FriendsDetailsState extends State<FriendsDetails> {
  final friend = FriendsStore();

  @override
  void initState() {
    super.initState();
    friend.loadFriends();
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
              if (friend.friendsList.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  itemCount: friend.friendsList.length,
                  itemBuilder: (contex, index) {
                    final friend1 = friend.friendsList[index];
                    return ListTile(
                      title: Text(friend1.name),
                      subtitle: Text(friend1.age),
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
