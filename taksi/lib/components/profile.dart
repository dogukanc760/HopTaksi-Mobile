import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksi/layouts/appbar.dart';
import "package:http/http.dart" as http;

var isEdit = false;
String mail = '';
String password = '';
String gsm = '';
String name = '';
String surname = '';
String userId = '';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
            child: Stack(children: [Container(child: Content())]),
          )),
    ));
  }
}

class Content extends StatefulWidget {
  const Content({Key key}) : super(key: key);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  var isLoading = false;
  int statusCode = 0;
  getSessions() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name');
    surname = prefs.getString('surname');
    gsm = prefs.getString('gsm');
    mail = prefs.getString('username');
    userId = prefs.getString('id');
    print(name);
  }

  final mailController = TextEditingController(text: mail);
  final passwordController = TextEditingController(text: '*****');
  final gsmController = TextEditingController(text: gsm);
  final nameController = TextEditingController(text: name);
  final surnameController = TextEditingController(text: surname);

  Future<void> update(String mailUp, String gsmUp, String nameUp,
      String surnameUp, BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    final response = await http.put(
      Uri.parse('https://hoptaksi-api.herokuapp.com/api/user/' + userId),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'mail': mailUp,
        'gsm': gsmUp,
        'name': nameUp,
        'surname': surnameUp
      }),
    );
    var result = jsonDecode(response.body);
    if (response.statusCode == 200) {
      statusCode = 200;
      print(response.statusCode);
      final prefs = await SharedPreferences.getInstance();
      var result = jsonDecode(response.body);
      print(result['data']);

      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      showAlertDialogSuccess(context);
      throw Exception();
    }
  }

  @override
  void initState() {
    getSessions();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
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
                          'Güncelleniyor...',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ))
                    ],
                  ),
                )
              : Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                isEdit
                    ? TextButton(
                        onPressed: () {
                          setState(() {
                            isEdit = !isEdit;
                            print(isEdit);
                            update(mailController.text, gsmController.text,
                             nameController.text, surnameController.text, context);
                          });
                        },
                        child: Text(
                          'Kaydet',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ))
                    : TextButton(
                        onPressed: () {
                          setState(() {
                            isEdit = !isEdit;
                            print(isEdit);
                            
                          });
                        },
                        child: Text(
                          'Düzenle',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ))
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                  child: SizedBox(
                      height: 120,
                      width: 120,
                      child:
                          CircleAvatar(backgroundColor: Colors.grey.shade300)),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                      child: Container(
                        width: 200,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: TextFormField(
                            controller: nameController,
                            enabled: isEdit,
                            // controller: mail,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Adınız',
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
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 20, 0, 0),
                      child: Container(
                        width: 200,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: TextFormField(
                            controller: surnameController,
                            enabled: isEdit,
                            // controller: mail,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Soyadınız',
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
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Container(
                  width: MediaQuery.of(context).size.width - 10,
                  height: MediaQuery.of(context).size.height - 220,
                  color: Colors.grey.shade200,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            child: Text('Ad Soyad Değiştirme',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade500))),
                      ),
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Telefon Numarası',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(60, 0, 0, 0),
                                  child: Container(
                                    width: 200,
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 0),
                                      child: TextFormField(
                                        controller: gsmController,
                                        enabled: isEdit,
                                        // controller: mail,
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText: '123123123',
                                            contentPadding:
                                                new EdgeInsets.symmetric(
                                                    vertical: 12.0,
                                                    horizontal: 15.0),
                                            suffixIcon: IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                  Icons.keyboard_arrow_right,
                                                  size: 35),
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
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Divider(
                                thickness: 1,
                                height: 15,
                                color: Colors.grey,
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Email',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(140, 0, 0, 0),
                                  child: Container(
                                    width: 200,
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 0),
                                      child: TextFormField(
                                        controller: mailController,
                                        enabled: isEdit,
                                        // controller: mail,
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText: '123123123',
                                            contentPadding:
                                                new EdgeInsets.symmetric(
                                                    vertical: 12.0,
                                                    horizontal: 15.0),
                                            suffixIcon: IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                  Icons.keyboard_arrow_right,
                                                  size: 35),
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
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Divider(
                                thickness: 1,
                                height: 15,
                                color: Colors.grey,
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Şifre',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(140, 0, 0, 0),
                                  child: Container(
                                    width: 200,
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 0),
                                      child: TextFormField(
                                        enabled: isEdit,
                                        // controller: mail,
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText: '*********',
                                            contentPadding:
                                                new EdgeInsets.symmetric(
                                                    vertical: 12.0,
                                                    horizontal: 15.0),
                                            suffixIcon: IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                  Icons.keyboard_arrow_right,
                                                  size: 35),
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
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Divider(
                                thickness: 1,
                                height: 15,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ));
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
