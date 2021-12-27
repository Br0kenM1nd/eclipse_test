import 'package:hive/hive.dart';
part 'photo.g.dart';

@HiveType(typeId: 3)
class Photo extends HiveObject {
  @HiveField(0) final int albumId;
  @HiveField(1) final int id;
  @HiveField(2) final String title;
  @HiveField(3) final String url;
  @HiveField(4) final String thumbnailUrl;

  Photo(this.albumId, this.id, this.title, this.url, this.thumbnailUrl);
}