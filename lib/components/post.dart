import 'package:hive/hive.dart';
part 'post.g.dart';

@HiveType(typeId: 2)
class Post extends HiveObject {
  @HiveField(0) final int userId;
  @HiveField(1) final int id;
  @HiveField(2) final String title;
  @HiveField(3) final String body;
  Post(this.userId, this.id, this.title, this.body);
}