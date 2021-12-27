import 'package:eclipse_test5/components/api.dart';
import 'package:eclipse_test5/components/user.dart';
import 'package:eclipse_test5/screens/post_details.dart';
import 'package:flutter/material.dart';

class PostsList extends StatefulWidget {
  final User user;
  const PostsList(this.user, {Key? key}) : super(key: key);

  @override
  _PostsListState createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Image.asset('images/eclipse3.png'),
        title: const Text('Posts'),
      ),
      body: FutureBuilder(
        future: Api().getPostsList(widget.user.id),
        builder: (_, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, i) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                      selected: true,
                      selectedTileColor: Colors.black,
                      title: Text(snapshot.data[i].title),
                      subtitle: Text(snapshot.data[i].body, style: TextStyle(fontSize: 12, color: Colors.white),),
                      onTap: () {
                        Navigator.push(_, MaterialPageRoute(builder: (_) =>
                            PostDetails(snapshot.data[i]))
                        );
                      },
                    ),
                  );
                }
              );
          }
        }
      ),
    );
  }
}
