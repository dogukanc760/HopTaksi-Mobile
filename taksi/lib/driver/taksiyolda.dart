import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:taksi/slidinguppanel.dart';
import 'package:taksi/taksi_cagirildi.dart';
import "package:http/http.dart" as http;

import '../layouts/driver/appbar.dart';
import '../models/travel.dart';
import '../driver/anasayfa_driver.dart';

List<Travel> travel = [];
var isLoader = false;
String debit = '';
String travelId = '';
final messageController = TextEditingController();

class TaksiYoldaa extends StatefulWidget {
  String travelObject;
   TaksiYoldaa({this.travelObject}) : super();

  @override
  _TaksiYoldaaState createState() => _TaksiYoldaaState();
}

class _TaksiYoldaaState extends State<TaksiYoldaa> {
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
                child: Text("Hizmet verene iletilmek üzere mesajınızı giriniz.",
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
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 35.0, horizontal: 20.0),
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
                          'Gönder',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
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
      isLoader=true;
    });
     final prefs = await SharedPreferences.getInstance();
   
    //print(debit + 'debit');
    final response = await http.get(
      Uri.parse('https://hoptaksi-api.herokuapp.com/api/travel/' +
          prefs.getString('travelId')),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      print(response.statusCode);

      var result = jsonDecode(response.body);
      
      setState(() {
        isLoader = false;
      });
    } else {
      setState(() {
        isLoader = false;
      });
      throw Exception();
    }
  }

 
  Future<void> getTravel() async {
    setState(() {
      isLoader = true;
    });
    final prefs = await SharedPreferences.getInstance();
    debit = prefs.getString('card');
    print(widget.travelObject + "asdfasdf");
    final response = await http.get(
      Uri.parse('https://hoptaksi-api.herokuapp.com/api/travel/' +
          widget.travelObject),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      print(response.statusCode);

      var result = jsonDecode(response.body);
      print(result['data']);
      setState(() {
        travel.add(Travel(
            calledHour: result['data'][0]['calledHour'],
            card: result['data'][0]['card'],
            expectedTime: result['data'][0]['expectedTime'],
            licencePlate: result['data'][0]['licencePlate'],
            paymentMethod: result['data'][0]['paymentMethod'],
            startCity: result['data'][0]['startCity'],
            startLocation: result['data'][0]['startLocation'],
            endLocation: result['data'][0]['endLocation'],
            providerLocation: result['data'][0]['providerLocation'],
            startHour: result['data'][0]['startHour'],
            endHour: result['data'][0]['endHour'],
            whenProviderComed: result['data'][0]['whenProviderComed'],
            providerVehicle: result['data'][0]['providerVehicle'],
            providerVehicleType: result['data'][0]['providerVehicleType'],
            providerRating: result['data'][0]['providerRating']));
        //print(travel[0]);
      });
      setState(() {
        isLoader = false;
      });
    } else {
      setState(() {
        isLoader = false;
      });
      throw Exception();
    }
  }

  @override
  void initState() {
    getTravel();
    super.initState();
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
          defaultPanelState: PanelState.OPEN,
          backdropOpacity: 1,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          maxHeight: 365,
          minHeight: 44,
          color: Colors.black.withOpacity(0.7),
          body: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 90, 0, 0),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Color(0xff333333),
                      child: isLoader
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
                                    transform: Matrix4.translationValues(
                                        0.0, -8.0, 0.0),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 0),
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
                                    transform: Matrix4.translationValues(
                                        0.0, -40.0, 0.0),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          80, 0, 0, 0),
                                      child: Text(
                                        'Tahmini varış süresi',
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    transform: Matrix4.translationValues(
                                        0.0, -30.0, 0.0),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          80, 0, 0, 0),
                                      child: travel[0].licencePlate == ''
                                          ? Text('')
                                          : Text(
                                              travel[0].licencePlate,
                                              style: TextStyle(
                                                  color: Colors.grey.shade700,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                    ),
                                  ),
                                  Container(
                                    transform: Matrix4.translationValues(
                                        0.0, -10.0, 0.0),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          80, 0, 0, 0),
                                      child: SizedBox(
                                        width: 80,
                                        height: 55,
                                        child: RaisedButton(
                                          onPressed: () {},
                                          splashColor: Colors.yellowAccent,
                                          textColor: Colors.indigo,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 5),
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.grey.shade400,
                                                width: 1,
                                                style: BorderStyle.solid),
                                            borderRadius:
                                                BorderRadius.circular(18),
                                          ),
                                          color: Colors.grey.shade400,
                                          child: Text(
                                            travel[0].expectedTime,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
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
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SlidingUp()));
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
                      child: Text(
                        'İster Takside Nakit Ödeyebilirsiniz',
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        transform: Matrix4.translationValues(-40, -90.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(80, 0, 0, 0),
                          child: Text(
                            'İster Takside Kartınızla',
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        transform: Matrix4.translationValues(-30, -90.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(80, 0, 0, 0),
                          child: Row(
                            children: [
                              Icon(Icons.credit_card,
                                  size: 30, color: Colors.redAccent),
                              Text(
                                '*** ' + 'XXXX',
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
                                      icon: const Icon(
                                        Icons.call,
                                        size: 35,
                                      ),
                                      tooltip: '',
                                      onPressed: () {
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                                Text(
                                  'Ara',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
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
                              BoxShadow(
                                  color: Colors.blueAccent, spreadRadius: 3),
                            ],
                          ),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.message,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                    tooltip: '',
                                    onPressed: () {
                                      setState(() {
                                        showAlertDialogSuccess(context);
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Text(
                                'Mesaj',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
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
