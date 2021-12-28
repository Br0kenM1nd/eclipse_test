import 'package:eclipse_test5/components/api.dart';
import 'package:eclipse_test5/components/comment.dart';
import 'package:eclipse_test5/components/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostDetails extends StatefulWidget {
  final Post post;
  PostDetails(this.post);

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  var _name;
  var _mail;
  var _comment;

  final nameCon = TextEditingController();
  final mailCon = TextEditingController();
  final commentCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Image.asset('images/eclipse3.png'),
          title: Text('comment'),
        ),
        body: ListView(
          children: [
            ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                selected: true,
                selectedTileColor: Colors.black,
                title: Text(widget.post.title, style: TextStyle(color: Colors.blue),)),
            ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                selected: true,
                selectedTileColor: Colors.black,
                title: Text(widget.post.body, style: TextStyle(color: Colors.white),)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black.withOpacity(0.05),
              ),
              child: Text('Add comment', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        color: Colors.blueGrey,
                        child: Column(
                          children: [
                            TextField(
                              // controller: nameCon,
                              decoration: InputDecoration(
                                  hintText: 'Enter your name'
                              ),
                              onSubmitted: (String text) {
                                _name = text;
                              },
                            ),
                            TextField(
                              // controller: mailCon,
                              decoration: InputDecoration(
                                  hintText: 'Enter your email'
                              ),
                              onSubmitted: (String text) {
                                _mail = text;
                              },
                            ),
                            TextField(
                              // controller: commentCon,
                              // maxLines: null,
                              decoration: InputDecoration(
                                  hintText: 'Comment'
                              ),
                              onSubmitted: (String text) {
                                _comment = text;
                              },
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blueGrey.withOpacity(0.05),
                              ),
                              child: Text('Send'),
                              onPressed: () {
                                  Api().postComment(widget.post.id, _name, _mail, _comment);
                              },
                            )
                          ],
                        ),
                      );
                    }
                );
              },
            ),
            FutureBuilder(
                future: Api().getCommentsList(widget.post.id),
                builder: (_, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                      primary: false,
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        itemBuilder: (_, i) {
                          return Card(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: ListTile(
                              selectedTileColor: Colors.black,
                              selected: true,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${snapshot.data[i].name}', textAlign: TextAlign.left, style: TextStyle(color: Colors.grey),),
                                  Text('email: ${snapshot.data[i].email}', textAlign: TextAlign.left, style: TextStyle(color: Colors.white),),
                                  Text('comment: ${snapshot.data[i].body}', textAlign: TextAlign.left, style: TextStyle(fontSize: 12, color: Colors.white),),
                                ]
                              ),
                            ),
                          );
                        }
                    );
                  }
                }
            ),
          ],
        ),
    );
  }
}