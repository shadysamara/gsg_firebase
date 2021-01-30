import 'package:flutter/material.dart';
import 'package:gsg_firebase/backend/repository.dart';
import 'package:gsg_firebase/models/User.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text(Repository.repository.userMap['name']),
              accountEmail: Text(Repository.repository.userMap['email'])),
          Repository.repository.typeOfUser == userType.admin
              ? Column(
                  children: [
                    ListTile(
                      title: Text('USERS CONTROL'),
                    ),
                    ListTile(
                      title: Text('REPORTS CONTROL'),
                    ),
                    ListTile(
                      title: Text('PRODUCTS CONTROL'),
                    ),
                    ListTile(
                      title: Text('GENERAL CONTROL'),
                    )
                  ],
                )
              : Repository.repository.typeOfUser == userType.mershant
                  ? Column(
                      children: [
                        ListTile(
                          title: Text('MESSAGES'),
                        ),
                        ListTile(
                          title: Text('MY PRODUCTS'),
                        ),
                        ListTile(
                          title: Text('ORDERS'),
                        ),
                        ListTile(
                          title: Text('CUSTOMERS'),
                        )
                      ],
                    )
                  : Column(
                      children: [
                        ListTile(
                          title: Text('MESSAGES'),
                        ),
                        ListTile(
                          title: Text('CART'),
                        ),
                        ListTile(
                          title: Text('FAVOURITE'),
                        )
                      ],
                    )
        ],
      ),
    );
  }
}
