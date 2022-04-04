import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksi/layouts/driver/appbar.dart';
import "package:http/http.dart" as http;
import '../../driver/anasayfa_driver.dart';

class MyCards extends StatefulWidget {
  const MyCards({Key key}) : super(key: key);

  @override
  _MyCardsState createState() => _MyCardsState();
}

class _MyCardsState extends State<MyCards> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu_open_rounded,
                  color: Colors.black,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(''),
        ),
        drawer: DrawerSide(),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          top: true,
          bottom: true,
          left: true,
          right: true,
          child: Stack(
            children: [CardList()],
          ),
        ),
        //bottomNavigationBar: SlidingUp(contextWidget: Text(''),),

        // bottomNavigationBar: DraggableBottomSheetExample(),
      ),
    );
  }
}

final cardNum = TextEditingController();
final date = TextEditingController();
final cvv = TextEditingController();

String cardNumber = '';
String dateFinal = '';
String cvvFinal = '';
String fullName = '';
var isLoader = false;
int statusCode = 0;

class CardList extends StatefulWidget {
  const CardList({Key key}) : super(key: key);

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  Future<void> update(BuildContext context) async {
    setState(() {
      isLoader = true;
    });
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString("id"));
    final response = await http.put(
      Uri.parse('https://hoptaksi-api.herokuapp.com/api/user/' +
          prefs.getString('id')),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'card': [
          cardNum.text.toString(),
          date.text.toString(),
          cvv.text.toString()
        ]
      }),
    );

    if (response.statusCode == 200) {
      statusCode = 200;
      print(response.statusCode);

      var result = jsonDecode(response.body);
      setState(() {
        isLoader = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyCards()),
      );
      // prefs.setString('username', result['data']['mail']);
      // prefs.setString('mail', result['data']['mail']);
      // prefs.setString('name', result['data']['name']);
      // prefs.setString('surname', result['data']['surname']);
      // prefs.setString('gsm', result['data']['gsm']);
      // prefs.setString('id', result['data']['_id']);
      // // prefs.setString('adress', jsonEncode(result['data']['adress']));
      // prefs.setString('img', result['data']['img']);

      // print(prefs.getString('adress'));
      // foo(context);

    } else {
      setState(() {
        isLoader = false;
      });
      throw Exception();
    }
  }

  Future<void> get(BuildContext context) async {
    setState(() {
      isLoader = true;
    });
    final prefs = await SharedPreferences.getInstance();
    fullName = prefs.getString('name') + " " + prefs.getString('surname');
    print(prefs.getString("id"));
    final response = await http.get(
      Uri.parse('https://hoptaksi-api.herokuapp.com/api/user/' +
          prefs.getString('id')),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      statusCode = 200;
      print(response.statusCode);
      var result = jsonDecode(response.body);
      print(result);
      cardNumber = result['data'][0]['card'][0].toString();
      dateFinal = result['data'][0]['card'][1].toString();
      cvvFinal = result['data'][0]['card'][2].toString();
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
      title: Text("Kart Bilgilerinizi Giriniz"),
      content: Container(
        height: 350,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
          child: Column(
            children: [
              Container(
                width: 250,
                height: 77,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    controller: cardNum,
                    decoration: InputDecoration(
                        hintText: 'Kart Numaranız',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.card_membership),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Gsm no veya Email Alanı Boş Geçilemez!';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Container(
                width: 250,
                height: 77,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    controller: date,
                    decoration: InputDecoration(
                        hintText: 'Ay/Yıl',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.date_range_outlined),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Gsm no veya Email Alanı Boş Geçilemez!';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Container(
                width: 250,
                height: 77,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    controller: cvv,
                    decoration: InputDecoration(
                        hintText: 'CVV',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.security),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Gsm no veya Email Alanı Boş Geçilemez!';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  update(context);
                },
                splashColor: Colors.yellowAccent,
                textColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      color: Colors.amber, width: 1, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(18),
                ),
                color: Colors.amber,
                child: const Text(
                  'Kaydet',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
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

  getPayment(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Kart Bilgilerinizi Giriniz"),
      content: Container(
        height: 475,
        width: MediaQuery.of(context).size.width - 5,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
          child: Column(
            children: [
              Container(
                width: 250,
                height: 77,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    controller: cardNum,
                    decoration: InputDecoration(
                        hintText: 'Kart Numaranız',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.card_membership),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Gsm no veya Email Alanı Boş Geçilemez!';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Container(
                width: 250,
                height: 77,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    controller: date,
                    decoration: InputDecoration(
                        hintText: 'Ay/Yıl',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.date_range_outlined),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Gsm no veya Email Alanı Boş Geçilemez!';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Container(
                width: 250,
                height: 77,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    controller: date,
                    decoration: InputDecoration(
                        hintText: 'Kart Üzerinde ki isim',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.person),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Gsm no veya Email Alanı Boş Geçilemez!';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Container(
                width: 250,
                height: 77,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    controller: cvv,
                    decoration: InputDecoration(
                        hintText: 'CVV',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.security),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Gsm no veya Email Alanı Boş Geçilemez!';
                      }
                      return null;
                    },
                  ),
                ),
              ),
                 Container(
                width: 250,
                height: 77,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: TextFormField(
                    controller: cvv,
                    decoration: InputDecoration(
                        hintText: 'Tutar',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.money),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Gsm no veya Email Alanı Boş Geçilemez!';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  //update(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaksiYolda(),
                    ),
                  );
                },
                splashColor: Colors.yellowAccent,
                textColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      color: Colors.amber, width: 1, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(18),
                ),
                color: Colors.amber,
                child: const Text(
                  'Ödeme Al',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
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

  @override
  void initState() {
    get(context);
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
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Container(
                        width: MediaQuery.of(context).size.width - 20,
                        height: 250,
                        decoration: BoxDecoration(
                            color: Colors.blueGrey.shade700,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(250, 15, 0, 0),
                            child: SizedBox(
                                width: 70,
                                height: 70,
                                child: Image(
                                    image: NetworkImage(
                                        'https://logos-world.net/wp-content/uploads/2020/09/Mastercard-Logo.png'))),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 230, 0),
                            child: Text(
                              'CARD NUMBER',
                              style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
                                child: Text(
                                  cardNumber.substring(0, 4),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Text(
                                    'XX XXXX XXXX',
                                    style: TextStyle(
                                      color: Colors.white38,
                                      fontSize: 20,
                                    ),
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 0, 0),
                                  child: Text(
                                    'MONTH/YEAR',
                                    style: TextStyle(
                                      color: Colors.white60,
                                      fontSize: 14,
                                    ),
                                  )),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(150, 20, 0, 0),
                                  child: Text(
                                    'CVV',
                                    style: TextStyle(
                                      color: Colors.white60,
                                      fontSize: 14,
                                    ),
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: Text(
                                    dateFinal,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  )),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(187, 0, 0, 0),
                                  child: Text(
                                    cvvFinal,
                                    style: TextStyle(
                                      color: Colors.white38,
                                      fontSize: 20,
                                    ),
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 0, 0),
                                  child: Text(
                                    fullName,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(130.0, 10, 5, 2),
                                child: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(90)),
                                    child: FlatButton(
                                        onPressed: () {},
                                        child: Text('X',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black87)))),
                              )
                            ],
                          ),
                        ])),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 15,
                            offset: const Offset(
                                1, 7), // changes position of shadow
                          ),
                        ],
                      ),
                      child: RaisedButton(
                        onPressed: () {
                          showAlertDialog(context);
                        },
                        splashColor: Colors.yellowAccent,
                        textColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 100),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Colors.amber,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        color: Colors.amber,
                        child: const Text(
                          'Düzenle',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 15,
                            offset: const Offset(
                                1, 7), // changes position of shadow
                          ),
                        ],
                      ),
                      child: RaisedButton(
                        onPressed: () {
                          getPayment(context);
                        },
                        splashColor: Colors.yellowAccent,
                        textColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 100),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Colors.amber,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        color: Colors.amber,
                        child: const Text(
                          'Kart İle Ödeme Al',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),

                  //   Padding(
                  //    padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                  //    child: Container(
                  //         decoration: BoxDecoration(
                  //           boxShadow: [
                  //             BoxShadow(
                  //               color: Colors.grey.withOpacity(0.5),
                  //               spreadRadius: 5,
                  //               blurRadius: 15,
                  //               offset:
                  //                   const Offset(1, 7), // changes position of shadow
                  //             ),
                  //           ],
                  //         ),
                  //         child: RaisedButton(
                  //           onPressed: () {

                  //           },
                  //           splashColor: Colors.yellowAccent,
                  //           textColor: Colors.black,
                  //           padding: const EdgeInsets.symmetric(
                  //               vertical: 15, horizontal: 60),
                  //           shape: RoundedRectangleBorder(
                  //             side: const BorderSide(
                  //                 color: Colors.amber,
                  //                 width: 1,
                  //                 style: BorderStyle.solid),
                  //             borderRadius: BorderRadius.circular(18),
                  //           ),
                  //           color: Colors.amber,
                  //           child: const Text(
                  //             'Başka Kart İle Ödeme',
                  //             style:
                  //                 TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  //           ),
                  //         ),
                  //       ),
                  //  ),
                ],
              ));
  }
}
