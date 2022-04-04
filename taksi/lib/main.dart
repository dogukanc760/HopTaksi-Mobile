import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taksi/giris_yap.dart';
import 'package:taksi/provinces.dart';

import 'provinces.dart';

void main() {
  runApp(
    MaterialApp(
      color: Color(0xFF333333),
      title: 'HOP TAKSI',
      theme: ThemeData(primaryColor: Colors.amber),
      home: ilkSayfa(),
    ),
  );
}

class ilkSayfa extends StatefulWidget {
  @override
  _ilkSayfaState createState() => _ilkSayfaState();
}

class _ilkSayfaState extends State<ilkSayfa> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => provinces())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF333333),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/ilkSayfa.PNG"), fit: BoxFit.fill),
          ),
        ),
      ),
    );
  }
}
