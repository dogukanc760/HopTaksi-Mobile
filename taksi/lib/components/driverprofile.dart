import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksi/layouts/appbar.dart';
import "package:http/http.dart" as http;
import 'package:taksi/slidinguppanel.dart';

var isLoader = false;

class DriverProfile extends StatefulWidget {
  String providerId;
  DriverProfile({this.providerId=''}) : super();

  @override
  _DriverProfileState createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
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
                  child: ProfileDetail(
                providerId: widget.providerId,
              ))
            ]),
          )),
    ));
  }
}

class ProfileDetail extends StatefulWidget {
  String providerId;
  ProfileDetail({this.providerId}) : super();

  @override
  _ProfileDetailState createState() => _ProfileDetailState();
}

double boy = 0;
double hizmet = 0;
double konfor = 0;
int statusCode = 0;
String name = '';
String surname = '';
String id = '';
String createdAt = '';

List<String> car = [];

class _ProfileDetailState extends State<ProfileDetail> {
  Future<void> getUser(BuildContext context, String userId) async {
    setState(() {
      isLoader = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString("id"));
    final response = await http.get(
      Uri.parse('https://hoptaksi-api.herokuapp.com/api/user/' + userId),
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
      createdAt = result['data'][0]['createdAt'].toString();
      DateTime now = DateTime.now();
      //createdAt = DateFormat.yMMMd().add_jm().format(createdAt);
      id = result['data'][0]['_id'].toString();
      print(car[0].toString());
      setState(() {
        isLoader=false;
      });
    } else {
        setState(() {
      isLoader = false;
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
    title: Text("İşlem Başarılı!"),  
    content: Text("3 Saniye İçerisinde Anasayfaya Yönlendiriliyorsunuz..."),  
    actions: [  
      
    ],  
  );  
  
  // show the dialog  
  showDialog(  
    context: context,  
    builder: (BuildContext context) {  
      return alert;  
    },  
  );  
}   
  
 

  @override
  void initState() {
    getUser(context, widget.providerId);
    print(widget.providerId);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: isLoader
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
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text('Sürücü Profili',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.blueGrey.shade800)),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      height: 90,
                      width: 90,
                      child:
                          CircleAvatar(backgroundColor: Colors.grey.shade300)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Column(
                    children: [
                      Text(name + " " + surname,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.blueGrey.shade800)),
                      Text(car[0].toString(),
                          style: TextStyle(
                              fontSize: 18, color: Colors.blueGrey.shade800)),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(60.0, 0, 5, 2),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: RaisedButton(
                      onPressed: () {},
                      splashColor: Colors.yellowAccent,
                      textColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Colors.amber,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      color: Colors.amber,
                      child: Text(
                        'Hız\n9.9',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: RaisedButton(
                      onPressed: () {},
                      splashColor: Colors.yellowAccent,
                      textColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Colors.amber,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      color: Colors.amber,
                      child: Text(
                        'Hız\n9.9',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: RaisedButton(
                      onPressed: () {},
                      splashColor: Colors.yellowAccent,
                      textColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Colors.amber,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      color: Colors.amber,
                      child: Text(
                        'Hız\n9.9',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Container(
                    width: MediaQuery.of(context).size.width - 30,
                    height: 320,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 25,
                              spreadRadius: 10.0,
                              offset: Offset(15.0, 15.0))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 20, 0, 0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Tarih',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.bold)),
                            Text(createdAt,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.bold)),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Divider(
                                thickness: 1.2,
                                color: Colors.black,
                                endIndent: 25,
                              ),
                            ),
                            Text('Araç Tipi',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.bold)),
                            Text('Sedan',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.bold)),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Divider(
                                thickness: 1.2,
                                color: Colors.black,
                                endIndent: 25,
                              ),
                            ),
                            Text('Plaka',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.bold)),
                            Text(car[1].toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.bold)),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Divider(
                                thickness: 1.2,
                                color: Colors.black,
                                endIndent: 25,
                              ),
                            ),
                            Text('Üyelik Tarihi',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade500,
                                    fontWeight: FontWeight.bold)),
                            Text(createdAt,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.bold)),
                          ]),
                    ))),
            Padding(
              padding: EdgeInsets.fromLTRB(
                0,
                50,
                0,
                0,
              ),
              child: Text('SÜRÜCÜYÜ PUANLA',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hız?',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${boy.round()}',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                  Slider(
                    min: 0,
                    max: 10,
                    divisions: 10,
                    activeColor: Colors.grey,
                    value: boy,
                    //label: '$icilenSigara',
                    onChanged: (double newValue) {
                      setState(() {
                        boy = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hizmet?',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${hizmet.round()}',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                  Slider(
                    min: 0,
                    max: 10,
                    divisions: 10,
                    activeColor: Colors.grey,
                    value: hizmet,
                    //label: '$icilenSigara',
                    onChanged: (double newValue) {
                      setState(() {
                        hizmet = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Konfor?',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${konfor.round()}',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                  Slider(
                    min: 0,
                    max: 10,
                    divisions: 10,
                    activeColor: Colors.grey,
                    value: konfor,
                    //label: '$icilenSigara',
                    onChanged: (double newValue) {
                      setState(() {
                        konfor = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: SizedBox(
                    width: 350,
                    height: 150,
                    child: TextField(
                      style: TextStyle(height: 4),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[800]),
                          hintText: "Müşteri olarak yorumunuz.",
                          fillColor: Colors.grey.shade200),
                    ))),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: RaisedButton(
                onPressed: () {
                  showAlertDialogSuccess(context);
                  Timer(Duration(seconds:3), () { 

                   });
                  Timer(
                      Duration(seconds: 3),
                      () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (BuildContext context) => SlidingUp())));
                },
                splashColor: Colors.yellowAccent,
                textColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 120),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      color: Colors.amber, width: 1, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(18),
                ),
                color: Colors.amber,
                child: const Text(
                  'Tamam',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ));
  }
}
