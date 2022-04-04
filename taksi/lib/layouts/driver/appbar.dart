import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksi/components/driverprofile.dart';

import 'package:taksi/driver/anasayfa_driver.dart';
import 'package:taksi/giris_yap.dart';

import 'package:taksi/slidinguppanel.dart';

import '../../components/driver/lasttravel.dart';
import '../../components/driver/mycard.dart';
import '../../components/driver/profile.dart';

class AppBarSide extends StatefulWidget {
  const AppBarSide({Key key}) : super(key: key);

  @override
  _AppBarSideState createState() => _AppBarSideState();
}

class _AppBarSideState extends State<AppBarSide> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff333333),
      height: 90,
      child: AppBar(
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
    );
  }
}

class DrawerSide extends StatefulWidget {
  const DrawerSide({Key key}) : super(key: key);

  @override
  _DrawerSideState createState() => _DrawerSideState();
}

String username = '';
String name = '';
String surname = '';
String img = '';
var isLoading = false;
var isCurrent = true;
String current = 'Müsait';

class _DrawerSideState extends State<DrawerSide> {
  void getSessions() async {
    final prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username').toString();
    name = prefs.getString('name').toString();
    surname = prefs.getString('surname').toString();
    img = prefs.getString('img').toString();
    print(name + 'bizim isim');
  }

  void destroySession(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    print('cıkıs');
    await prefs.clear();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => giris_yap()),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    getSessions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 310,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.amber),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Transform.scale(
                      scale: 0.8,
                      child: CupertinoSwitch(
                        value: isCurrent,
                        onChanged: (value) {
                          setState(() {
                            isCurrent = value;
                            if (isCurrent) {
                              current = 'Müsait';
                            } else {
                              current = 'Müsait Değil';
                            }
                          });
                        },
                      ),
                    ),
                    Text(current)
                  ]),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(360),
                            border: Border.all(color: Colors.grey.shade400)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(360),
                          child: img.isEmpty
                              ? Image.network(
                                  'https://kitinsan.com/wp-content/uploads/2019/05/depositphotos_39258143-stock-illustration-businessman-avatar-profile-picture.jpg',
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.fill,
                                )
                              : Image.network(
                                  'https://upload.wikimedia.org/wikipedia/commons/3/34/Elon_Musk_Royal_Society_%28crop2%29.jpg',
                                  width: 100,
                                  height: 120,
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Text(
                                name + '-' + surname,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              child: Text(
                                'Taksi Şöförü',
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Icon(FontAwesomeIcons.clock),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                            child: Text('10,5',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                            child: Text('Toplam Saat',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Icon(FontAwesomeIcons.road),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                              child: Text('10,5',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                              child: Text('Toplam Km',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Icon(FontAwesomeIcons.arrowCircleDown),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                              child: Text('10',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                              child: Text('Yolculuk Sayısı',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          ListTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 70,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepOrange,
                              spreadRadius: 0,
                              blurRadius: 0,
                              offset: const Offset(
                                  1, 0), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Text('Nakit',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ),
                            Row(children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                                child:
                                    Icon(FontAwesomeIcons.moneyBill, size: 20),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                child: Text('₺300.00',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19)),
                              )
                            ])
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: 70,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepOrange,
                              spreadRadius: 0,
                              blurRadius: 0,
                              offset: const Offset(
                                  1, 0), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Text('Kredi Kartı',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ),
                            Row(children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                                child:
                                    Icon(FontAwesomeIcons.moneyCheck, size: 20),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                child: Text('₺300.00',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19)),
                              )
                            ])
                          ],
                        )),
                  ),
                ]),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 145,
                      child: OutlineButton(
                          onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TaksiYolda(),
                                ),
                              ),
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: <Widget>[
                              Icon(
                                Icons.home,
                                color: Colors.grey,
                                size: 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    'Anasayfa',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          highlightedBorderColor: Colors.orange,
                          color: Colors.green,
                          borderSide: new BorderSide(color: Colors.white30),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0))),
                    ),
                    SizedBox(
                      width: 120,
                      child: OutlineButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyCards(),
                              ),
                            );
                          },
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: <Widget>[
                              Icon(
                                Icons.calendar_today,
                                color: Colors.grey,
                                size: 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    'Aidat',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          highlightedBorderColor: Colors.orange,
                          color: Colors.green,
                          borderSide: new BorderSide(color: Colors.white30),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0))),
                    ),
                    SizedBox(
                      width: 120,
                      child: OutlineButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyCards(),
                              ),
                            );
                          },
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.creditCard,
                                color: Colors.grey,
                                size: 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 37,
                                  ),
                                  Text(
                                    'Kartlarım',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          highlightedBorderColor: Colors.orange,
                          color: Colors.green,
                          borderSide: new BorderSide(color: Colors.white30),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0))),
                    ),
                    SizedBox(
                      width: 150,
                      child: OutlineButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Profile(),
                              ),
                            );
                          },
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: <Widget>[
                              Icon(
                                Icons.lock,
                                color: Colors.grey,
                                size: 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 35,
                                  ),
                                  Text(
                                    'Şifre Değiştir',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          highlightedBorderColor: Colors.orange,
                          color: Colors.green,
                          borderSide: new BorderSide(color: Colors.white30),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0))),
                    ),
                    SizedBox(
                      width: 150,
                      child: OutlineButton(
                          onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Profile(),
                                ),
                              ),
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: <Widget>[
                              Icon(
                                Icons.mail,
                                color: Colors.grey,
                                size: 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 35,
                                  ),
                                  Text(
                                    'Email Değiştir',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          highlightedBorderColor: Colors.orange,
                          color: Colors.green,
                          borderSide: new BorderSide(color: Colors.white30),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0))),
                    ),
                    SizedBox(
                      width: 190,
                      child: OutlineButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Profile(),
                              ),
                            );
                          },
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: <Widget>[
                              Icon(
                                Icons.phone_android,
                                color: Colors.grey,
                                size: 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Gsm Değiştir',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          highlightedBorderColor: Colors.orange,
                          color: Colors.green,
                          borderSide: new BorderSide(color: Colors.white30),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0))),
                    ),
                    SizedBox(
                      width: 195,
                      child: OutlineButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Profile(),
                              ),
                            );
                          },
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: <Widget>[
                              Icon(
                                Icons.account_balance_wallet_outlined,
                                color: Colors.grey,
                                size: 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'İBAN Değiştir',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          highlightedBorderColor: Colors.orange,
                          color: Colors.green,
                          borderSide: new BorderSide(color: Colors.white30),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0))),
                    ),
                    SizedBox(
                      width: 150,
                      child: OutlineButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Profile(),
                              ),
                            );
                          },
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: <Widget>[
                              Icon(
                                Icons.settings,
                                color: Colors.grey,
                                size: 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Ayarlar',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          highlightedBorderColor: Colors.orange,
                          color: Colors.green,
                          borderSide: new BorderSide(color: Colors.white30),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0))),
                    ),
                    SizedBox(
                      width: 150,
                      child: OutlineButton(
                          onPressed: () => destroySession(context),
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: <Widget>[
                              Icon(
                                Icons.logout,
                                color: Colors.grey,
                                size: 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 0,
                                  ),
                                  Text(
                                    'Çıkış',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          highlightedBorderColor: Colors.orange,
                          color: Colors.green,
                          borderSide: new BorderSide(color: Colors.white30),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0))),
                    ),
                  ],
                )
              ],
            ),
            onTap: () {},
          ),
        ],
      )),
    );
  }
}
