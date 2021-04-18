import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'utils/reusable_card.dart';
import 'utils/icon_content.dart';

// import 'package:double_back_to_close_app/double_back_to_close_app.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class ParseData {
  int eTime;
  String date;
  String time;
  String day;

  ParseData(this.eTime, this.date, this.time, this.day);

  factory ParseData.fromJson(dynamic parsedJson) {
    return ParseData(
      parsedJson['eTime'] as int,
      parsedJson['date'].toString(),
      parsedJson['time'].toString(),
      parsedJson['day'].toString(),
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  List leTime, ldate, ltime, lday;
  List<ParseData> sData1 = [];
  List<ParseData> sData2 = [];
  List<ParseData> sData3 = [];
  List<ParseData> sData4 = [];
  String s = "";
  Future<String> _loadParseDataAsset() async {
    return await rootBundle.loadString('assets/smart.json');
  }

  Future loadParseData(int no) async {
    String jsonString = await _loadParseDataAsset(); // Deserialization  step 1
    final jsonResponse = json.decode(jsonString); // Deserialization  step 2
    String eTime =
        jsonResponse['Slot $no']['Slot$no Elapsed Time(s): '].values.toString();
    String date =
        jsonResponse['Slot $no']['Timestamp(Date): '].values.toString();
    String time =
        jsonResponse['Slot $no']['Timestamp(Time): '].values.toString();
    String day = jsonResponse['Slot $no']['Timestamp(Day): '].values.toString();
    eTime = eTime.substring(1, eTime.length - 1);
    date = date.substring(1, date.length - 1);
    time = time.substring(1, time.length - 1);
    day = day.substring(1, day.length - 1);
    leTime = eTime.split(", ");
    ldate = date.split(", ");
    ltime = time.split(", ");
    lday = day.split(", ");
    for (int i = 0; i < leTime.length; i++) {
      s += '{"eTime": ' +
          leTime[i] +
          ',"date": "' +
          ldate[i].toString() +
          '","time": "' +
          ltime[i].toString() +
          '","day": "' +
          lday[i].toString() +
          '"},';
    }
    s = '[' + s.substring(0, s.length - 1) + ']';
    print(s);
    final res = json.decode(s); // Deserialization  step 2
    switch (no) {
      case 1:
        {
          setState(() {
            for (Map<String, dynamic> i in res) {
              sData1.add(ParseData.fromJson(i)); // Deserialization step 3
            }
          });
        }
        break;
      case 2:
        {
          setState(() {
            for (Map<String, dynamic> i in res) {
              sData2.add(ParseData.fromJson(i)); // Deserialization step 3
            }
          });
        }
        break;
      case 3:
        {
          setState(() {
            for (Map<String, dynamic> i in res) {
              sData3.add(ParseData.fromJson(i)); // Deserialization step 3
            }
          });
        }
        break;
      case 4:
        {
          setState(() {
            for (Map<String, dynamic> i in res) {
              sData4.add(ParseData.fromJson(i)); // Deserialization step 3
            }
          });
        }
    }
    s = "";
  }

  final databaseRef = FirebaseDatabase.instance.reference();
  int slot1, slot2, slot3, slot4;
  Future<void> printFirebase() async {
    await Firebase.initializeApp();
    databaseRef.onValue.listen((event) {
      setState(() {
        slot1 = event.snapshot.value['S1 time'];
        slot2 = event.snapshot.value['S2 time'];
        slot3 = event.snapshot.value['S3 time'];
        slot4 = event.snapshot.value['S4 time'];
      });
    });
  }

  @override
  void initState() {
    loadParseData(1);
    loadParseData(2);
    loadParseData(3);
    loadParseData(4);
    printFirebase();
    super.initState();
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> color = <Color>[];
    color.add(Colors.blue[50]);
    color.add(Colors.blue[200]);
    color.add(Colors.blue);

    final List<double> stops = <double>[];
    stops.add(0.0);
    stops.add(0.5);
    stops.add(1.0);

    final LinearGradient gradientColors =
        LinearGradient(colors: color, stops: stops,begin: Alignment.bottomCenter,end: Alignment.topCenter);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              "Parking Slots",
              style: TextStyle(
                fontSize: 23.0,
                fontWeight: FontWeight.bold,
                //fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
          ),
        ),

        //? BODY
        body: ListView(
          children: <Widget>[
            SizedBox(height: 20.0),
            SizedBox(
              height: 5.0,
              child: Divider(
                indent: 180,
                endIndent: 180,
                color: Colors.grey[400],
                thickness: 1.2,
              ),
            ),
            //?
            ReusableCard(
              gradient1: Color(0xFF045DE9),
              gradient2: Color(0xFF0CBABA),
              cardChild: IconContent(
                iconName: FontAwesomeIcons.car,
                iconColor: slot1 == 0 ? Colors.white : Colors.redAccent,
                fieldName: slot1 == 0 ? "Slot 1: Empty" : "Slot 1: Occupied",
                subFieldName:
                    slot1 == 0 ? "" : "Total Time: " + slot1.toString(),
              ),
              onPress: (){
                  
              },
            ),

            //! My Complaints
            ReusableCard(
              gradient1: Color(0xFFFBB034),
              gradient2: Color(0xFFFFDD00),
              cardChild: IconContent(
                iconName: FontAwesomeIcons.car,
                iconColor: slot2 == 0 ? Colors.white : Colors.redAccent,
                fieldName: slot2 == 0 ? "Slot 2: Empty" : "Slot 2: Occupied",
                subFieldName:
                    slot2 == 0 ? "" : "Total Time: " + slot2.toString(),
              ),
            ),

            //?
            ReusableCard(
              gradient1: Color(0xFF11998e), //380036
              gradient2: Color(0xFF38de7d), //0CBABA
              cardChild: IconContent(
                iconName: FontAwesomeIcons.car,
                iconColor: slot3 == 0 ? Colors.white : Colors.redAccent,
                fieldName: slot3 == 0 ? "Slot 3: Empty" : "Slot 3: Occupied",
                subFieldName:
                    slot3 == 0 ? "" : "Total Time: " + slot3.toString(),
              ),
            ),

            //! Safety Tips Website
            ReusableCard(
              gradient1: Color(0xffFF8008), //0xFFF42B03
              gradient2: Color(0xffFFC837), //0xFFFFBE0B
              cardColour: Colors.white,
              cardChild: IconContent(
                iconName: FontAwesomeIcons.car,
                iconColor: slot4 == 0 ? Colors.white : Colors.redAccent,
                fieldName: slot4 == 0 ? "Slot 4: Empty" : "Slot 4: Occupied",
                subFieldName:
                    slot4 == 0 ? "" : "Total Time: " + slot4.toString(),
              ),
            ),
            SizedBox(height: 20),
            SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                // Chart title
                title: ChartTitle(text: 'Elapsed Time by Actual Time '),
                // Enable legend
                legend:
                    Legend(isVisible: true),
                series: <ChartSeries<ParseData, String>>[
                  AreaSeries<ParseData, String>(
                      dataSource: sData1, // Deserialized Json data list.
                      name: "Time",
                      xValueMapper: (ParseData eTime, _) => eTime.time,
                      yValueMapper: (ParseData eTime, _) => eTime.eTime,
                      gradient: gradientColors
                      // Enable data label
                      )
                ]),
          ],
        ),
      ),
    );
  }
}
