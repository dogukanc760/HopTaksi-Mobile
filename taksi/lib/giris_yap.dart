import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taksi/kayit_ol.dart';
import 'package:taksi/slidinguppanel.dart';

import 'musteri.dart';

class giris_yap extends StatefulWidget {
  const giris_yap({Key key}) : super(key: key);

  @override
  _girisYapState createState() => _girisYapState();
}

class _girisYapState extends State<giris_yap> {
  bool _passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF333333),
      ),
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
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
                        offset:
                            const Offset(1, 7), // changes position of shadow
                      ),
                    ],
                  ),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => SlidingUp()));
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                        offset:
                            const Offset(1, 7), // changes position of shadow
                      ),
                    ],
                  ),
                  child: RaisedButton(
                    onPressed: () {},
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Row(children: <Widget>[
                  Expanded(
                    child: new Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 15.0),
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
                      margin: const EdgeInsets.only(left: 15.0, right: 10.0),
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
                            style: TextStyle(fontSize: 20, color: Colors.white),
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
                                  fontSize: 20, fontWeight: FontWeight.bold),
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
