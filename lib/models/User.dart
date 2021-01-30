import 'package:gsg_firebase/backend/server.dart';

enum userType { mershant, customer, admin }

class User {
  String name;
  String phone;
  String city;
  String email;
  userType type;

  User({this.name, this.city, this.email, this.phone, this.type});
  User.fromMap(Map map) {
    logger.e(map);
    this.name = map['name'];
    this.city = map['city'];
    this.phone = map['phone'];
    this.email = map['email'];
    this.type = map['role'] == 'admin'
        ? userType.admin
        : map['role'] == 'merchant'
            ? userType.mershant
            : userType.customer;
  }
  toJson() {
    return {
      'name': this.name,
      'city': this.city,
      'phone': this.phone,
      'email': this.email,
      'userType': this.type.toString()
    };
  }
}
