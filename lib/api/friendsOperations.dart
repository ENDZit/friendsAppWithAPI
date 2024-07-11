import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobx/mobx.dart';

part 'friendsOperations.g.dart';

class GetFriendsStore = _GetFriendsStore with _$GetFriendsStore;

abstract class _GetFriendsStore with Store {
  @observable
  ObservableFuture<List<dynamic>> friendsList = ObservableFuture.value([]);

  @action
  Future<List<dynamic>> friends() async {
    @observable
    final response =
        await http.get(Uri.parse('http://192.168.1.110:3000/friends-list'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('ERROR');
    }
  }

  @action
  Future<List> updateFriends() {
    final future = friends();
    friendsList = ObservableFuture(future);
    return future;
  }
}

class AddFriend {
  Future<void> addFriend(String name, String age) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.110:3000/friend-add'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'age': age,
      }),
    );
    if (response.statusCode == 201) {
    } else {
      throw Exception('Failed');
    }
  }
}

class DeleteFriend {

  Future<void> deleteFriend(String name) async {
    final response = await http
        .delete(Uri.parse('http://192.168.1.110:3000/friend-delete/$name'));
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed');
    }
  }
}
