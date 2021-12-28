import 'dart:convert';
import 'dart:async';
import 'package:eclipse_test5/components/comment.dart';
import 'package:eclipse_test5/components/photo.dart';
import 'package:eclipse_test5/components/post.dart';
import 'package:eclipse_test5/components/user.dart';
import 'package:http/http.dart' as http;
import 'package:eclipse_test5/components/album.dart';
import 'package:hive/hive.dart';
import 'package:eclipse_test5/main.dart';

class Api {
  getUsersList() async {
    // Works fine
    // If already cached, then return without internet request
    final usersCache = Hive.box(API_BOX).get("users", defaultValue: []);
    if (usersCache.isNotEmpty) return usersCache;
    print('amount of users: ${usersCache.length}');

    final response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var jsonData = json.decode(response.body);
    List<User> users = [];
    for (var u in jsonData) {
      User user = User(
        u["id"], u["username"], u["name"], u["email"], u["phone"], u["website"],
        u["company"]["name"], u["company"]["bs"], u["company"]["catchPhrase"],
        u["address"]["street"], u["address"]["suite"], u["address"]["city"],
        u["address"]["zipcode"],
        u["address"]["geo"]["lat"], u["address"]["geo"]["lng"],
      );
      users.add(user);
    }
    print('amount of users: ${users.length}');
    Hive.box(API_BOX).put("users", users); // Cache data, but no update
    return users;
  }

  Future<dynamic> getAlbumsPreviewList(int userId) async {
    // If already cached, then return without internet request
    List<dynamic> albumsCache = Hive.box(API_BOX).get("albumsPreview", defaultValue: []);
    if (albumsCache.isNotEmpty) return albumsCache;

    int cnt = 0;
    final response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
    var jsonData = json.decode(response.body);
    List<Album> albums = [];
    for (var a in jsonData) {
      Album album = Album(a["userId"], a["id"], a["title"]);
      if (a["userId"] == userId && cnt < 3) {
        cnt++;
        albums.add(album);
      }
    }
    print('amount of albums: ${albums.length}');
    Hive.box(API_BOX).put("albumsPreview", albums);
    return albums;
  }

  Future<dynamic> getPreviewAlbumPhotos3(int userId) async {
    // If already cached, then return without internet request
    final photosCache = Hive.box(API_BOX).get("photosPreview3", defaultValue: []);
    if (photosCache.isNotEmpty) return photosCache;

    const int idStep = 50; // for getting correct preview img, for each user
    const int albumIdStep = 10;
    int cnt = 0;
    final response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var jsonData = json.decode(response.body);
    List<Photo> photos = [];
    for (var p in jsonData) {
      Photo photo = Photo(p["albumId"], p["id"], p["title"], p["url"], p["thumbnailUrl"]);
      if (p["albumId"] > (userId-1) * albumIdStep) {
        if (p["id"] % idStep == 1) {
          photos.add(photo);
          print('photo id: ${photo.id}');
          cnt++;
          if (cnt >= 3) break;
        }
      }
    }
    print('amount of photos: ${photos.length}');
    Hive.box(API_BOX).put("photosPreview3", photos); // Cache data, but no update
    return photos;
  }

Future<dynamic> getPreviewAlbumPhotos10(int userId) async {
    // If already cached, then return without internet request
    final photosCache = Hive.box(API_BOX).get("photosPreview10", defaultValue: []);
    if (photosCache.isNotEmpty) {
      print('From cache, amount of photos: ${photosCache.length}');
      return photosCache;
    }

    const int idStep = 50; // for getting correct preview img, for each user
    const int albumIdStep = 10;
    int cnt = 0;
    final response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var jsonData = json.decode(response.body);
    List<Photo> photos = [];
    for (var p in jsonData) {
      Photo photo = Photo(p["albumId"], p["id"], p["title"], p["url"], p["thumbnailUrl"]);
      if (p["albumId"] > (userId-1) * albumIdStep) {
        if (p["id"] % idStep == 1) {
          photos.add(photo);
          print('photo id: ${photo.id}');
          cnt++;
          if (cnt >= 10) break;
        }
      }
    }
    print('amount of photos: ${photos.length}');
    Hive.box(API_BOX).put("photosPreview10", photos);
    return photos;
  }

