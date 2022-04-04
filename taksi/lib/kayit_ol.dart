import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksi/components/driver/profile.dart';
import 'package:taksi/driver/anasayfa_driver.dart';
import 'package:taksi/giris_yap.dart';
import 'package:http/http.dart' as http;
import 'package:taksi/slidinguppanel.dart';

class kayitOl extends StatefulWidget {
  const kayitOl({Key key}) : super(key: key);

  @override
  _kayitOlState createState() => _kayitOlState();
}

final _formKey = GlobalKey<FormState>();
final nameEditor = TextEditingController();
final surnameEditor = TextEditingController();
final numPhoneEditor = TextEditingController();
final passwordEditor = TextEditingController();
final mailEditor = TextEditingController();
int statusCode = 0;
String username = '';
var isLoading = false;

class _kayitOlState extends State<kayitOl> {
  bool _passwordVisible = true;
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
      title: Text("İşlem Başarısız!"),
      content: Text("Alanları  Kontrol Ederek Tekrar Deneyiniz!"),
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

  Future<void> login(String mail, String password, String name, String surname,
      String gsm, BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    final response = await http.post(
      Uri.parse('https://hoptaksi-api.herokuapp.com/api/user/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'surname': surname,
        'gsm': gsm,
        'mail': mail,
        'password': password,
        'img': ''
      }),
    );

    if (response.statusCode == 201) {
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
      prefs.setString('img', result['data']['img']);
      setState(() {
        isLoading = false;
      });

      // print(prefs.getString('adress'));
      foo(context);
    } else {
      setState(() {
        isLoading = false;
      });
      showAlertDialogSuccess(context);
      throw Exception();
    }
  }

  Future<void> loginProvider(String mail, String password, String name,
      String surname, String gsm, BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    final response = await http.post(
      Uri.parse('https://hoptaksi-api.herokuapp.com/api/user/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'isProvider': true,
        'surname': surname,
        'gsm': gsm,
        'mail': mail,
        'password': password,
        'img': ''
      }),
    );

    if (response.statusCode == 201) {
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
      prefs.setString('img', result['data']['img']);

      setState(() {
        isLoading = false;
      });
      // print(prefs.getString('adress'));
      foos(context);
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

  void foos(BuildContext context) async {
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

  void validateAndSaveRegister() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      login(mailEditor.text, passwordEditor.text, nameEditor.text,
          surnameEditor.text, numPhoneEditor.text, context);
    } else {
      showAlertDialogSuccess(context);
    }
  }

  void validateAndSaveDriver() {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      loginProvider(mailEditor.text, passwordEditor.text, nameEditor.text,
          surnameEditor.text, numPhoneEditor.text, context);
    } else {
      showAlertDialogSuccess(context);
    }
  }

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
                          'Kayıt Yapılıyor...',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ))
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Form(
                    key: _formKey,
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
                                  'Kayıt Ol',
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
                          padding: EdgeInsets.only(right: 290, bottom: 5),
                          child: Text(
                            'AD',
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
                              controller: nameEditor,
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
                                  return 'Ad Alanı Boş Geçilemez!';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 270, bottom: 5),
                          child: Text(
                            'SOYAD',
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
                              controller: surnameEditor,
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
                                  return 'Soyad Alanı Boş Geçilemez!';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 250, bottom: 5),
                          child: Text(
                            'TELEFON',
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
                              controller: numPhoneEditor,
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
                                  return 'Telefon Alanı Boş Geçilemez!';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 250, bottom: 5),
                          child: Text(
                            'Mail',
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
                              controller: mailEditor,
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
                                  return 'Mail Alanı Boş Geçilemez!';
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
                              controller: passwordEditor,
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
                              validateAndSaveRegister();
                            },
                            splashColor: Colors.yellowAccent,
                            textColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 135),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.amber,
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            color: Colors.amber,
                            child: const Text(
                              'Kayıt Ol',
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
                              validateAndSaveDriver();
                            },
                            splashColor: Colors.yellowAccent,
                            textColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 91),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.amber,
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            color: Colors.amber,
                            child: const Text(
                              'SÜRÜCÜ KAYIT OL',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        Row(children: <Widget>[
                          Expanded(
                            child: new Container(
                              margin: const EdgeInsets.only(
                                  left: 10.0, right: 15.0),
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
                              margin: const EdgeInsets.only(
                                  left: 15.0, right: 10.0),
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
                                    'Hesabın var mı?',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => giris_yap(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Giriş Yap',
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
      ),
    );
  }
}
