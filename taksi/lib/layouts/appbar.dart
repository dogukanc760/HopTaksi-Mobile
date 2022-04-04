

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taksi/components/driverprofile.dart';
import 'package:taksi/components/lasttravel.dart';
import 'package:taksi/components/mycard.dart';
import 'package:taksi/components/portlist.dart';
import 'package:taksi/components/profile.dart';
import 'package:taksi/giris_yap.dart';

import 'package:taksi/slidinguppanel.dart';

class AppBarSide extends StatefulWidget {
  const AppBarSide({Key key}) : super(key: key);

  @override
  _AppBarSideState createState() => _AppBarSideState();
}

class _AppBarSideState extends State<AppBarSide> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color:Color(0xff333333),
      height:90,
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

class _DrawerSideState extends State<DrawerSide> {
  void getSessions() async {
    final prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username').toString();
    name = prefs.getString('name').toString();
    surname = prefs.getString('surname').toString();
    img = prefs.getString('img').toString();
    print(name + 'bizim isim');
  }
   

   void destroySession(BuildContext context)async{
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
                      child: img.isEmpty
                          ? Image.network(
                              'https://kitinsan.com/wp-content/uploads/2019/05/depositphotos_39258143-stock-illustration-businessman-avatar-profile-picture.jpg',
                              width: 100,
                              height: 120,
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
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      'Arc Yazılım',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: Text(
                      name + '-' + surname,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
                          onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SlidingUp(),
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
                      width: 150,
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
                              borderRadius: new BorderRadius.circular(5.0))),
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
                              borderRadius: new BorderRadius.circular(5.0))),
                    ),
                    SizedBox(
                      width: 150,
                      child: OutlineButton(
                          onPressed: () =>  Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PortList(),
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: <Widget>[
                              Icon(
                                Icons.emoji_transportation_rounded,
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
                                    'Durak Listesi',
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
                          onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LastTravel())),
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: <Widget>[
                              Icon(
                                Icons.local_taxi,
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
                                    'Hareketlerim',
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
                          onPressed: (){
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
                          onPressed: () =>  destroySession(context),
                               
                              
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
