import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gsg_firebase/backend/server.dart';
import 'package:gsg_firebase/ui/pages/user_profile.dart';
import 'package:gsg_firebase/ui/widgets/customDrawer.dart';

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                signOut();
              }),
          IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Get.to(UserProfile());
              })
        ],
      ),
      body: Center(
        child: Text('Products Page'),
      ),
    );
  }
}
