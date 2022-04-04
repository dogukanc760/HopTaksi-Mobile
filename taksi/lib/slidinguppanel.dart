import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:taksi/taksi_cagirildi.dart';
import "package:http/http.dart" as http;

import 'layouts/appbar.dart';

class SlidingUp extends StatefulWidget {
  // final Widget contextWidget;
  //const SlidingUp({this.contextWidget}) : super();
  const SlidingUp() : super();
  @override
  _SlidingUpState createState() => _SlidingUpState();
}

class _SlidingUpState extends State<SlidingUp> {
  String slideHeaderText = 'Inıtal Text';
  String sehir = '';
  String ilce = '';
  int statusCode = 0;
  var locationData;
  var woeid;
  Position position;
  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Uyarı!"),
      content: Text("Bölgenizde Aktif Taksi Bulunmuyor. Tekrar deneyiniz."),
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
      content: Text(
          "Taksinize haber verildi en kısa sürede size ulaşacaktır. Yönlendiriliyorsunuz"),
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

  showAlertDialogRez(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("Kapat"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("İşlem Başarısız!"),
      content: Text(
          "Bölgenizde rezervasyon için aktif hizmet veren bulunmamaktadır!"),
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

  Future<void> login(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    var date = DateFormat('hh:mm:ss').format(DateTime.now()).toString();
    date += ' ÖS';
    var userId = prefs.getString('id');
    if (sehir == 'Mountain View') {
      sehir = "Izmir";
    }
    print(date + sehir);
    print(prefs.getString('id'));
    final response = await http.post(
      Uri.parse('https://hoptaksi-api.herokuapp.com/api/travel'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "userId": userId,
        "providerId": "61f6f2292977401ddd30c68b",
        "expectedTime": "10 Dakika",
        "licencePlate": "35 BMW 330",
        "card": "",
        "paymentMethod": "Kart",
        "startCity": sehir,
        "startLocation": ilce,
        "endLocation": sehir,
        "providerLocation": sehir,
        "calledHour": date,
        "startHour": date,
        "endHour": date,
        "whenProviderComed": date,
        "providerVehicle": "BMW",
        "providerVehicleType": "SEDAN",
        "providerRating": "0",
      }),
    );

    if (response.statusCode == 201) {
      statusCode = 201;
      print(response.statusCode);

      var result = jsonDecode(response.body);
      if (result['data'].length > 0) {
        //prefs.setString('travelId', result['data']['_id']);
        print(prefs.getString('travelId'));
        print(result);
        print(prefs.getString('travelId'));

        showAlertDialogSuccess(context);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => TaksiCagirildi(
                    baslangic: date,
                    bitis: date,
                    taksiKonum: sehir + "-" + ilce,
                    musteriKonum: sehir + "-" + ilce,
                  )),
        );
      } else {
        showAlertDialog(context);
      }
    } else {
      showAlertDialog(context);
      throw Exception();
    }
  }

  Future<void> getDevicePosition() async {
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      ilce = placemarks[0].subAdministrativeArea.toString();
      sehir = placemarks[0].administrativeArea.toString();
      print(placemarks[0].subAdministrativeArea);
      print(placemarks[0].administrativeArea);
    } catch (error) {
      print('Oluşan hata: $error');
    }
    print(position);
  }

  Future<void> getLocationDataByLatLong() async {
    locationData = await http.get(Uri.parse(
        'https://www.metaweather.com/api/location/search/?lattlong=${position.latitude},${position.longitude}'));
    var locationDataParsed = jsonDecode(locationData.body);
    woeid = locationDataParsed[0]['woeid'];
    // sehir = locationDataParsed[0]['title'];
    print(sehir);
    print(woeid);
  }

  void UpdateText() {
    setState(() {
      slideHeaderText = 'Size En Yakın Taksiler Aranıyor';
    });
  }

  void getDataFromAPI() async {
    await getDevicePosition();
  }

  @override
  void initState() {
    super.initState();
  }

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
              width: MediaQuery.of(context).size.width - 10,
              height: MediaQuery.of(context).size.height - 50,
              color: Colors.red),
        ),
        bottomNavigationBar: SlidingUpPanel(
          defaultPanelState: PanelState.OPEN,
          backdropOpacity: 1,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          maxHeight: 350,
          minHeight: 48,
          collapsed: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(0.5),
              ),
              child: Column(
                children: [
                  Center(
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.keyboard_arrow_up,
                            color: Colors.white,
                          ))),
                ],
              )),
          color: Colors.black.withOpacity(0.7),
          body: Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 90, 0, 0),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Color(0xff333333),
                  child: Image.asset(
                    'assets/logo.png',
                  )),
            ),
          ),
          panel: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 15,
                  offset: const Offset(1, 0), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(0.5),
                    ),
                    child: Column(
                      children: [
                        Center(
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                ))),
                      ],
                    )),
                SizedBox(
                  width: 250,
                  height: 65,
                  child: RaisedButton(
                    onPressed: () {
                      getDataFromAPI();
                      login(context);
                      // Navigator.pushReplacement(
                      //     context, MaterialPageRoute(builder: (context) => TaksiCagirildi()));
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
                      getDataFromAPI();
                      login(context);
                      // Navigator.pushReplacement(
                      //     context, MaterialPageRoute(builder: (context) => Musteri()));
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
                    disabledColor: Colors.grey,
                    onPressed: () {
                      // Navigator.pushReplacement(context,
                      //     MaterialPageRoute(builder: (context) => Musteri()));
                      showAlertDialogRez(context);
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
      ),
    );
  }
}
