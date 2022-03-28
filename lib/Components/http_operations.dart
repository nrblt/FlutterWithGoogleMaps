import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'button_widget.dart';
import '../Pages/map_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../Pages/map_page.dart';
import 'user_info.dart';
// import 'package:resteraunt_starter/api/BaseAPI.dart';

class HttpService {
  static final _client = http.Client();
  static var _apiUrl = 'http://167.172.161.69:5010/';

  static login(login, password, context) async {
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$login:$password'));
    // print(basicAuth);
    Response response = await post(Uri.parse(_apiUrl + 'login'),
        headers: <String, String>{'authorization': basicAuth});

    // print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonFile = jsonDecode(response.body);
      Map<String, dynamic> datas = jsonFile;
      // print(datas["token"]);
      String tok = datas["token"];
      List<dynamic>listAss = await getAssets(tok);

      UserInfo user = new UserInfo(datas["token"], datas["name"], listAss);
      await Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              MapPage(user,"kz")));
    }
    else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Maybe you wrote wrong login or password'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  static Future<List<dynamic>> getAssets(String token) async {
    print(token);
    Response response = await get(Uri.parse(_apiUrl + 'assets'),
        headers: <String, String>{'x-access-tokens': token});
    if (response.statusCode == 200) {
      // print("HEHEHEHHEHEHEH");
      var jsonFile = jsonDecode(response.body);
      List<dynamic> datas = jsonFile;
      return datas;
    }
    throw 42;
  }
}
