import 'package:flutter/material.dart';
import 'package:registration/Components/translates.dart';
import '../Pages/actives_page.dart';
import 'user_info.dart';
import '../Pages/settings_page.dart';
import '../Pages/main_page.dart';

class NavDrawer extends StatelessWidget {
  // const NavDrawer({Key? key}) : super(key: key);
  // late  List<dynamic> listAss;
  final UserInfo user;
  final String lang;
  NavDrawer(this.user,this.lang);

  // String lla="";

  @override
  Widget build(BuildContext context) {
    Translates translates= new Translates(lang);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[ //<Widget>
          DrawerHeader(
            child:Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),

            decoration: BoxDecoration(
              color: Colors.green,
              border: Border.all(
                color: Colors.black,
                width: 8,
              ),
            ),
          ),
          ListTile(
            leading :Icon(Icons.window),
            title: Text(translates.actives()),
            onTap: ()=>{
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => ActivesPage(user,lang)
            ))
              // Navigator.of(context).pop()
            },
          ),
          ListTile(
            leading :Icon(Icons.settings),
            title: Text(translates.settings()),
            onTap: ()=>{
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => SettingsPage(user,lang)
              ))
            },
          ),
          ListTile(
            leading :Icon(Icons.notifications),
            title: Text(translates.notifications()),
            onTap: ()=>{
              Navigator.of(context).pop()},
          ),
          Container(
                margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                child: Divider(
                  color: Colors.black,
                  height: 50,
                )
          ),

          ListTile(
            leading :Icon(Icons.input),
            title: Text(translates.leave()),
            onTap: ()=>{
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => MainPage("My App"),
              ))},
          ),
        ],
      ),

    );
  }
}
