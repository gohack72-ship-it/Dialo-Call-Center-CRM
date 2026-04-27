import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'weather_model.dart';



class Weatherprovider extends ChangeNotifier{
  weathermodel? weather;
  bool isLoading=false;
  String? error;

  Future<void> fetchweather(String city)async{
    try {
      isLoading=true;
      error=null;
      notifyListeners();
final url =
 "https://api.weatherapi.com/v1/current.json?key=1f2f3b0b7e5b4c6fa7d105b0e6e4d21e&q=$city";
  final response = await http.get(Uri.parse(url));

  if(response.statusCode == 200){
  final data = jsonDecode(response.body);
  weather = weathermodel.fromjson(data);
  } else {
    error = "city not fount";
  }
    } catch (e){
      error = "something went wrong";
    }
     isLoading = false;
     notifyListeners();
    }
    
  }









