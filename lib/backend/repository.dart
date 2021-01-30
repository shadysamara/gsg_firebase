import 'package:gsg_firebase/models/User.dart';

class Repository {
  Repository._();
  static Repository repository = Repository._();
  userType typeOfUser;
  User user;
}
