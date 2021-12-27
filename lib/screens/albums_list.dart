

import 'package:eclipse_test5/components/album.dart';
import 'package:eclipse_test5/components/api.dart';
import 'package:eclipse_test5/components/post.dart';
import 'package:eclipse_test5/components/user.dart';
import 'package:eclipse_test5/screens/album_details.dart';
import 'package:eclipse_test5/screens/post_details.dart';
import 'package:eclipse_test5/screens/posts_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class AlbumsList extends StatefulWidget {
  final User user;
  final String url;
  const AlbumsList({Key? key, required this.user, required this.url}) : super(key: key);

  @override
  _AlbumsListState createState() => _AlbumsListState();
}

class _AlbumsListState extends State<AlbumsList> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Image.asset('images/eclipse3.png'),
        title: const Text('Albums'),
      ),
      body: FutureBuilder(
          future: Future.wait([
            Api().getAlbumsList(widget.user.id),
            Api().getPreviewAlbumPhotos10(widget.user.id),]),
          builder: (_, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Card(
                child: Container(
                  decoration: BoxDecoration(
                    // border: Border.all(
                    //   color: Colors.red,  // red as border color
                    // ),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(40.0),
                      topRight: const Radius.circular(40.0),
                    ),
                  ),
                  child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: snapshot.data?[0].length ?? [],
                      itemBuilder: (_, i) {
                        return ListTile(
                          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          selected: true,
                          selectedTileColor: Colors.black,
                          title: Center(
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Image.network(snapshot.data?[1][i].url),
                                Text(snapshot.data?[0][i].title, style: TextStyle(color: Colors.black),),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(_, MaterialPageRoute(builder: (_) =>
                                AlbumDetails(snapshot.data?[0][i]))
                            );
                          },
                        );
                      }
                  ),
                ),
              );
            }
          }
      ),
    );
  }
}
