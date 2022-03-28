import 'dart:collection';
import 'package:flutter/material.dart';

class Translates{
  String lang;
  Translates(this.lang);
  // HashMap hashMap = new HashMap<HashMap<String,String>, String>();
  // hashMap["sfes"]["sefase"]="sfeaes";
  String actives(){
    if(lang=="ru")return "Активы";
    else if(lang=='kz')return "Активтар";
    else return "Actives";
  }
  String settings(){
    if(lang=="ru")return "Настройки";
    else if(lang=='kz')return "Баптау";
    else return "Settings";
  }
  String leave(){
    if(lang=="ru")return "Выйти";
    else if(lang=='kz')return "Шығу";
    else return "Logout";
  }
  String notifications(){
    if(lang=="ru")return "Уведомления";
    else if(lang=='kz')return "Хабарландырулар";
    else return "Notifications";
  }
  String actives1(){
    if(lang=="ru")return "";
    else if(lang=='kz')return "";
    else return "";
  }
}