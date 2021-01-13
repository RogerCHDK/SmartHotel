import 'package:flutter/material.dart';
import 'package:hoteles/user/widgets/gradient_back.dart';
import 'package:hoteles/widgets/title_header.dart';

class Control extends StatefulWidget {
  @override
  _ControlState createState() => _ControlState();
}

class _ControlState extends State<Control> {
  bool isSwitched = false;
  bool isSwitched2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        GradientBack(
          height: 300.0,
        ),
        Row(
          //Appbar
          children: <Widget>[
            Flexible(
                child: Container(
              padding: EdgeInsets.only(top: 45.0, left: 20.0, right: 10.0),
              child: TitleHeader(title: "Reservacion"),
            ))
          ],
        ),
        Container(
          padding: EdgeInsets.only(top: 305.0, left: 20.0, right: 10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Lampara 1",
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Center(
                    child: Switch(
                      value: isSwitched2,
                      onChanged: (value) {
                        setState(() {
                          isSwitched2 = value;
                          print(isSwitched2);
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Calefacción",
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Center(
                    child: Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                          print(isSwitched);
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
