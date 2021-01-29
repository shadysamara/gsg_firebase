import 'package:flutter/material.dart';
import 'package:gsg_firebase/backend/server.dart';
import 'package:gsg_firebase/models/User.dart';

class FirestorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
              child: Text('Save data to firestore'),
              onPressed: () {
                setSpecificDocumentId();
              }),
          RaisedButton(
              child: Text('Read data from firestore'),
              onPressed: () async {
                List<User> users = await readDummyDataFromFirestore();
                print(users[0].name);
              })
        ],
      ),
    );
  }
}
