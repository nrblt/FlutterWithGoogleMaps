import 'package:flutter/material.dart';
import '../Components/nav_drawer.dart';
import '../Components/user_info.dart';
import 'map_page.dart';
import 'one_asset_in_map.dart';


class ActivesPage extends StatelessWidget {
  final UserInfo user;
  final String lang;

  ActivesPage(this.user,this.lang);


  String changeToNormal(String s) {
    int hour = int.parse(s.substring(11, 13));
    hour += 6;
    return s.substring(0, 10) +
        " " +
        hour.toString() +
        ":" +
        s.substring(14, 16);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // drawer: NavDrawer(listAss: listAss),

        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) =>
                    MapPage(user,lang))),
          ),
          title: Text("Actives"),
        ),
        body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                    Widget>[
          for (var asset in user.assets)
            Padding(
                padding: EdgeInsets.fromLTRB(5, 7, 5, 7),
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26)),
                    child: Column(children: <Widget>[
                      Row(children: <Widget>[
                        SizedBox(
                          width: 90.0,
                        ),
                        Expanded(
                            // child:Text('Hello'),
                            child: Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 7),
                                // child:Text(asset['asset_name'])
                                child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                            // Text("Helo"),
                                  Text(asset['asset_name'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  Text("Время " + changeToNormal(asset['datetime'])),
                                  Text("Общее состояние " + asset['is_inzone'].toString()),
                                  Text("Широта " + asset['current_lat'].toString()),
                                  Text("Долгота " + asset['current_lng'].toString()),
                                  Text("ESN " + asset['esn']),
                                  Text("Тип Устройства " + asset['device_type']),
                                ],
                        )))
                      ]),
                      Row(
                        children:<Widget>[
                          Expanded(
                            child: Container(
                                padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                                color: Colors.black,
                                child: Text("Статус заряда", style: TextStyle(color: Colors.white))
                            )

                          ),
                          Expanded(
                              child: InkWell(
                                onTap: ()=> Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    builder: (context) =>
                                        OneAssetInMap(asset, user, lang))),
                                child: Container(
                                    padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                                    color: Colors.blue,
                                    child: Text("Найти на карте")
                                  )
                              )                          )
                        ]
                      )
                    ])))
        ])));
  }

//      listAss = await user.assets;
}
