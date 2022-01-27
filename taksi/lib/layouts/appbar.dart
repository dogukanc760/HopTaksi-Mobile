import 'package:flutter/material.dart';

class AppBarSide extends StatefulWidget {
  const AppBarSide({Key key}) : super(key: key);

  @override
  _AppBarSideState createState() => _AppBarSideState();
}

class _AppBarSideState extends State<AppBarSide> {

  @override
  Widget build(BuildContext context) {
    return Container(
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

class _DrawerSideState extends State<DrawerSide> {
  @override
  Widget build(BuildContext context) {
    return  Container(
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

