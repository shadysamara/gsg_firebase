import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gsg_firebase/backend/repository.dart';
import 'package:gsg_firebase/backend/server.dart';
import 'package:image_picker/image_picker.dart';

class EditUserProfile extends StatefulWidget {
  @override
  _EditUserProfileState createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  String newName;

  String newCity;

  String newPhone;

  updateUser() {
    Map map = {
      'namee': this.newName ?? Repository.repository.user.name,
      'city': this.newCity ?? Repository.repository.user.city,
      'phone': this.newPhone ?? Repository.repository.user.phone,
      'file': this.file
    };
    updateUserInFirestore(map);
  }

  File file;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        actions: [IconButton(icon: Icon(Icons.edit), onPressed: () {})],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                PickedFile pickedFile =
                    await ImagePicker().getImage(source: ImageSource.gallery);
                file = File(pickedFile.path);
                setState(() {});
              },
              child: Container(
                height: 150,
                width: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: file == null
                      ? Repository.repository.user.imageUrl != null
                          ? CachedNetworkImage(
                              imageUrl: Repository.repository.user.imageUrl,
                              fit: BoxFit.cover,
                            )
                          : FlutterLogo()
                      : Image.file(
                          file,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(flex: 1, child: Text('Name')),
              Expanded(
                  flex: 4,
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    initialValue: Repository.repository.user.name,
                    onChanged: (value) {
                      this.newName = value;
                    },
                  )),
            ]),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(flex: 1, child: Text('City')),
                Expanded(
                    flex: 4,
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      initialValue: Repository.repository.user.city,
                      onChanged: (value) {
                        this.newCity = value;
                      },
                    ))
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(flex: 1, child: Text('Phone')),
                Expanded(
                    flex: 4,
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      initialValue: Repository.repository.user.phone,
                      onChanged: (value) {
                        this.newPhone = value;
                      },
                    ))
              ],
            ),
            RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text('Done'),
                onPressed: () {
                  updateUser();
                })
          ],
        ),
      ),
    );
  }
}
