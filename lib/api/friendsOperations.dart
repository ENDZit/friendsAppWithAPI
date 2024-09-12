import 'package:future1/friend.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class FriendsApi {
  Future<List<Friend>> loadFriends() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.110:3000/friends-list'));
    if (response.statusCode == 200) {
      final List<dynamic> friendsFromServer = jsonDecode(response.body);
      final List<Friend> friends =
          friendsFromServer.map((json) => Friend.fromJson(json)).toList();
      return friends;
    } else {
      throw Exception('ERROR');
    }
  }

  Future<Friend> addFriend(String name, String age) async {
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
      return Friend(name, age);
    } else {
     throw Exception('Failed');
    }
  }

  Future<void> deleteFriend(String name) async {
    final response = await http
        .delete(Uri.parse('http://192.168.1.110:3000/friend-delete/$name'));
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed');
    }
  }
}
