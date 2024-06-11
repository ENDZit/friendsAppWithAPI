
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: const HomeScreen(),
      initialRoute: '/',
      routes: {
        '/AddFriendScreen': (context) => const FriendAddScreen(),
        '/DeleteFriendScreen': (context) => const DeleteFriendScreen(),
      },
    );
  }
}
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
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
class FriendAddScreen extends StatefulWidget {
  const FriendAddScreen({super.key});

  @override
  FriendAddScreenState createState() => FriendAddScreenState();
}
class FriendAddScreenState extends State<FriendAddScreen> {
  final _formKey = GlobalKey<FormState>();
  String newFriendName = "";
  String newFriendAge = "";

  List<dynamic> postFriends = [];
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
      final responseBody = jsonDecode(response.body);
      setState(() {
        postFriends.add(responseBody);
      });
    } else {
      throw Exception('Failed');
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter your friend`s data"),
        backgroundColor: Colors.blueAccent,
      ),
      body:  Center(
          child: Form(
            key: _formKey,
            child: Column( children: [
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Friend`s name',
                    hintText: 'Enter your friend`s name'
                ),
                validator: (name){
                  newFriendName = name.toString();
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Friend`s age',
                    hintText: 'Enter your friend`s name'
                ),
                validator:(age){
                  newFriendAge = age.toString();
                },
              ),
              Row(
                children: [
                  Expanded(child: ElevatedButton(
                    onPressed: (){
                      if (_formKey.currentState!.validate()) {
                        // Perform submission logic
                        addFriend( newFriendName, newFriendAge);
                      }
                    },
                    child: const Text('Submit'),
                  ))
                ],
              )

            ],),
          )
      ),
    );
  }
}

class DeleteFriendScreen extends StatefulWidget{
  const DeleteFriendScreen({super.key});
@override
  DeleteFriendScreenState createState() => DeleteFriendScreenState();
}
class DeleteFriendScreenState extends State<DeleteFriendScreen>{
  final _formKey = GlobalKey<FormState>();
  String deletedFriendName = "";
  List<dynamic> postFriends = [];
  Future<void> deleteFriend(String name) async{
    final response = await http.delete(Uri.parse('http://192.168.1.110:3000/friend-delete/$name'));
    if(response.statusCode == 200){
    setState(() {
      postFriends.remove(response.body);
    });
    }else{
      throw Exception('Failed');
    }
  }
  @override
  Widget build(BuildContext context){
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
                   decoration: const InputDecoration(
                     labelText: "Friend`s name"
                   ),
                  validator:(name){
                     deletedFriendName = name.toString();
                },
                ),Row(
                  children: [
                    Expanded(child: ElevatedButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          deleteFriend(deletedFriendName);
                        }
                      },
                      child: const Text("delete"),
                    ))
                  ],
                )

              ],
            ),
        ),
      ) ,
    );
  }
}