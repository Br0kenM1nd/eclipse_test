import 'package:hive/hive.dart';
part 'album.g.dart';

@HiveType(typeId: 5)
class Album extends HiveObject {
  @HiveField(0) final int userId;
  @HiveField(1) final int id;
  @HiveField(2) final String title;

  Album(this.userId, this.id, this.title);
}