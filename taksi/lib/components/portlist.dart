import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:taksi/layouts/appbar.dart';

class PortList extends StatefulWidget {
  const PortList({Key key}) : super(key: key);

  @override
  _PortListState createState() => _PortListState();
}

int count = 0;

class _PortListState extends State<PortList> {
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
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Content(),
        ),
      ),
    ));
  }
}

class Content extends StatefulWidget {
  const Content({Key key}) : super(key: key);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        count > 1
            ? Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 170,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 9,
                            blurRadius: 35,
                            offset: Offset(0, 7),
                            color: Colors.grey,
                          )
                        ]),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(24),
                                    boxShadow: [
                                      BoxShadow(
                                        spreadRadius: 9,
                                        blurRadius: 55,
                                        offset: Offset(0, 7),
                                        color: Colors.amber,
                                      )
                                    ]),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Text('Taksi Durak Adı',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ),
                                SizedBox(
                                    height: 25,
                                    child: RatingBar.builder(
                                      initialRating: 3,
                                      itemCount: 5,
                                      itemSize: 25,
                                      itemBuilder: (context, index) {
                                        switch (index) {
                                          case 0:
                                            return Icon(
                                              Icons.sentiment_very_dissatisfied,
                                              color: Colors.red,
                                            );
                                          case 1:
                                            return Icon(
                                              Icons.sentiment_dissatisfied,
                                              color: Colors.redAccent,
                                            );
                                          case 2:
                                            return Icon(
                                              Icons.sentiment_neutral,
                                              color: Colors.amber,
                                            );
                                          case 3:
                                            return Icon(
                                              Icons.sentiment_satisfied,
                                              color: Colors.lightGreen,
                                            );
                                          case 4:
                                            return Icon(
                                              Icons.sentiment_very_satisfied,
                                              color: Colors.green,
                                            );
                                        }
                                      },
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    )),
                              ],
                            ),
                            TextButton.icon(
                                onPressed: null,
                                icon: Icon(Icons.chat_outlined,
                                    color: Colors.amber, size: 26),
                                label: Text('20',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19,
                                        color: Colors.black54)))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 60,
                              transform:
                                  Matrix4.translationValues(-36.0, -5.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: RaisedButton(
                                  onPressed: () {},
                                  splashColor: Colors.yellowAccent,
                                  textColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 0),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Colors.amber,
                                        width: 1,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  color: Colors.amber,
                                  child: Text(
                                    'Hız\n9.9',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 60,
                              transform:
                                  Matrix4.translationValues(-33.0, -5.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: RaisedButton(
                                  onPressed: () {},
                                  splashColor: Colors.yellowAccent,
                                  textColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 0),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Colors.amber,
                                        width: 1,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  color: Colors.amber,
                                  child: Text(
                                    ' Hizmet\n 9.9',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 60,
                              transform:
                                  Matrix4.translationValues(-30.0, -5.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: RaisedButton(
                                  onPressed: () {},
                                  splashColor: Colors.yellowAccent,
                                  textColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 0),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Colors.amber,
                                        width: 1,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  color: Colors.amber,
                                  child: Text(
                                    'Konfor\n9.9',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 90,
                              transform:
                                  Matrix4.translationValues(30.0, -5.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: RaisedButton(
                                  onPressed: () {},
                                  splashColor: Colors.yellowAccent,
                                  textColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 0),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Colors.amber,
                                        width: 1,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  color: Colors.amber,
                                  child: Text(
                                    'Taksileri\n  İncele',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
              )
            : Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 150, 10, 0),
                child: Text(
                    'Seçimlerinize Göre Yakınlarınızda Taksi Durağı bulunmamaktadır.', style:TextStyle(color:Colors.black, fontSize:24, fontWeight:FontWeight.bold)),
              ),
            )
      ],
    ));
  }
}
