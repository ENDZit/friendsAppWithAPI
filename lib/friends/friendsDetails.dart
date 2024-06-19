import 'package:flutter/material.dart';
import 'package:future1/api/friendsOperations.dart';

class FriendsDetails extends StatefulWidget {
  const FriendsDetails({super.key});

  @override
  FriendsDetailsState createState() => FriendsDetailsState();
}
  @override
class FriendsDetailsState extends State<FriendsDetails> {
late  Future<List<dynamic>> friendsList;

@override
void initState(){
  super.initState();
  friendsList = GetFriends().friends();
}

void updateFriends(){
  setState(() {
    friendsList = GetFriends().friends();
  });
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
              updateFriends();
            }, child:( const Text('refresh friends')) )),
            Expanded(child: ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/DeleteFriendScreen');
              },
              child: const Text('delete friend'),
            ))

          ],),
            Expanded(child:  FutureBuilder<List<dynamic>>(
                future: friendsList,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(itemCount: snapshot.data!.length ,itemBuilder: (context, index){
                      return ListTile(
                        title: Text(snapshot.data![index]['name']),
                        subtitle: Text(snapshot.data![index]['age']),
                      );
                    });
                  }else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                }
            ) )

          ],
        ),
      ),
    );
  }
}
