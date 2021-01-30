import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:gsg_firebase/backend/repository.dart';
import 'package:gsg_firebase/main.dart';
import 'package:gsg_firebase/models/User.dart' as myUser;
import 'package:gsg_firebase/ui/pages/loginpage.dart';
import 'package:gsg_firebase/ui/pages/mershant_page.dart';
import 'package:gsg_firebase/ui/pages/products_page.dart';
import 'package:logger/logger.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
Logger logger = Logger();
final String collectionName = 'users';
Future<String> registerUsingEmailAndPassword(
    String email, String password) async {
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    return userCredential.user.uid;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<String> loginUsingEmailAndPassword(String email, String password) async {
  try {
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    return userCredential.user.uid;
  } catch (e) {
    print(e);
    return null;
  }
}

signOut() async {
  await auth.signOut();
  Get.to(LoginPage());
}

String getUserId() {
  String id = auth.currentUser != null ? auth.currentUser.uid : null;
  print(id);
  return id;
}

saveDummyDataInFirestore() async {
  DocumentReference documentReference =
      await firestore.collection(collectionName).add({
    'name': 'ahmed',
    'age': 30,
    'isMale': true,
    'family': {
      'father': 'ali',
      'mother': 'sanaa',
      'brother': 'hussam',
      'sister': 'dina'
    },
    'hobbies': ['football', 'gaming', 'programing']
  });
  print(documentReference.id);
}

setSpecificDocumentId() async {
  firestore.collection(collectionName).doc('dummyId').set({
    'name': 'ahmed',
    'age': 30,
    'isMale': true,
    'family': {
      'father': 'ali',
      'mother': 'sanaa',
      'brother': 'hussam',
      'sister': 'dina'
    },
    'hobbies': ['football', 'gaming', 'programing']
  });
}

Future<List<myUser.User>> readDummyDataFromFirestore() async {
  QuerySnapshot querySnapshot =
      await firestore.collection(collectionName).get();
  List<QueryDocumentSnapshot> documentsSnapshots = querySnapshot.docs;
  List<myUser.User> documentsMaps =
      documentsSnapshots.map((e) => myUser.User.fromMap(e.data())).toList();
  return documentsMaps;
}

saveUser(Map map) async {
  String userId =
      await registerUsingEmailAndPassword(map['email'], map['password']);
  map.remove('password');
  map['userId'] = userId;
  firestore.collection('Users').doc(userId).set({...map});
}

loginToMyAPP(String email, String password) async {
  String userId = await loginUsingEmailAndPassword(email, password);
  DocumentSnapshot documentSnapshot =
      await firestore.collection('Users').doc(userId).get();
  Map userMap = documentSnapshot.data();
  myUser.User user = myUser.User.fromMap(userMap);

  Repository.repository.typeOfUser = user.type;
  Repository.repository.user = user;

  Get.off(ProductsPage());
}

updateUserInFirestore(Map map) {
  firestore
      .collection('Users')
      .doc(auth.currentUser.uid)
      .set({...map}, SetOptions(merge: true));
}
