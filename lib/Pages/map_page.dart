import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Components/nav_drawer.dart';
import '../Components/button_widget.dart';
import '../Components/custom_appbar.dart';
import '../Components/user_info.dart';



class MapPage extends StatefulWidget {
  // final String token;
  // final String name;
  // final Future<List<dynamic>> assets;
  final UserInfo user;
  final String lang;

  MapPage(this.user,this.lang);

  @override
  _MapPageState createState() => _MapPageState(user,lang);
}

class _MapPageState extends State<MapPage> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(49.500, 67),
    zoom: 4,
  );
  final UserInfo user;
  final String lang;

  _MapPageState(this.user,this.lang);


  List<dynamic> listAss = [];
  late GoogleMapController _googleMapController;
  List<Marker> _markers = [];
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  // GlobalKey<ScaffoldState>_scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }
  String changeToNormal(String s) {
    int hour = int.parse(s.substring(11, 13));
    hour += 6;
    return s.substring(0, 10) +
        " " +
        hour.toString() +
        ":" +
        s.substring(14, 16);
  }
  Widget CustomDialog(String name, String battery, String date){
    return Dialog(
      elevation: 0,
      // backgroundColor: Colors.limeAccent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)),
      child: Container(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "\n Имя трекера: $name \n Статус батареи: $battery \n Даты и время: $date",
              style: TextStyle(fontSize: 16),
            ),

            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Close"))
          ],
        ),
      ),
    );

  }
  
  
  void _addMarker(double lt, double ln, String nm, int id, String battery, bool isInzone, bool isNotif, String date) {
    String idName = id.toString();
    _markers.add(Marker(
      markerId: MarkerId(idName),
      position: LatLng(lt, ln),
      onTap: (){
        showDialog(
                context:context,
                builder: (context){
                  return CustomDialog(nm,battery,changeToNormal(date));
                }
              );
      },
      infoWindow: InfoWindow(title: nm),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueGreen,
      ),
    ));
  }

  void _onMapCreated(GoogleMapController controller) async {
    listAss = user.assets;
    setState(() {
      for (var i = 0; i < listAss.length; ++i) {
        _addMarker(listAss[i]['current_lat'], listAss[i]['current_lng'],
            listAss[i]['asset_name'], listAss[i]['_id'],listAss[i]['battery_status'],listAss[i]['is_inzone'],
            listAss[i]['is_notified'], listAss[i]['datetime']);
      }
      _googleMapController = controller;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavDrawer(user,lang),
      // key:scaffoldKey,

      body:Stack( children:[

        GoogleMap(
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapType: MapType.hybrid,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: _onMapCreated,
            markers: Set<Marker>.of(_markers),
        ),
        Padding(
          padding:EdgeInsets.fromLTRB(5, 30, 0, 0),
          child:ClipRRect(
            borderRadius: BorderRadius.circular(50),

            child: Container(
            // ColoredBox(
              height:40,
              width:40,
              color: Colors.white,
              child: IconButton(
                icon: Icon(Icons.menu,color: Colors.black),
                onPressed: ()=>_scaffoldKey.currentState!.openDrawer(),
              )
            ),
          ),



        )
      ]),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.directions_boat),
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.black,
          onPressed: () => _googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(_initialCameraPosition),
          ),
    // child: const Icon(Icons.center_focus_strong),
          ),
    // )

    );
    }

}
