import 'package:future1/api/friendsOperations.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:future1/friend.dart';

part 'friendsStore.g.dart';

class FriendsStore = _FriendsStore with _$FriendsStore;

abstract class _FriendsStore with Store {
  final friendsApi = new FriendsApi();

  @observable
  ObservableList<Friend> friendsList = ObservableList<Friend>();

  @action
  Future<List> updateFriends() async {
    final future = await friendsApi.loadFriends();
    return future;
  }

  @action
  Future<void> loadFriends() async {
    final friends = await friendsApi.loadFriends();
    this.friendsList.addAll(friends);
  }

  @action
  Future<void> addFriend(String name, String age) async {
    final newFriend = await friendsApi.addFriend(name, age);
    this.friendsList.add(newFriend);
  }

  @action
  Future<void> removeFriend(String name) async {
    await friendsApi.deleteFriend(name);
    this.friendsList.removeWhere((friend) => friend.name == name);
  }
}
