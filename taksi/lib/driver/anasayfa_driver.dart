import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:taksi/driver/taksiyolda.dart';
import 'package:taksi/slidinguppanel.dart';
import 'package:taksi/taksi_cagirildi.dart';
import "package:http/http.dart" as http;

import '../layouts/driver/appbar.dart';
import '../models/travel.dart';

List<Travel> travel = [];
var timers;
int statusCode = 0;
var isLoading = false;
var userHasCome = false;
var userCounter = 60;
var userCounterFinish = true;
List<Travel> _LastTravels = [];
String debit = '';
String travelId = '';

final messageController = TextEditingController();

class TaksiYolda extends StatefulWidget {
  const TaksiYolda({Key key}) : super(key: key);

  @override
  _TaksiYoldaState createState() => _TaksiYoldaState();
}

class _TaksiYoldaState extends State<TaksiYolda> {
  Future<void> getTravel(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString("id"));
    final response = await http.get(
      Uri.parse(
          'https://hoptaksi-api.herokuapp.com/api/travel/get-by-provider/' +
              prefs.getString('id')),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      statusCode = 200;
      print(response.body);

      var result = jsonDecode(response.body);
      _LastTravels.clear();
      // print(result['data'][0]['providerVehicleType']);
      setState(() {
        travel.clear();
        _LastTravels.clear();
        for (var i = 0; i < result['data'].length; i++) {
          print('asdf');
          _LastTravels.add(Travel(
              calledHour: result['data'][i]['calledHour'],
              card: result['data'][i]['card'],
              expectedTime: result['data'][i]['expectedTime'],
              startLocation: result['data'][i]['startLocation'],
              startHour: result['data'][i]['startHour'],
              startCity: result['data'][i]['startCity'],
              endLocation: result['data'][0]['endLocation'],
              endHour: result['data'][i]['endHour'],
              id: result['data'][i]['_id']));
        }
        travel.add(Travel(
            calledHour: result['data'][_LastTravels.length - 1]['calledHour'],
            card: result['data'][_LastTravels.length - 1]['card'],
            expectedTime: result['data'][_LastTravels.length - 1]
                ['expectedTime'],
            startLocation: result['data'][_LastTravels.length - 1]
                ['startLocation'],
            startHour: result['data'][_LastTravels.length - 1]['startHour'],
            startCity: result['data'][_LastTravels.length - 1]['startCity'],
            endLocation: result['data'][0]['endLocation'],
            endHour: result['data'][_LastTravels.length - 1]['endHour'],
            id: result['data'][_LastTravels.length - 1]['_id']));

        travelId = travel[travel.length-1].id;
        print(travelId+"tırevıl aydi");
      });

      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception();
    }
  }

  showAlertDialogSuccess(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Mesaj Gönderme Alanı"),
      content: Container(
        width: 150,
        height: 350,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                  child:
                      Text("Hizmet verene iletilmek üzere mesajınızı giriniz.",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ))),
            ),
            Container(
              width: 387,
              height: 150,
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: SizedBox(
                  child: TextFormField(
                    controller: messageController,
                    //obscureText: _passwordVisible,
                    enableSuggestions: false,
                    autocorrect: false,
                    // The validator receives the text that the user has entered.
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 35.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.message_rounded),
                      ),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Şifre Boş Geçilemez!';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ),
            Container(
              //transform: Matrix4.translationValues(0.0, -80.0, 0.0),
              child: SizedBox(
                width: 200,
                height: 53,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    sendSms(context);
                  },
                  splashColor: Colors.yellowAccent,
                  textColor: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        color: Colors.amber,
                        width: 1,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  color: Colors.amber,
                  child: const Text(
                    'Gönder',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> sendSms(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();

    //print(debit + 'debit');
    final response = await http.get(
      Uri.parse(
          'https://hoptaksi-api.herokuapp.com/api/travel/get-by-provider/' +
              prefs.getString('id')),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);

      var result = jsonDecode(response.body);

      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception();
    }
  }

  void userDemands() {
   timers = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        userCounter--;
      });
      if (userCounter == 0) {
        setState(() {
          userCounterFinish = true;
          userHasCome = false;
        });

        timer.cancel();
      }
    });
  }

  var counter = 0;
  @override
  void initState() {
    userCounter = 60;
    getTravel(context);
    timers = Timer.periodic(const Duration(seconds: 2), (timer) {
      counter++;
      if (counter == 30) {
        getTravel(context);
        if (travel[0].id.isNotEmpty) {
          userDemands();
          setState(() {
            userHasCome = true;
          });

          timer.cancel();
        }
        timer.cancel();
        setState(() {
          counter = 0;
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    timers.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100), child: AppBarSide()),
        drawer: DrawerSide(),
        body: SafeArea(
          top: true,
          bottom: true,
          left: true,
          right: true,
          child: Container(
            color: Colors.blueAccent,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        bottomNavigationBar: SlidingUpPanel(
          collapsed: IconButton(
              onPressed: () {},
              icon:
                  Icon(Icons.keyboard_arrow_up, color: Colors.black, size: 35)),
          parallaxOffset: 0.5,
          parallaxEnabled: true,
          defaultPanelState: PanelState.OPEN,
          backdropOpacity: 1,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          maxHeight: 290,
          minHeight: 50,
          color: Colors.black.withOpacity(0.7),
          body: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 90, 0, 0),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 100,
                      color: Color(0xff333333),
                      child: isLoading
                          ? Container(
                              color: Color(0xff333333),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 200, 0, 0),
                                child: Column(
                                  children: [
                                    Center(child: CircularProgressIndicator()),
                                    Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Yükleniyor...',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            )
                          : Image.asset(
                              'assets/logo.png',
                            )),
                ),
                // widget.contextWidget
              ],
            ),
          ),
          panel: userHasCome
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 0,
                        blurRadius: 0,
                        offset:
                            const Offset(1, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: SizedBox(
                          height: 129,
                          width: 129,
                          child: Container(
                              transform:
                                  Matrix4.translationValues(-100.0, -85.0, 0.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(90),
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
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Image.network(
                                            'https://www.kindpng.com/picc/m/152-1526778_taxi-williamstown-hot-wheels-bmw-clip-art-hd.png',
                                            height: 84,
                                            width: 100,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        transform: Matrix4.translationValues(
                                            0.0, -8.0, 0.0),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 0, 0),
                                          child: Text(
                                            '',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey.shade600),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Column(
                                  //   mainAxisAlignment: MainAxisAlignment.end,
                                  //   children: [
                                  //     Container(
                                  //       transform: Matrix4.translationValues(
                                  //           0.0, -40.0, 0.0),
                                  //       child: Padding(
                                  //         padding: const EdgeInsets.fromLTRB(
                                  //             80, 0, 0, 0),
                                  //         child: Text(
                                  //           'Tahmini varış süresi',
                                  //           style: TextStyle(
                                  //               color: Colors.grey.shade700,
                                  //               fontWeight: FontWeight.bold),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     Container(
                                  //       transform: Matrix4.translationValues(
                                  //           0.0, -30.0, 0.0),
                                  //       child: Padding(
                                  //         padding: const EdgeInsets.fromLTRB(
                                  //             80, 0, 0, 0),
                                  //         child: Text('Plaka')

                                  //       ),
                                  //     ),
                                  //     Container(
                                  //       transform: Matrix4.translationValues(
                                  //           0.0, -10.0, 0.0),
                                  //       child: Padding(
                                  //         padding: const EdgeInsets.fromLTRB(
                                  //             80, 0, 0, 0),
                                  //         child: SizedBox(
                                  //           width: 80,
                                  //           height: 55,
                                  //           child: RaisedButton(
                                  //             onPressed: () {},
                                  //             splashColor: Colors.yellowAccent,
                                  //             textColor: Colors.indigo,
                                  //             padding: const EdgeInsets.symmetric(
                                  //                 vertical: 20, horizontal: 5),
                                  //             shape: RoundedRectangleBorder(
                                  //               side: BorderSide(
                                  //                   color: Colors.grey.shade400,
                                  //                   width: 1,
                                  //                   style: BorderStyle.solid),
                                  //               borderRadius:
                                  //                   BorderRadius.circular(18),
                                  //             ),
                                  //             color: Colors.grey.shade400,
                                  //             child: Text(
                                  //              '10 dakika',
                                  //               style: TextStyle(
                                  //                   fontSize: 14,
                                  //                   fontWeight: FontWeight.bold),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // )
                                ],
                              )),
                        ),
                      ),
                      Container(
                        transform: Matrix4.translationValues(0.0, -80.0, 0.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 15,
                          height: 70,
                          child: RaisedButton(
                            onPressed: () {
                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => SlidingUp()));
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
                              'Müşteri belirtilen konuma en kısa sürede taksi talep etmektedir.',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Container(
                          transform: Matrix4.translationValues(0.0, -80.0, 0.0),
                          child: Text(
                              "${userCounter} saniye içerisinde yanıtlayınız.",
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18))),
                      Container(
                        transform: Matrix4.translationValues(0.0, -80.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FlatButton(
                                  minWidth: 150,
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TaksiYoldaa(travelObject: travelId,)));
                                  },
                                  child: Text('Evet'),
                                  color: Colors.amber),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FlatButton(
                                  minWidth: 150,
                                  onPressed: () {
                                    setState(() {
                                      userHasCome = false;
                                    });
                                  },
                                  child: Text('Hayır'),
                                  color: Colors.grey.shade200),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 0,
                        blurRadius: 0,
                        offset:
                            const Offset(1, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: SizedBox(
                          height: 129,
                          width: 129,
                          child: Container(
                              transform:
                                  Matrix4.translationValues(-100.0, -85.0, 0.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(90),
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
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Image.network(
                                            'https://www.kindpng.com/picc/m/152-1526778_taxi-williamstown-hot-wheels-bmw-clip-art-hd.png',
                                            height: 100,
                                            width: 100,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        transform: Matrix4.translationValues(
                                            0.0, -8.0, 0.0),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 0, 0),
                                          child: Text(
                                            '',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey.shade600),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Column(
                                  //   mainAxisAlignment: MainAxisAlignment.end,
                                  //   children: [
                                  //     Container(
                                  //       transform: Matrix4.translationValues(
                                  //           0.0, -40.0, 0.0),
                                  //       child: Padding(
                                  //         padding: const EdgeInsets.fromLTRB(
                                  //             80, 0, 0, 0),
                                  //         child: Text(
                                  //           'Tahmini varış süresi',
                                  //           style: TextStyle(
                                  //               color: Colors.grey.shade700,
                                  //               fontWeight: FontWeight.bold),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     Container(
                                  //       transform: Matrix4.translationValues(
                                  //           0.0, -30.0, 0.0),
                                  //       child: Padding(
                                  //         padding: const EdgeInsets.fromLTRB(
                                  //             80, 0, 0, 0),
                                  //         child: Text('Plaka')

                                  //       ),
                                  //     ),
                                  //     Container(
                                  //       transform: Matrix4.translationValues(
                                  //           0.0, -10.0, 0.0),
                                  //       child: Padding(
                                  //         padding: const EdgeInsets.fromLTRB(
                                  //             80, 0, 0, 0),
                                  //         child: SizedBox(
                                  //           width: 80,
                                  //           height: 55,
                                  //           child: RaisedButton(
                                  //             onPressed: () {},
                                  //             splashColor: Colors.yellowAccent,
                                  //             textColor: Colors.indigo,
                                  //             padding: const EdgeInsets.symmetric(
                                  //                 vertical: 20, horizontal: 5),
                                  //             shape: RoundedRectangleBorder(
                                  //               side: BorderSide(
                                  //                   color: Colors.grey.shade400,
                                  //                   width: 1,
                                  //                   style: BorderStyle.solid),
                                  //               borderRadius:
                                  //                   BorderRadius.circular(18),
                                  //             ),
                                  //             color: Colors.grey.shade400,
                                  //             child: Text(
                                  //              '10 dakika',
                                  //               style: TextStyle(
                                  //                   fontSize: 14,
                                  //                   fontWeight: FontWeight.bold),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // )
                                ],
                              )),
                        ),
                      ),
                      Container(
                        transform: Matrix4.translationValues(0.0, -80.0, 0.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 15,
                          height: 70,
                          child: RaisedButton(
                            onPressed: () {
                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => SlidingUp()));
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
                              'Bekleme Sayfasındasınız, talep oluştuğunda buradan görüntüleyebilirsiniz.',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 35),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
