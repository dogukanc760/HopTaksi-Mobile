import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksi/driver/anasayfa_driver.dart';
import 'package:taksi/kayit_ol.dart';
import 'package:taksi/providermain.dart';
import 'package:taksi/slidinguppanel.dart';
import 'package:http/http.dart' as http;

class giris_yap extends StatefulWidget {
  const giris_yap({Key key}) : super(key: key);

  @override
  _girisYapState createState() => _girisYapState();
}

class _girisYapState extends State<giris_yap> {
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
      title: Text("Giriş Başarısız!"),
      content: Text("Kullanıcı Adı veya Şifreniz Yanlış"),
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

  final mail = TextEditingController();
  final password = TextEditingController();
  var isLoading = false;
  var isLoader = false;
  var statusCode = 0;

  Future<void> login(String mail, String password, BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    final response = await http.post(
      Uri.parse('https://hoptaksi-api.herokuapp.com/api/user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'gsm': mail, 'mail': mail, 'password': password}),
    );

    if (response.statusCode == 200) {
      statusCode = 200;
      print(response.statusCode);
      final prefs = await SharedPreferences.getInstance();
      var result = jsonDecode(response.body);
      print(result['data']);
      prefs.setString('username', result['data']['mail']);
      prefs.setString('name', result['data']['name']);
      prefs.setString('surname', result['data']['surname']);
      prefs.setString('gsm', result['data']['gsm']);
      prefs.setString('id', result['data']['_id']);
      prefs.setString('adress', jsonEncode(result['data']['adress']));
      prefs.setString('img', result['data']['img']);

      print(prefs.getString('adress'));
      setState(() {
        isLoading = false;
      });
      foo(context);
    } else {
      setState(() {
        isLoading = false;
      });
      showAlertDialogSuccess(context);
      throw Exception();
    }
  }

  Future<void> loginProvider(
      String mail, String password, BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    final response = await http.post(
      Uri.parse('https://hoptaksi-api.herokuapp.com/api/user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'mail': mail,
        'gsm': mail,
        'password': password,
        'img': ''
      }),
    );
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      statusCode = 200;
      print(response.statusCode);
      final prefs = await SharedPreferences.getInstance();
      var result = jsonDecode(response.body);
      print(result['data']);
      prefs.setString('username', result['data']['mail']);
      prefs.setString('mail', result['data']['mail']);
      prefs.setString('name', result['data']['name']);
      prefs.setString('surname', result['data']['surname']);
      prefs.setString('gsm', result['data']['gsm']);
      prefs.setString('id', result['data']['_id']);
      // prefs.setString('adress', jsonEncode(result['data']['adress']));
      // prefs.setString('card', result['data']['card']);
      prefs.setString('img', result['data']['img']);
      setState(() {
        isLoading = false;
      });
      // print(prefs.getString('adress'));
      fooProvider(context);
    } else {
      setState(() {
        isLoading = false;
      });
      showAlertDialogSuccess(context);
      throw Exception();
    }
  }

  void foo(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username').toString();

    if (!username.isEmpty) {
      print(prefs.getString('username').toString());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SlidingUp()),
      );
    } else {
      print("boş");
    }
  }

  void fooProvider(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username').toString();

    if (!username.isEmpty) {
      print(prefs.getString('username').toString());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TaksiYolda()),
      );
    } else {
      print("boş");
    }
  }

  bool _passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF333333),
      ),
      home: Scaffold(
        body: SafeArea(
          child: isLoading
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 350, 0, 0),
                  child: Column(
                    children: [
                      Center(child: CircularProgressIndicator()),
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Giriş Yapılıyor...',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ))
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 85,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Ink(
                                decoration: const ShapeDecoration(
                                  color: Colors.white,
                                  shape: CircleBorder(),
                                ),
                                child: IconButton(
                                  splashRadius: 30,
                                  iconSize: 30,
                                  icon: const Icon(Icons.keyboard_arrow_left),
                                  color: Colors.black,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 90),
                            const Padding(
                              padding: EdgeInsets.only(top: 25),
                              child: Text(
                                'Giriş Yap',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 105,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 135, top: 15),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/logo.png',
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 150, bottom: 5),
                        child: Text(
                          'EMAIL yada TELEFON',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        width: 387,
                        height: 77,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: TextFormField(
                            controller: mail,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                contentPadding: new EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 20.0),
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.check),
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
                      const Padding(
                        padding: EdgeInsets.only(right: 275, bottom: 5),
                        child: Text(
                          'ŞİFRE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        width: 387,
                        height: 77,
                        child: Padding(
                          padding: EdgeInsets.only(left: 25, right: 25),
                          child: TextFormField(
                            controller: password,
                            obscureText: _passwordVisible,
                            enableSuggestions: false,
                            autocorrect: false,
                            // The validator receives the text that the user has entered.
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });

                                  print(_passwordVisible);
                                },
                                icon: Icon(_passwordVisible
                                    ? Icons.remove_red_eye
                                    : Icons.remove_red_eye_outlined),
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
                      SizedBox(height: 15),
                      Container(
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
                            login(mail.text, password.text, context);
                          },
                          splashColor: Colors.yellowAccent,
                          textColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 100),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.amber,
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          color: Colors.amber,
                          child: const Text(
                            'Giriş Yap',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
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
                            loginProvider(mail.text, password.text, context);
                          },
                          splashColor: Colors.yellowAccent,
                          textColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 66),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.amber,
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          color: Colors.amber,
                          child: const Text(
                            'Sürücü Girişi Yap',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Row(children: <Widget>[
                        Expanded(
                          child: new Container(
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 15.0),
                            child: Divider(
                              color: Colors.white,
                              height: 60,
                              thickness: 1,
                            ),
                          ),
                        ),
                        Text(
                          "VEYA BUNUNLA GİRİŞ YAP",
                          style: TextStyle(color: Colors.white),
                        ),
                        Expanded(
                          child: new Container(
                            margin:
                                const EdgeInsets.only(left: 15.0, right: 10.0),
                            child: Divider(
                              color: Colors.white,
                              height: 50,
                              thickness: 1,
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(height: 25),
                      Row(
                        children: <Widget>[
                          IconButton(
                            padding: new EdgeInsets.only(left: 57),
                            onPressed: () {},
                            icon: Image.asset('assets/facebook_logo.png'),
                            iconSize: 50,
                            splashRadius: 150,
                          ),
                          IconButton(
                            padding: new EdgeInsets.only(left: 25),
                            onPressed: () {},
                            icon: Image.asset('assets/twitter_logo.png'),
                            iconSize: 50,
                            splashRadius: 150,
                          ),
                          IconButton(
                            padding: new EdgeInsets.only(left: 25),
                            onPressed: () {},
                            icon: Image.asset('assets/google_logo.png'),
                            iconSize: 48,
                            splashRadius: 150,
                          ),
                          IconButton(
                            padding: new EdgeInsets.only(left: 25),
                            onPressed: () {},
                            icon: Image.asset('assets/linkedin_logo.png'),
                            iconSize: 50,
                            splashRadius: 150,
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 80,
                                ),
                                const Text(
                                  'Hesabın yok mu?',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => kayitOl(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Kayıt Ol',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
