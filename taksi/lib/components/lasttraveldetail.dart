import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksi/components/driverprofile.dart';
import 'package:taksi/layouts/appbar.dart';
import 'package:taksi/models/travel.dart';
import "package:http/http.dart" as http;

class TravelDetail extends StatefulWidget {
  String travelId;
  TravelDetail({this.travelId}) : super();

  @override
  _TravelDetailState createState() => _TravelDetailState();
}

int statusCode = 0;
List<Travel> _LastTravels = [];
String name ='';
String surname = '';
String id ='';
List<String> car = [];
var isLoader = false;

class _TravelDetailState extends State<TravelDetail> {
  Future<void> getUser(BuildContext context, String userId) async {
    setState(() {
      isLoader = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString("id"));
    final response = await http.get(
      Uri.parse(
          'https://hoptaksi-api.herokuapp.com/api/user/' + userId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      statusCode = 200;
      print(response.statusCode);

      var result = jsonDecode(response.body);
      print(result['data']);
      car.add(result['data'][0]['myCar'][0]);
      car.add(result['data'][0]['myCar'][1]);
      name = result['data'][0]['name'].toString();
      surname = result['data'][0]['surname'].toString();
      id = result['data'][0]['_id'].toString();
      print(car[0].toString());
      setState(() {
        
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

  Future<void> update(BuildContext context) async {
     setState(() {
      isLoader = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString("id"));
    final response = await http.get(
      Uri.parse(
          'https://hoptaksi-api.herokuapp.com/api/travel/' + widget.travelId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      statusCode = 200;
      print(response.statusCode);

      var result = jsonDecode(response.body);
      _LastTravels.clear();
      print(result['data'][0]['providerVehicleType']);
      setState(() {
        for (var i = 0; i < result['data'].length; i++) {
          _LastTravels.add(Travel(
              calledHour: result['data'][i]['calledHour'],
              card: result['data'][i]['card'],
              expectedTime: result['data'][i]['expectedTime'],
              startLocation: result['data'][i]['startLocation'],
              startHour: result['data'][i]['startHour'],
              startCity: result['data'][i]['startCity'],
              providerId: result['data'][i]['providerId'],
              endLocation: result['data'][0]['endLocation'],
              endHour: result['data'][i]['endHour'],
              id: result['data'][i]['_id']));
        }
        getUser(context, result['data'][0]['providerId'].toString());
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
    print(widget.travelId);
    update(context);
    // TODO: implement initState
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
          child: SingleChildScrollView(
            child: Stack(children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                      child:isLoader
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 350, 0, 0),
                  child: Column(
                    children: [
                      Center(child: CircularProgressIndicator()),
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Yükleniyor...',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ))
                    ],
                  ),
                )
              :   Column(
                    children: [
                      Column(children: [
                        SizedBox(
                            width: 250,
                            height: 250,
                            child: Image(
                              image: AssetImage('assets/yol.PNG'),
                              fit: BoxFit.scaleDown,
                            )),
                        Container(
                            width: MediaQuery.of(context).size.width - 20,
                            height: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                  color: Colors.grey.shade400, width: 2),
                            ),
                            child: Column(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20.0, 15, 0, 0),
                                child: Row(
                                  children: [
                                    Text(_LastTravels[0].startHour.toString(),
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 0, 0),
                                      child: Icon(
                                          Icons.download_for_offline_outlined,
                                          size: 20,
                                          color: Colors.blueAccent),
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 0, 0),
                                        child: SizedBox(
                                            width: 150,
                                            height: 50,
                                            child: Text(
                                              _LastTravels[0].startLocation.toString()
                                              +" "+_LastTravels[0].startCity.toString(),
                                              style: TextStyle(
                                                  color:
                                                      Colors.blueGrey.shade900,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            )))
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(85, 0, 192, 0),
                                child: SizedBox(
                                  height: 100,
                                  child: VerticalDivider(
                                    color: Colors.black,
                                    thickness: 1,
                                    indent: 0,
                                    endIndent: 0,
                                    width: 10,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                                child: Row(
                                  children: [
                                    Text(_LastTravels[0].endHour.toString(),
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                      child: Icon(Icons.arrow_drop_down,
                                          size: 40, color: Colors.blueAccent),
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 0, 0),
                                        child: SizedBox(
                                            width: 150,
                                            height: 50,
                                            child: Text(
                                              _LastTravels[0].startLocation.toString(),
                                              style: TextStyle(
                                                  color:
                                                      Colors.blueGrey.shade900,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            )))
                                  ],
                                ),
                              ),
                            ])),
                      ]),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 30, 230, 0),
                          child: Text('Sürücü İsmi',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold))),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 20),
                        child: Container(
                            width: MediaQuery.of(context).size.width - 10,
                            height: 160,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 25,
                                      spreadRadius: 10.0,
                                      offset: Offset(15.0, 15.0))
                                ]),
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: SizedBox(
                                      height: 90,
                                      width: 90,
                                      child: CircleAvatar(
                                          backgroundColor:
                                              Colors.grey.shade300)),
                                ),
                                Column(
                                  children: [
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 40, 0, 0),
                                        child: Text(name + " "+ surname,
                                            style: TextStyle(
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold))),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 0, 0),
                                        child: Text(car[0].toString(),
                                            style: TextStyle(
                                              fontSize: 15,
                                            ))),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: TextButton.icon(
                                          onPressed: () {},
                                          icon: Icon(Icons.star,
                                              size: 20, color: Colors.amber),
                                          label: Text('4.8',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(90, 0, 0, 0),
                                  child: TextButton.icon(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DriverProfile(providerId:  _LastTravels[0].providerId.toString(),)));
                                      },
                                      icon: Icon(Icons.chevron_right_sharp,
                                          size: 35,
                                          color: Colors.grey.shade500),
                                      label: Text('')),
                                )
                              ],
                            )),
                      ),
                      Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 230, 10),
                              child: Text('Ödeme Şekli',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold))),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Container(
                                width: MediaQuery.of(context).size.width - 15,
                                height: 90,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 0, 0),
                                      child: Image(
                                          image: NetworkImage(
                                              'https://logos-world.net/wp-content/uploads/2020/09/Mastercard-Logo.png'),
                                          height: 50,
                                          width: 50),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '***** 8295',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          140, 0, 0, 0),
                                      child: Text(
                                        '₺',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Text(
                                        '7',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Text(
                                        ',63',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Container(
                                width: MediaQuery.of(context).size.width - 15,
                                height: 90,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 0, 0),
                                      child: Text(
                                        'Nakit',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          240, 0, 0, 0),
                                      child: Text(
                                        '₺',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Text(
                                        '7',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Text(
                                        ',63',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                            child: RaisedButton(
                              onPressed: () {},
                              splashColor: Colors.yellowAccent,
                              textColor: Colors.black,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 120),
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
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ))),
            ]),
          )),
    ));
  }
}
