import 'package:eclipse_test5/components/constants.dart';
import 'package:eclipse_test5/screens/users_list.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'components/user.dart';
import 'components/post.dart';
import 'components/photo.dart';
import 'components/album.dart';
import 'components/comment.dart';

const String API_BOX = 'api_data';
var box;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(PostAdapter());
  Hive.registerAdapter(PhotoAdapter());
  Hive.registerAdapter(AlbumAdapter());
  Hive.registerAdapter(CommentAdapter());

  await Hive.openBox(API_BOX);

  runApp(EclipseTestApp());
}

class EclipseTestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // scaffoldBackgroundColor: kBackgroundColor,
        // primarySwatch: Colors.green,
        // primaryColor: kPrimaryColor,
        primaryColor: Colors.black,
        // textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:
      // Container(
      //   decoration: BoxDecoration(
      //     gradient:LinearGradient(
      //       begin: Alignment.centerLeft,
      //       end: FractionalOffset.centerRight,
      //       colors: [Colors.green, Colors.blue],
      //       stops: [0, 1],
      //     ),
      //   ),
      //   child:
        UsersList(title: 'Users'),
      // ),
    );
  }
}