  Future<dynamic> getAlbumsList(int userId) async {
    // If already cached, then return without internet request
    final albumsCache = Hive.box(API_BOX).get("albums", defaultValue: []);
    if (albumsCache.isNotEmpty) {
      print('From cache, amount of albums: ${albumsCache.length}');
      return albumsCache;
    }

    final response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
    var jsonData = json.decode(response.body);
    List<Album> albums = [];
    for (var a in jsonData) {
      Album album = Album(a["userId"], a["id"], a["title"]);
      if (a["userId"] == userId)
        albums.add(album);
    }
    print('amount of albums: ${albums.length}');
    Hive.box(API_BOX).put("albums", albums); // Cache data, but no update
    return albums;
  }

  getPhotosList(int albumId) async {
    // If already cached, then return without internet request
    // TODO store images on device, not only the url
    final photosCache = Hive.box(API_BOX).get("photos", defaultValue: []);
    if (photosCache.isNotEmpty) return photosCache;

    final response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var jsonData = json.decode(response.body);
    List<Photo> photos = [];
    for (var p in jsonData) {
      Photo photo = Photo(p["id"], p["albumId"], p["title"], p["url"], p["thumbnailUrl"]);
      if (p["albumId"] == albumId) photos.add(photo);
    }
    print('amount of photos: ${photos.length}');
    Hive.box(API_BOX).put("photos", photos);
    return photos;
  }

  getPostsList(int userId) async {
    // If already cached, then return without internet request
    final postsCache = Hive.box(API_BOX).get("posts", defaultValue: []);
    if (postsCache.isNotEmpty) return postsCache;

    final response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var jsonData = json.decode(response.body);
    List<Post> posts = [];
    for (var p in jsonData) {
      Post post = Post(p["userId"], p["id"], p["title"], p["body"]);
      if (p["userId"] == userId) posts.add(post);
    }
    print('amount of posts: ${posts.length}');
    Hive.box(API_BOX).put("posts", posts);
    return posts;
  }

  getPostsPreviewList(int userId) async {
    // If already cached, then return without internet request
    final postsCache = Hive.box(API_BOX).get("postsPreview", defaultValue: []);
    if (postsCache.isNotEmpty) return postsCache;

    int cnt = 0;
    final response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var jsonData = json.decode(response.body);
    List<Post> posts = [];
    for (var p in jsonData) {
      Post post = Post(p["userId"], p["id"], p["title"], p["body"]);
      if (p["userId"] == userId) {
        posts.add(post);
        cnt++;
        if (cnt >= 3) break;
      }
    }
    print('amount of posts: ${posts.length}');
    Hive.box(API_BOX).put("postsPreview", posts); // Cache data, but no update
    return posts;
  }

  getCommentsList(int postId) async {
    // If already cached, then return without internet request
    final commentsCache = Hive.box(API_BOX).get("comments", defaultValue: []);
    if (commentsCache.isNotEmpty) return commentsCache;

    final response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/comments'));
    var jsonData = json.decode(response.body);
    List<Comment> comments = [];
    for (var c in jsonData) {
      Comment comment = Comment(c["postId"], c["id"], c["name"], c["email"], c["body"]);
      if (c["postId"] == postId) comments.add(comment);
    }
    print('amount of comments: ${comments.length}');
    Hive.box(API_BOX).put("comments", comments); // Cache data, but no update
    return comments;
  }

  Future<void> postComment(int postId, String name, String mail, String body) async {
      print('ok');
    try {
      var response = await http.post(Uri.parse
        ('https://jsonplaceholder.typicode.com/comments'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            "postId": postId.toString(),
            "id": 1.toString(),
            "name": name,
            "mail": mail,
            "body": body,
          })
      );
      print(response.body);
      var com = json.decode(response.body);
      Comment comment = Comment(com["postId"], com["id"], com["name"], com["email"], com["body"]);
      Hive.box(API_BOX).put("comments", comment); // Cache data, but no update
      // Hive.box(API_BOX).clear(); // If you want to clear cache
    } catch (e) {
      print('Gotcha $e');
    }
  }

}