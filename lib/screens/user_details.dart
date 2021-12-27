import 'dart:async';
import 'package:eclipse_test5/components/api.dart';
import 'package:eclipse_test5/screens/albums_list.dart';
import 'package:eclipse_test5/screens/posts_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:eclipse_test5/components/user.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:eclipse_test5/main.dart';

class UserDetails extends StatefulWidget {
  final User user;

  UserDetails(this.user);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Container(child: Image.asset('images/eclipse3.png'),
            decoration: BoxDecoration(color: Colors.black),),
          title: Text(widget.user.username),
        ),
      body: ListView(
        primary: true,
        children: [
          ListTile(title: Text('name: \n${widget.user.name}', style: TextStyle(color: Colors.white),)),
          ListTile(title: Text('email: \n${widget.user.email}', style: TextStyle(color: Colors.white),)),
          ListTile(title: Text('phone: \n${widget.user.phone}', style: TextStyle(color: Colors.white),)),
          ListTile(title: Text('website: \n${widget.user.website}', style: TextStyle(color: Colors.white),)),
          ListTile(title: Text('Company:', style: TextStyle(color: Colors.white),)),
          ListTile(title: Text('company Name: \n${widget.user.companyName}', style: TextStyle(color: Colors.white),)),
          ListTile(title: Text('company Bs: \n${widget.user.companyBs}', style: TextStyle(color: Colors.white),)),
          ListTile(title: Text('company Catchphrase: \n${widget.user.companyCatchphrase}',
          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),)),
          ListTile(title: Text('Address:', style: TextStyle(color: Colors.white),)),
          ListTile(title: Text('street: \n${widget.user.street}', style: TextStyle(color: Colors.white),)),
          ListTile(title: Text('suite: \n${widget.user.companyBs}', style: TextStyle(color: Colors.white),)),
          ListTile(title: Text('city: \n${widget.user.companyBs}', style: TextStyle(color: Colors.white),)),
          ListTile(title: Text('zipcode: \n${widget.user.zipcode}', style: TextStyle(color: Colors.white),)),
          ListTile(title: Text('Geolocation:', style: TextStyle(color: Colors.white),)),
          ListTile(title: Text('latitude: \n${widget.user.lat}', style: TextStyle(color: Colors.white),)),
          ListTile(title: Text('longitude: \n${widget.user.lng}', style: TextStyle(color: Colors.white),)),
          ListTile(title: Text('Posts preview:', style: TextStyle(color: Colors.white),)),
          FutureBuilder(
              future: Api().getPostsPreviewList(widget.user.id),
              builder: (_, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: const CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                      // scrollDirection: Axis.vertical,
                      primary: false,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, i) {
                        String _preComment = snapshot.data[i].body.toString();
                        List<String> _lines = _preComment.split("\n");
                        String _cutComment = _lines.first + '...';
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            tileColor: Colors.black,
                            title: Text(snapshot.data[i].title, style: TextStyle(color: Colors.blue),),
                            subtitle: Text(_cutComment, style: TextStyle(color: Colors.white),),
                            onTap: () {
                              Navigator.push(_, MaterialPageRoute(builder: (_) =>
                                  PostsList(widget.user,))
                              );
                            },
                          ),
                        );
                      }
                  );
                }
              }
          ),
          ListTile(title: Text('Albums:', style: TextStyle(color: Colors.white),)),
          FutureBuilder(
              future: Future.wait([
                Api().getAlbumsPreviewList(widget.user.id),
                Api().getPreviewAlbumPhotos3(widget.user.id)]),
              builder: (_, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: const CircularProgressIndicator(),
                  );
                } else {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(40.0),
                      topRight: const Radius.circular(40.0),
                      ),
                    ),
                    child: GridView.builder(
                      primary: false,
                      scrollDirection: Axis.vertical,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      shrinkWrap: true,
                      itemCount: snapshot.data?[0].length ?? [],
                      itemBuilder: (_, i) {
                          return ListTile(
                            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                            selected: true,
                            selectedTileColor: Colors.grey[300],
                            title: Center(
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  Image.network(snapshot.data?[1][i].url ?? []),
                                  Text(snapshot.data?[0][i].title ?? [], style: TextStyle(color: Colors.black),),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(_, MaterialPageRoute(builder: (_) =>
                                AlbumsList(user: widget.user, url: snapshot.data?[1][i].url))
                              );
                            },
                          );
                      }
                    ),
                  );
                }
              }
          ),
        ],
      )
    );
  }
}