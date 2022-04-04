import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksi/components/driver/lasttraveldetail.dart';
import 'package:taksi/layouts/driver/appbar.dart';

import "package:http/http.dart" as http;
import 'package:taksi/models/travel.dart';

class LastTravel extends StatefulWidget {
  const LastTravel({Key key}) : super(key: key);

  @override
  _LastTravelState createState() => _LastTravelState();
}

int statusCode = 0;
var isLoading = false;
List<Travel> _LastTravels = [];


class _LastTravelState extends State<LastTravel> {
  Future<void> update(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString("id"));
    final response = await http.get(
      Uri.parse('https://hoptaksi-api.herokuapp.com/api/travel/get-by-user/' +
          prefs.getString('id')),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      statusCode = 200;
      print(response.statusCode);

      var result = jsonDecode(response.body);
      _LastTravels.clear();
      // print(result['data'][0]['providerVehicleType']);
      setState(() {
        for (var i = 0; i < result['data'].length; i++) {
          print('asdf');
           _LastTravels.add(Travel(calledHour:result['data'][i]['calledHour'], card:result['data'][i]['card'],
           expectedTime:result['data'][i]['expectedTime'], startLocation: result['data'][i]['startLocation'],
           startHour: result['data'][i]['startHour'], startCity: result['data'][i]['startCity'],
           
           endLocation: result['data'][0]['endLocation'], endHour: result['data'][i]['endHour'], id:result['data'][i]['_id']));
        }
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
  
  @override
  void initState() {
    update(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100), child: AppBarSide()),
      drawer: DrawerSide(),
      body: SafeArea(
          top: true,
          bottom: true,
          left: true,
          right: true,
          child: _LastTravels.length<1?Container(): ListView.builder(
            itemCount: _LastTravels.length,
            itemBuilder: (context, index) => Container(
              width: MediaQuery.of(context).size.width,
              child:isLoading
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
              :  Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(17.0),
                              child: Text('1 Ocak 2022 ÖS 06:39',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey.shade800,
                                      fontSize: 16)),
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      TextButton.icon(
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TravelDetail(travelId:_LastTravels[index].id.toString())));
                                          },
                                          icon: Icon(Icons.search),
                                          label: Text('')),
                                      TextButton(
                                          onPressed: () {},
                                          child: Text('SİL',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red,
                                                  fontSize: 16))),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                        Divider(
                            color: Colors.black26,
                            height: 5,
                            thickness: 2,
                            indent: 18,
                            endIndent: 18),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 15, 0, 0),
                          child: Row(
                            children: [
                              Text(_LastTravels[index].startHour.toString(),
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: Icon(Icons.download_for_offline_outlined,
                                    size: 20, color: Colors.blueAccent),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: SizedBox(
                                      width: 150,
                                      height: 50,
                                      child: Text(
                                        _LastTravels[index].startLocation.toString() + " "+_LastTravels[index].startCity.toString(),
                                        style: TextStyle(
                                            color: Colors.blueGrey.shade900,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 116, 0),
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
                          padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                          child: Row(
                            children: [
                              Text( _LastTravels[index].endHour.toString(),
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                                child: Icon(Icons.arrow_drop_down,
                                    size: 40, color: Colors.blueAccent),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: SizedBox(
                                      width: 150,
                                      height: 50,
                                      child: Text(
                                        _LastTravels[index].endLocation.toString(),
                                        style: TextStyle(
                                            color: Colors.blueGrey.shade900,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )))
                            ],
                          ),
                        ),
                      ])),
                )
              ]),
            ),
          )),
    ));
  }
}
