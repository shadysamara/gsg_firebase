import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gsg_firebase/backend/repository.dart';
import 'package:gsg_firebase/ui/pages/edit_user_profile.dart';
import 'package:gsg_firebase/utilities/styles.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        actions: [
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Get.to(EditUserProfile());
              })
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Name',
                  style: profileStyle,
                ),
                Text(
                  Repository.repository.user.name,
                  style: profileStyle,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Email',
                  style: profileStyle,
                ),
                Text(
                  Repository.repository.user.email,
                  style: profileStyle,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'City',
                  style: profileStyle,
                ),
                Text(
                  Repository.repository.user.city,
                  style: profileStyle,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Phone',
                  style: profileStyle,
                ),
                Text(
                  Repository.repository.user.phone,
                  style: profileStyle,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
