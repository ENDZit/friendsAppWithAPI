import 'package:flutter/material.dart';
import 'package:future1/api/friendsOperations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:future1/store/friendsStore.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:future1/friend.dart';

class FriendsDetails extends HookWidget {
  const FriendsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final friendList = useState(friend.friendsList);

    useEffect((){
      if (friend.friendsList.isEmpty) friend.loadFriends();
    });

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
                    Navigator.pushNamed(context, '/DeleteFriendScreen');
                  },
                  child: const Text('delete friend'),
                ))
              ],
            ),
            Expanded(child: Observer(builder: (_) {
              if (friend.friendsList.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  itemCount: friendList.value.length,
                  itemBuilder: (contex, index) {
                   // final friend1 = friendList.value[index];
                    return ListTile(
                      title: Text(friendList.value[index].name),
                      subtitle: Text(friendList.value[index].age),
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
