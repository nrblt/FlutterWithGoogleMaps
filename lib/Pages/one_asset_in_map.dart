import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Components/nav_drawer.dart';
import '../Components/button_widget.dart';
import '../Components/custom_appbar.dart';
import '../Components/user_info.dart';
import 'actives_page.dart';

class OneAssetInMap extends StatefulWidget {
  // const OneAssetInMap({Key? key}) : super(key: key);

  final dynamic asset;
  final UserInfo user;
  final String lang;

  OneAssetInMap(this.asset, this.user,this.lang);

  @override
  _OneAssetInMapState createState() => _OneAssetInMapState(asset, user, lang);
}

class _OneAssetInMapState extends State<OneAssetInMap> {
  final dynamic asset;
  final UserInfo user;
  final String lang;
  _OneAssetInMapState(this.asset, this.user,this.lang);

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(49.500, 67),
    zoom: 4,
  );
  late GoogleMapController _googleMapController;
  List<Marker> _markers = [];
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  int  closed = 1;
  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  void _addMarker(double lt, double ln, String nm, int id, String battery,
      bool isInzone, bool isNotif, String date) {
    String idName = id.toString();
    _markers.add(Marker(
      markerId: MarkerId(idName),
      position: LatLng(lt, ln),
      infoWindow: InfoWindow(title: nm),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueGreen,
      ),
    ));
  }

  void _onMapCreated(GoogleMapController controller) async {
    setState(() {
      _addMarker(
          asset['current_lat'],
          asset['current_lng'],
          asset['asset_name'],
          asset['_id'],
          asset['battery_status'],
          asset['is_inzone'],
          asset['is_notified'],
          asset['datetime']);
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
      // key: _scaffoldKey,
      // drawer: NavDrawer(user),
      // key:scaffoldKey,

      body: Stack(children: [
        GoogleMap(
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          mapType: MapType.hybrid,
          initialCameraPosition: _initialCameraPosition,
          onMapCreated: _onMapCreated,
          markers: Set<Marker>.of(_markers),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(5, 30, 0, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                // ColoredBox(
                height: 40,
                width: 40,
                color: Colors.white,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => ActivesPage(user,lang))),
                ),
              ),
            )),
        Visibility(
            visible: closed==1,
            child: Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Stack(children: [
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 100,
                  child: Text("hfshafih"),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red,
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  height: 35,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.black),
                    onPressed: () {

                      closed = 0;
                      setState((){});
                    },
                  ),
                ),
              ]),
            )),
      ]),

      // )
    );
  }
}
