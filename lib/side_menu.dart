import 'package:flutter/material.dart';

class Sidemenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          DrawerHeader(
              child: Text(
                'Side menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            decoration: BoxDecoration(
              color: Colors.green,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/godrej_maintenance_logo.png'),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('profile'),
            onTap: (){},
          )
        ],

      ),
    );
  }
}
