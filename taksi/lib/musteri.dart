import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:location/location.dart';
import 'package:taksi/slidinguppanel.dart';
import 'dart:async';


import 'draggable.dart';

class Musteri extends StatefulWidget {
  const Musteri({Key key}) : super(key: key);

  @override
  _MusteriState createState() => _MusteriState();
}

class _MusteriState extends State<Musteri> {
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
        drawer: Container(
          child: Drawer(
              child: ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 270,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.black54),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(360),
                            border: Border.all(color: Colors.grey.shade400)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(360),
                          child: Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/3/34/Elon_Musk_Royal_Society_%28crop2%29.jpg',
                            width: 100,
                            height: 120,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Text(
                          'Arc Yazılım',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: Text(
                          'Müşteri Adı',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150,
                          child: OutlineButton(
                              onPressed: () => null,
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
                                  borderRadius:
                                      new BorderRadius.circular(5.0))),
                        ),
                        SizedBox(
                          width: 150,
                          child: OutlineButton(
                              onPressed: () => null,
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: <Widget>[
                                  Icon(
                                    Icons.credit_card,
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
                                  borderRadius:
                                      new BorderRadius.circular(5.0))),
                        ),
                        SizedBox(
                          width: 150,
                          child: OutlineButton(
                              onPressed: () => null,
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: <Widget>[
                                  Icon(
                                    Icons.wallet_giftcard_outlined,
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
                                        'Promosyon',
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
                                  borderRadius:
                                      new BorderRadius.circular(5.0))),
                        ),
                        SizedBox(
                          width: 150,
                          child: OutlineButton(
                              onPressed: () => null,
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
                                  borderRadius:
                                      new BorderRadius.circular(5.0))),
                        ),
                        SizedBox(
                          width: 150,
                          child: OutlineButton(
                              onPressed: () => null,
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
                                  borderRadius:
                                      new BorderRadius.circular(5.0))),
                        ),
                      ],
                    )
                  ],
                ),
                onTap: () {},
              )
            ],
          )),
        ),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          top: true,
          bottom: true,
          left: true,
          right: true,
          child: Stack(
            children: [],
          ),
        ),
        //bottomNavigationBar: SlidingUp(contextWidget: Text(''),),

        // bottomNavigationBar: DraggableBottomSheetExample(),
      ),
    );
  }
}
