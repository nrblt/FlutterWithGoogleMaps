import 'package:flutter/material.dart';
import '../Components/nav_drawer.dart';
import '../Components/user_info.dart';
import 'map_page.dart';

class SettingsPage extends StatefulWidget {
  // const SettingsPage({Key? key}) : super(key: key);
  // final dynamic asset;
  final UserInfo user;
  String lang;

  SettingsPage(this.user,this.lang);

  @override
  _SettingsPageState createState() => _SettingsPageState(user,lang);
}

class _SettingsPageState extends State<SettingsPage> {
  // final dynamic asset;
  final UserInfo user;
  String lang;

  _SettingsPageState(this.user,this.lang);


  String dropdownValue = 'ru';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(foregroundColor: Colors.white,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) =>
                    MapPage(user,lang))),
          ),title:Text("Settings")),
      // drawer: NavDrawer(user,lang),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
        child:DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          // style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            // color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
              lang=dropdownValue;
              setState(() {});

            });
          },
          items: <String>['en', 'ru', 'kz']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )

      )



    );
  }
}

