import 'package:flutter/material.dart';

class UserInfo{
   String _token;
   String _name;
   List<dynamic> _assets;

  UserInfo(this._token, this._name, this._assets);

  List<dynamic> get assets => _assets;

  set assets(List<dynamic> value) {
    _assets = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get token => _token;

  set token(String value) {
    _token = value;
  }
}