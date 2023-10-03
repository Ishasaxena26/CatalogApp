//contains the code for drawer section of the app

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  //const MyDrawer({super.key});

  final imageUrl = "https://static.thenounproject.com/png/5606215-200.png";

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
            color: Colors.deepPurple,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  padding: EdgeInsets
                      .zero, // Padding is the space between the content and the boundaries of the widget.when it is set to zero here it means the content will be positioned flush against the edges of the DrawerHeader.

                  child: UserAccountsDrawerHeader(
                    //decoration: BoxDecoration(color: Colors.white),
                    margin: EdgeInsets
                        .zero, //content should be positioned at the edges of the container without any additional spacing.
                    accountEmail: Text("isaxena149@gmail.com",
                        style: TextStyle(color: Colors.white)),
                    accountName: Text("Isha Saxena",
                        style: TextStyle(color: Colors.white)),
                    currentAccountPicture:
                        CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
                  ),
                ),
                ListTile(
                    //onTap() is also available in this
                    leading: Icon(
                      CupertinoIcons.home, //adds icon before the "home" text
                      color: Colors.white,
                    ),
                    title: Text("Home",
                        textScaleFactor: 1.2, //for increasing the size
                        style: TextStyle(color: Colors.white))),
                ListTile(
                    leading: Icon(CupertinoIcons.profile_circled,
                        color: Colors.white),
                    title: Text("Profile",
                        textScaleFactor: 1.2,
                        style: TextStyle(color: Colors.white))),
                ListTile(
                    leading: Icon(CupertinoIcons.mail, color: Colors.white),
                    title: Text("Email me ",
                        textScaleFactor: 1.2,
                        style: TextStyle(color: Colors.white))),
              ],
            )));
  }
}
