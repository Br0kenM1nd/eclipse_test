import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0) final int id;
  @HiveField(1) final String username;
  @HiveField(2) final String name;
  @HiveField(3) final String email;
  @HiveField(4) final String phone;
  @HiveField(5) final String website;
  @HiveField(6) final String companyName;
  @HiveField(7) final String companyBs;
  @HiveField(8) final String companyCatchphrase;
  @HiveField(9) final String street;
  @HiveField(10) final String suite;
  @HiveField(11) final String city;
  @HiveField(12) final String zipcode;
  @HiveField(13) final String lat;
  @HiveField(14) final String lng;

  User(this.id, this.username, this.name, this.email, this.phone, this.website,
      this.companyName, this.companyBs, this.companyCatchphrase, this.street,
      this.suite, this.city, this.zipcode, this.lat, this.lng);
}