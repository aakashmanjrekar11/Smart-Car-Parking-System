import 'dart:convert';
import 'package:flutter/services.dart';

class Person {
  List leTime,ldate,ltime,lday;
  Future<String> _loadParseDataAsset() async {
    return await rootBundle.loadString('assets/smart.json');
  }

  Future loadParseData() async {
    String jsonString = await _loadParseDataAsset(); // Deserialization  step 1
    final jsonResponse = json.decode(jsonString); // Deserialization  step 2
    String eTime = jsonResponse['Slot 1']['Slot1 Elapsed Time(s): '].values.toString();
    String date = jsonResponse['Slot 1']['Timestamp(Date): '].values.toString();
    String time = jsonResponse['Slot 1']['Timestamp(Time): '].values.toString();
    String day = jsonResponse['Slot 1']['Timestamp(Day): '].values.toString();
    eTime = eTime.substring(1,eTime.length-1); 
    date = date.substring(1,date.length-1); 
    time = time.substring(1,time.length-1); 
    day = day.substring(1,day.length-1); 
    leTime = eTime.split(", ");
    ldate = date.split(", ");
    ltime = time.split(", ");
    lday = day.split(", ");
    
  }
  Person(this.name, this.age);  final String name;
  final int age;  // named constructor
  Person.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        age = json['age'];  // method
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
    };
  }
 
}