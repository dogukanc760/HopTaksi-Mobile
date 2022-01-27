import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:taksi/taksi_cagirildi.dart';

import 'layouts/appbar.dart';
import 'musteri.dart';

class TaksiYolda extends StatefulWidget {
  const TaksiYolda({Key key}) : super(key: key);

  @override
  _TaksiYoldaState createState() => _TaksiYoldaState();
}

class _TaksiYoldaState extends State<TaksiYolda> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100), child: AppBarSide()),
        drawer: DrawerSide(),
        body: SafeArea(
          top: true,
          bottom: true,
          left: true,
          right: true,
          child: Container(
            color:Colors.blueAccent,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        bottomNavigationBar: SlidingUpPanel(
          defaultPanelState: PanelState.OPEN,
          backdropOpacity: 1,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          maxHeight: 365,
          minHeight: 44,

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
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    spreadRadius: 0,
                    blurRadius: 0,
                    offset: const Offset(1, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: SizedBox(
                      height: 150,
                      width: 350,
                      child: Container(
                          transform: Matrix4.translationValues(0.0, -90.0, 0.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Colors.grey.shade200, width: 5),
                            boxShadow: [
                             BoxShadow(
                                color: Colors.white,
                                spreadRadius: 10,
                                blurRadius: 5,
                                offset: const Offset(
                                    0, 7), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    child: Image.network(
                                      'https://www.kindpng.com/picc/m/152-1526778_taxi-williamstown-hot-wheels-bmw-clip-art-hd.png',
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                  Container(
                                    transform: Matrix4.translationValues(0.0, -8.0, 0.0),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Text(
                                        'Taksiniz Yolda',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey.shade600),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    transform: Matrix4.translationValues(0.0, -40.0, 0.0),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(80, 0, 0, 0),
                                      child: Text('Tahmini varış süresi', style: TextStyle(color: Colors.grey.shade700,
                                      fontWeight: FontWeight.bold),),
                                    ),
                                  ),
                                  Container(
                                    transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(80, 0, 0, 0),
                                      child: Text('35 BMW 330', style: TextStyle(color: Colors.grey.shade700,
                                      fontSize: 18, fontWeight: FontWeight.bold),),
                                    ),
                                  ),
                                  Container(
                                    transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(80, 0, 0, 0),
                                      child:  SizedBox(
                                        width: 80,
                                        height: 55,
                                        child: RaisedButton(
                                          onPressed: () {

                                          },
                                          splashColor: Colors.yellowAccent,
                                          textColor: Colors.indigo,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 25),
                                          shape: RoundedRectangleBorder(
                                            side:  BorderSide(
                                                color: Colors.grey.shade400,
                                                width: 1,
                                                style: BorderStyle.solid),
                                            borderRadius: BorderRadius.circular(18),
                                          ),
                                          color: Colors.grey.shade400,
                                          child: const Text(
                                            '3 Dk',
                                            style: TextStyle(
                                                fontSize: 14, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              )
                            ],
                          )),
                    ),
                  ),
                  Container(
                    transform: Matrix4.translationValues(0.0, -80.0, 0.0),
                    child: SizedBox(
                      width: 200,
                      height: 53,
                      child: RaisedButton(

                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Musteri()));
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
                          'Tamam',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 35),
                  Container(
                    transform: Matrix4.translationValues(-90.0, -100.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(80, 0, 0, 0),
                      child: Text('İster Takside Nakit Ödeyebilirsiniz', style: TextStyle(color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold),),
                    ),
                  ),
                  Row(children: [
                    Container(
                      transform: Matrix4.translationValues(-40, -90.0, 0.0),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(80, 0, 0, 0),
                        child: Text('İster Takside Kartınızla', style: TextStyle(color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold),),
                      ),
                    ),
                    Container(
                      transform: Matrix4.translationValues(-30, -90.0, 0.0),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(80, 0, 0, 0),
                        child: Row(
                          children: [
                            Icon(Icons.credit_card, size: 30, color:Colors.redAccent),
                            Text('*** 8295', style: TextStyle(color: Colors.grey.shade600,
                                fontSize:16,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                  ],),
                  Container(
                    transform: Matrix4.translationValues(0, -50.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                          child: Container(
                            width: 70,
                            height: 67,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.amber,
                              boxShadow: [
                                BoxShadow(color: Colors.amber, spreadRadius: 3),
                              ],
                            ),

                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.call, size: 35,),
                                      tooltip: '',
                                      onPressed: () {
                                        setState(() {

                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Text('Ara', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 70,
                          height: 67,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blueAccent,
                            boxShadow: [
                              BoxShadow(color: Colors.blueAccent, spreadRadius: 3),
                            ],
                          ),

                          child: Column(
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.message,color:Colors.white, size: 35,),
                                    tooltip: '',
                                    onPressed: () {
                                      setState(() {

                                      });
                                    },
                                  ),
                                ],
                              ),
                              Text('Mesaj', style: TextStyle(fontSize: 16, color:Colors.white,fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
