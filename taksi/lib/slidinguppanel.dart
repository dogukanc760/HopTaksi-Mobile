import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/services.dart';
import 'package:taksi/customer.dart';
import 'package:taksi/taksi_cagirildi.dart';

import 'layouts/appbar.dart';
import 'musteri.dart';


class SlidingUp extends StatefulWidget {
 // final Widget contextWidget;
  //const SlidingUp({this.contextWidget}) : super();
  const SlidingUp() : super();
  @override
  _SlidingUpState createState() => _SlidingUpState();
}

class _SlidingUpState extends State<SlidingUp> {
  String slideHeaderText = 'Inıtal Text';
  void UpdateText()
  {
    setState(() {
      slideHeaderText = 'Size En Yakın Taksiler Aranıyor';
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),child: AppBarSide()),
        drawer: DrawerSide(),
        body: SafeArea(
          top: true,
          bottom: true,
          left: true,
          right: true,
          child: Text('Naber'),
        ),
          bottomNavigationBar:SlidingUpPanel(
            defaultPanelState: PanelState.OPEN,
            backdropOpacity: 1,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            maxHeight: 350,
            minHeight: 44,
            collapsed:Container(
                decoration:
                BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(0.5),),
                child: Column(
                  children: [
                    Center(
                        child:IconButton(onPressed: (){}, icon: Icon(Icons.keyboard_arrow_up, color: Colors.white,))
                    ),

                  ],
                )),
            color: Colors.black.withOpacity(0.7),
            body: Container(

              child: Column(
                children: [
                 // widget.contextWidget
                ],
              ),
            ),
            panel: Expanded(
              child: Container(
                decoration: BoxDecoration(

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 0,
                      blurRadius: 15,
                      offset:
                      const Offset(1, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        decoration:
                        BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(0.5),),
                        child: Column(
                          children: [
                            Center(
                                child:IconButton(onPressed: (){}, icon: Icon(Icons.keyboard_arrow_down, color: Colors.white,))
                            ),

                          ],
                        )),
                    SizedBox(
                      width: 250,
                      height: 65,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => TaksiCagirildi()));
                        },
                        splashColor: Colors.yellowAccent,
                        textColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 25),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Colors.amber,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        color: Colors.amber,
                        child: const Text(
                          'HEMEN TAKSİ GELSİN',
                          style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 35),
                    SizedBox(
                      width: 250,
                      height: 60,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => Musteri()));
                        },
                        splashColor: Colors.yellowAccent,
                        textColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 25),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Colors.amber,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        color: Colors.amber,
                        child: const Text(
                          'KURYE TAKSİ',
                          style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 35),
                    SizedBox(
                      width: 250,
                      height: 60,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => Musteri()));
                        },
                        splashColor: Colors.yellowAccent,
                        textColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 25),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Colors.amber,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        color: Colors.amber,
                        child: const Text(
                          'REZERVASYON',
                          style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

          ) ,
      ),
    );
  }
}
