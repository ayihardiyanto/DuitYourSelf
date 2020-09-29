import 'package:flutter/material.dart';

class ErrorScreen extends StatefulWidget {

  @override
  _ErrorScreenState createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
       body: Center(
         child: Column(
           children: <Widget>[
             Text('Something Went Wrong!')
           ],
         ),),
    );
  }
}