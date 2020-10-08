import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 25.0,
      child: Container(
        constraints: BoxConstraints.expand(
          height: Theme.of(context).textTheme.headline4.fontSize * 1.1 + 200.0,
        ),
        padding: const EdgeInsets.all(8.0),
        color: Colors.teal[600],
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 25.0,
            ),
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/inn.jpg"),
              radius: 50.0,
            ),
            SizedBox(
              height: 25.0,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/images/power.png"),
                radius: 25.0,
              ),
            ),
          ],
        ),
        transform: Matrix4.rotationZ(0.12),
      ),
    );
  }
}
