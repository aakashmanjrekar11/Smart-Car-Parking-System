import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'utils/reusable_card.dart';
import 'utils/icon_content.dart';
import 'utils/ParseJson.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List days = ['Monday','Tuesday','Wednesday','Thursday','Friday'];
  List leTime, ldate, ltime, lday;
  List temp=[];
  List pieData = [];
  List<PieData> data = [];
  List<ParseData> sData1 = [];
  List<ParseData> sData2 = [];
  List<ParseData> sData3 = [];
  List<ParseData> sData4 = [];
  String s = "";
  TooltipBehavior _tooltipBehavior;

  Future loadParseData(int no) async {
    String jsonString = await rootBundle.loadString('assets/smart.json'); // Deserialization  step 1
    final jsonResponse = json.decode(jsonString); // Deserialization  step 2
    String eTime =
        jsonResponse['Slot $no']['Slot$no Elapsed Time(s): '].values.toString();
    String time =
        jsonResponse['Slot $no']['Timestamp(Time): '].values.toString();
    String day = jsonResponse['Slot $no']['Timestamp(Day): '].values.toString();
    eTime = eTime.substring(1, eTime.length - 1);
    time = time.substring(1, time.length - 1);
    day = day.substring(1, day.length - 1);
    leTime = eTime.split(", ");
    ltime = time.split(", ");
    lday = day.split(", ");
    for (int i = 0; i < ltime.length; i++) {
      s += '{"eTime": ' +
          leTime[i].toString() +
          ',"time": "' +
          ltime[i].toString() +
          '","day": "' +
          lday[i].toString() +
          '"},';
    }
    s = '[' + s.substring(0, s.length - 1) + ']';
    final res = json.decode(s); // Deserialization  step 2
    switch (no) {
      case 1:
        {
          setState(() {
            for (Map<String, dynamic> i in res) {
              sData1.add(ParseData.fromJson(i)); // Deserialization step 3
              temp.add(i['day']);
            }
          });
        }
        break;
      case 2:
        {
          setState(() {
            for (Map<String, dynamic> i in res) {
              sData2.add(ParseData.fromJson(i)); // Deserialization step 3
              temp.add(i['day']);
            }
          });
        }
        break;
      case 3:
        {
          setState(() {
            for (Map<String, dynamic> i in res) {
              sData3.add(ParseData.fromJson(i)); // Deserialization step 3
              temp.add(i['day']);
            }
          });
        }
        break;
      case 4:
        {
          setState(() {
            for (Map<String, dynamic> i in res) {
              sData4.add(ParseData.fromJson(i)); // Deserialization step 3
              temp.add(i['day']);
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
    for(int i=0;i<5;i++){
      pieData.add(temp.where((e) => e == days[i]).length);  
    }
    int sum = pieData.fold(0, (p, c) => p + c);
    for(int i=0;i<pieData.length;i++){
      pieData[i]=(pieData[i]/sum)*100;
      data.add(PieData(days[i],pieData[i],pieData[i].toString().substring(0,5)+"%"));
    }
  }

  @override
  void initState() {
    loadParseData(1);
    loadParseData(2);
    loadParseData(3);
    loadParseData(4);
    printFirebase();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
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
            //Col
            SfCartesianChart(
              plotAreaBorderWidth: 0,
              title: ChartTitle(text: 'Hourly Time Based Analysis'),
              primaryXAxis: CategoryAxis(title: AxisTitle(text: 'Time(24hr)')),
              primaryYAxis:
                  NumericAxis(title: AxisTitle(text: 'Elapsed Time(s)')),
              series: _getDefaultColumn(),
              legend: Legend(isVisible: true),
              tooltipBehavior: _tooltipBehavior,
            ),
            SfCircularChart(
              title: ChartTitle(text:'Daywise Analysis'),
              legend: Legend(
                  isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
              series: <DoughnutSeries<PieData, String>>[
              DoughnutSeries<PieData, String>(
                  radius: '80%',
                  explode: true,
                  explodeOffset: '10%',
                  dataSource: data,
                  xValueMapper: (PieData day, _) => day.day,
                  yValueMapper: (PieData day, _) => day.avg,
                  dataLabelMapper: (PieData day, _) => day.percent,
                  dataLabelSettings: DataLabelSettings(isVisible: true))
            ],
            tooltipBehavior: TooltipBehavior(enable: true),
            ),
            ///Get the column series
          ],
        ),
      ),
    );
  }

  List<ColumnSeries<ParseData, String>> _getDefaultColumn() {
    return <ColumnSeries<ParseData, String>>[
      ColumnSeries<ParseData, String>(
          width: 0.8,
          spacing: 0.2,
          dataSource: sData1,
          color: const Color.fromRGBO(252, 216, 20, 1),
          xValueMapper: (ParseData eTime, _) => eTime.time,
          yValueMapper: (ParseData eTime, _) => eTime.eTime,
          name: 'Slot 1'),
      ColumnSeries<ParseData, String>(
          width: 0.8,
          spacing: 0.2,
          dataSource: sData2,
          color: const Color.fromRGBO(205, 127, 50, 1),
          xValueMapper: (ParseData eTime, _) => eTime.time,
          yValueMapper: (ParseData eTime, _) => eTime.eTime,
          name: 'Slot 2'),
      ColumnSeries<ParseData, String>(
          width: 0.8,
          spacing: 0.2,
          dataSource: sData3,
          color: const Color.fromRGBO(22, 216, 20, 1),
          xValueMapper: (ParseData eTime, _) => eTime.time,
          yValueMapper: (ParseData eTime, _) => eTime.eTime,
          name: 'Slot 3'),
      ColumnSeries<ParseData, String>(
          width: 0.8,
          spacing: 0.2,
          dataSource: sData4,
          color: const Color.fromRGBO(10, 107, 242, 1),
          xValueMapper: (ParseData eTime, _) => eTime.time,
          yValueMapper: (ParseData eTime, _) => eTime.eTime,
          name: 'Slot 4'),
    ];
  }
}
