import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'utils/reusable_card.dart';
import 'utils/icon_content.dart';
import 'package:flutter_icons/flutter_icons.dart';

// import 'package:double_back_to_close_app/double_back_to_close_app.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final databaseRef = FirebaseDatabase.instance.reference();
  String slot1 = "";
  String slot2 = "";
  String slot3 = "";
  String slot4 = "";
  void printFirebase(){
    databaseRef.onValue.listen((event) {
      setState(() {
      slot1 = "Slot 1 Elapsed Time(s): " + event.snapshot.value['Slot1 Elapsed Time(s): '].toString();
      slot2 = "Slot 2 Elapsed Time(s): " + event.snapshot.value['Slot2 Elapsed Time(s): '].toString();
      slot3 = "Slot 3 Elapsed Time(s): " + event.snapshot.value['Slot3 Elapsed Time(s): '].toString();
      slot4 = "Slot 4 Elapsed Time(s): " + event.snapshot.value['Slot4 Elapsed Time(s): '].toString();  
      });    
    });
}
@override
  void initState() {
    printFirebase();
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
            Expanded(
              child: ReusableCard(
                gradient1: Color(0xFF045DE9),
                gradient2: Color(0xFF0CBABA),
                cardChild: IconContent(
                  iconName: FontAwesomeIcons.car,
                  iconColor: Colors.white,
                  fieldName: slot1,
                ),
              ),
            ),

            //! My Complaints
            Expanded(
              child: ReusableCard(
                gradient1: Color(0xFFFBB034),
                gradient2: Color(0xFFFFDD00),
                cardChild: IconContent(
                  iconName: FontAwesomeIcons.car,
                  iconColor: Colors.white,
                  fieldName: slot2,
                ),
              ),
            ),

            //?
            Expanded(
              child: ReusableCard(
                gradient1: Color(0xFF11998e), //380036
                gradient2: Color(0xFF38de7d), //0CBABA
                cardChild: IconContent(
                  iconName: FontAwesomeIcons.car,
                  iconColor: Colors.white,
                  fieldName: slot3,
                ),
              ),
            ),

            //! Safety Tips Website
            Expanded(
              child: ReusableCard(
                gradient1: Color(0xffFF8008), //0xFFF42B03
                gradient2: Color(0xffFFC837), //0xFFFFBE0B
                cardColour: Colors.white,
                cardChild: IconContent(
                  iconName: FontAwesomeIcons.car,
                  iconColor: Colors.white,
                  fieldName: slot4,
                ),
              ),
            ),
          ],
        ),

        //! SoS Button
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: () {
        //     return Alert(
        //       context: context,
        //       type: AlertType.warning,
        //       title: "ALERT",
        //       desc: "SoS message will be sent to emergency contacts, Conitnue?",
        //       buttons: [
        //         DialogButton(
        //           child: Text(
        //             "Continue",
        //             style: TextStyle(color: Colors.white, fontSize: 20),
        //           ),
        //           onPressed: () async {
        //             _textMe();
        //             Fluttertoast.showToast(
        //                 msg: "SoS message sent succesfully",
        //                 toastLength: Toast.LENGTH_LONG);
        //             Navigator.pop(context);
        //           },
        //           color: Colors.blueAccent,
        //         ),
        //         DialogButton(
        //             child: Text(
        //               "Cancel",
        //               style: TextStyle(color: Colors.white, fontSize: 20),
        //             ),
        //             onPressed: () async {
        //               Navigator.pop(context);
        //             },
        //             color: Colors.redAccent)
        //       ],
        //     ).show();
        //   },
        //   label: Text('SOS'),
        //   icon: Icon(Icons.report),
        //   backgroundColor: Colors.red,
        // ),
        //bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}
