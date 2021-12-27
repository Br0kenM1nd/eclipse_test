import 'package:hive/hive.dart';
part 'comment.g.dart';

@HiveType(typeId: 4)
class Comment extends HiveObject {
  @HiveField(0) final int postId;
  @HiveField(1) final int id;
  @HiveField(2) final String name;
  @HiveField(3) final String email;
  @HiveField(4) final String body;

  Comment(this.postId, this.id, this.name, this.email, this.body);
}