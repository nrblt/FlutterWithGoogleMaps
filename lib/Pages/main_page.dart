// import 'package:api_manager/api_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import '../Components/button_widget.dart';
import 'map_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../Components/http_operations.dart';
import '../Components/nav_drawer.dart';

class MyApp extends StatelessWidget {
  static final String title = "My App";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(primaryColor: Colors.red),
      home: MainPage(title),
    );
  }
}

class MainPage extends StatefulWidget {
  final String title;

  MainPage( this.title);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  // final formKey = GlobalKey<FormState>();
  late String username = "";
  late String password = "";
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.grey,
        // body:Column(
        // children:<Widget>[
        body: Padding(
            padding: const EdgeInsets.fromLTRB(5, 250, 5, 0),
            child: Center(
                child: ListView(
                    padding: EdgeInsets.all(16.0),
                    scrollDirection: Axis.vertical,
                    children: [
                  buildUsername(),
                  const SizedBox(height: 16),
                  buildPassword(),
                  const SizedBox(height: 16),
                  buildSubmit(),
                ])))); //);
  }

  Widget buildUsername() => TextFormField(
        controller: _usernameController,
        decoration: InputDecoration(
          labelText: "Username",
          // border: OutlineInputBorder(),
        ),
      );

  Widget buildPassword() => TextFormField(
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: "Password",
          // border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
      );

  Widget buildSubmit() => Builder(
        builder: (context) => ButtonWidget(
            text: 'Login',
            onClicked: () async {
              username = _usernameController.text;
              password = _passwordController.text;
              // print(username);
              // print(password);
              await HttpService.login(username, password, context);
            }),
      );
}
