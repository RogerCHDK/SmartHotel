import 'package:flutter/material.dart';

class Control extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Control")),
        automaticallyImplyLeading: false,
      ),
      body: Text("control screen"),
    );
  }
}
