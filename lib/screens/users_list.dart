import 'package:eclipse_test5/components/api.dart';
import 'package:eclipse_test5/screens/user_details.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:eclipse_test5/main.dart';

class UsersList extends StatefulWidget {
  UsersList({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  // @override
  // void dispose() {
  //   Hive.box(API_BOX).close();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Image.asset('images/eclipse3.png'),
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: Api().getUsersList(),
        builder: (_, AsyncSnapshot snapshot) {
          print(snapshot.data);
          if (snapshot.data == null) {
            return Center(
                child: const CircularProgressIndicator()
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, i) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    selected: true,
                    tileColor: Colors.red,
                    selectedTileColor: Colors.black,
                    // selectedTileColor: Colors.red[300],
                    title: Text(snapshot.data[i].username, style: TextStyle(color: Colors.white),),
                    subtitle: Text(snapshot.data[i].name, style: TextStyle(color: Colors.white),),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => UserDetails(snapshot.data[i]))
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}