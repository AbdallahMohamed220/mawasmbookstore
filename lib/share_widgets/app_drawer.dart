import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: CircleAvatar(
                        radius: 35,
                        child: Image.asset(
                          'assets/images/user1.png',
                          width: 50,
                        ),
                        backgroundColor: Colors.grey[50],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.work),
            title: Text(
              'من نحن',
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(
              'تسجيل خروج',
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
            onTap: () {},
          ),
          Divider(),
        ],
      ),
    );
  }
}
